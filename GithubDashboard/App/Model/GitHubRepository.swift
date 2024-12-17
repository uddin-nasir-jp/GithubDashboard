
struct GitHubRepository: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let stargazers_count: Int
    let fork: Bool
    let forks_count: Int
    let html_url: String
}

extension GitHubRepository {
    static var testData: GitHubRepository {
        GitHubRepository(
            id: 1,
            name: "Hello-World",
            description: "This is your first repository",
            language: "Swift",
            stargazers_count: 100,
            fork: false,
            forks_count: 10,
            html_url: "https://github.com/apple/swift-org-docs/tree/main/docs/Hello-World"
        )
    }
}

extension GitHubRepository {
    static var testDataList: [GitHubRepository] {
        [
            GitHubRepository(
                id: 1,
                name: "Hello-World",
                description: "This is your first repository",
                language: "Kotlin",
                stargazers_count: 100,
                fork: false,
                forks_count: 10,
                html_url: "https://github.com/apple/swift-org-docs/tree/main/docs/Hello-World"
            ),
            GitHubRepository(
                id: 2,
                name: "Hello-World 2",
                description: "Hello-World repository example",
                language: "Swift",
                stargazers_count: 100,
                fork: false,
                forks_count: 10,
                html_url: "https://github.com/apple/swift-org-docs/tree/main/docs/Hello-World"
            )
        ]
    }
}
