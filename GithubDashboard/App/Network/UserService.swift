import Combine

protocol UserServiceProtocol {
    func fetchUsers(page: Int, perPage: Int) -> AnyPublisher<[GitHubUser], NetworkError>
    func fetchUserDetails(username: String) -> AnyPublisher<GitHubUser, NetworkError>
}

class UserService: UserServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchUsers(page: Int, perPage: Int) -> AnyPublisher<[GitHubUser], NetworkError> {
        let endpoint = APIEndpoint(path: APIConstants.users, method: .get, queryParameters: ["page": "\(page)", "per_page": "\(perPage)"])
        
        return networkService.performRequest(endpoint, responseType: [GitHubUser].self)
    }
    
    func fetchUserDetails(username: String) -> AnyPublisher<GitHubUser, NetworkError> {
        let endpoint = APIEndpoint(path: APIConstants.userDetails(username: username), method: .get)
        
        return networkService.performRequest(endpoint, responseType: GitHubUser.self)
    }
}
