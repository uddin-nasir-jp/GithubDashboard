
import SwiftUI

struct UserListItemView: View {
    var user: GitHubUser
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                AsyncImage(url: URL(string: user.avatar_url)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
                
                Text(user.login)
                    .font(.headline)
            }
            
            HStack {
                Text("Repos: \(user.public_repos ?? 0)")
                Text("Followers: \(user.followers ?? 0)")
                Text("Following: \(user.following ?? 0)")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    UserListItemView(user: GitHubUser.testData)
}
