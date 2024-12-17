
import SwiftUI

struct GitHubUserListView: View {
    // MARK: - PROPERTIES
    var userViewModel: GitHubUserViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if !userViewModel.githubUserList.isEmpty {
                    List(userViewModel.githubUserList) { user in
                        userListItemView(for: user)
                            .onAppear {
                                if user.login == userViewModel.githubUserList.last?.login {
                                    userViewModel.fetchUsers() // Fetch next page when last user appears
                                }
                            }
                    }
                } else if let errorMessage = userViewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("User List")
            .onAppear() {
                if userViewModel.githubUserList.isEmpty {
                    userViewModel.fetchUsers() // Initial data fetch
                }
            }
        }
    }
    
    @ViewBuilder
    private func userListItemView(for user: GitHubUser) -> some View {
        NavigationLink {
            let repositoryService = RepositoryService(networkService: NetworkServiceManager())
            UserRepositoryView(githubUser: user, repositoryViewModel: RepositoryViewModel(repositoryService: repositoryService))
        } label: {
            UserListItemView(user: user)
        }
    }
}

#Preview {
    GitHubUserListView(userViewModel: GitHubUserViewModel(userService: UserService(networkService: NetworkServiceManager())))
}
