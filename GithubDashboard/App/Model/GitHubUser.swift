
struct GitHubUser: Identifiable, Decodable, Equatable {
    let id: Int
    let login: String
    let name: String?
    let bio: String?
    let avatar_url: String
    let public_repos: Int?
    let followers: Int?
    let following: Int?
    let html_url: String?
}

extension GitHubUser {
    static var testData: GitHubUser {
        GitHubUser(
            id: 1,
            login: "test-user",
            name: "Test User",
            bio: "Software Enginner",
            avatar_url: "https://avatars.githubusercontent.com/u/31?v=4",
            public_repos: 50,
            followers: 100,
            following: 200,
            html_url: "https://github.com/uddin-nasir-jp"
        )
    }
}

extension GitHubUser {
    static var testDataList: [GitHubUser] {
        [
            GitHubUser(
                id: 1,
                login: "user1",
                name: "Test User 1",
                bio: "Software Enginner",
                avatar_url: "https://github.com/images/error/octocat_happy.gif",
                public_repos: 50,
                followers: 100,
                following: 200,
                html_url: "https://github.com/uddin-nasir-jp"
            ),
            GitHubUser(
                id: 1,
                login: "user2",
                name: "Test User 2",
                bio: "Software Enginner",
                avatar_url: "https://github.com/images/error/octocat_happy.gif",
                public_repos: 40,
                followers: 10,
                following: 400,
                html_url: "https://github.com/uddin-nasir-jp-2"
            )
        ]
    }
}
