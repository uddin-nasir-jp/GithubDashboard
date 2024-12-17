@testable import GithubDashboard
import Combine
import Foundation

@Observable
final class MockUserService: UserServiceProtocol {
    
    var mockUsers: [GitHubUser] = []
    var mockError: NetworkError?
    
    func fetchUsers(page: Int, perPage: Int) -> AnyPublisher<[GitHubUser], NetworkError> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just(mockUsers)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchUserDetails(username: String) -> AnyPublisher<GitHubUser, NetworkError> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        let userDetails = GitHubUser.testData
        return Just(userDetails)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
