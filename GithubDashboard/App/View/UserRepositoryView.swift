
import SwiftUI

struct UserRepositoryView: View {
    // MARK: - PROPERTIES
    var githubUser: GitHubUser
    var repositoryViewModel: RepositoryViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // MARK: - User Information
                    HStack {
                        AsyncImage(url: URL(string: githubUser.avatar_url)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                                .frame(width: 100, height: 100)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(githubUser.login)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            if let bio = githubUser.bio {
                                Text(bio)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack {
                                Text("Repos: \(githubUser.public_repos ?? 0)")
                                Text("Followers: \(githubUser.followers ?? 0)")
                                Text("Following: \(githubUser.following ?? 0)")
                            }
                            .font(.caption)
                        }
                    }
                    
                    Divider()
                    
                    //MARK: - Repository List
                    VStack(alignment: .leading) {
                        Text("Repositories")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom, 8)
                        if !repositoryViewModel.repositories.isEmpty {
                            ForEach(repositoryViewModel.repositories) { repository in
                                NavigationLink(destination: RepositoryWebView(url: repository.html_url)) {
                                    RepositoryItemView(repository: repository)
                                }
                            }
                        } else if let errorMessage = repositoryViewModel.errorMessage {
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding()
                        } else {
                            ProgressView("Loading...")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            if repositoryViewModel.repositories.isEmpty {
                repositoryViewModel.fetchRepositories(for: githubUser.login)
            }
        }
        .navigationTitle(githubUser.login)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let repositoryService = RepositoryService(networkService: NetworkServiceManager())
    UserRepositoryView(githubUser: GitHubUser.testData, repositoryViewModel: RepositoryViewModel(repositoryService: repositoryService))
}
