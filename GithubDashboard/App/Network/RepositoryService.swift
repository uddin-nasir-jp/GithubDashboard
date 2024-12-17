import Combine

protocol RepositoryServiceProtocol {
    func fetchUserRepositories(username: String, page: Int, perPage: Int) -> AnyPublisher<[GitHubRepository], NetworkError>
}

class RepositoryService: RepositoryServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchUserRepositories(username: String, page: Int, perPage: Int) -> AnyPublisher<[GitHubRepository], NetworkError> {
        let endpoint = APIEndpoint(path: APIConstants.userRepositories(username: username), method: .get, queryParameters: ["page": "\(page)", "per_page": "\(perPage)"])
        
        return networkService.performRequest(endpoint, responseType: [GitHubRepository].self)
    }
}
