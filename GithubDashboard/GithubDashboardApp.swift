
import SwiftUI

@main
struct GithubDashboardApp: App {
    let userService = UserService(networkService: NetworkServiceManager())

    var body: some Scene {
        WindowGroup {
            GitHubUserListView(userViewModel: GitHubUserViewModel(userService: userService))
                .environment(\.logger, ConsoleLogger())
        }
    }
}
