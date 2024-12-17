
import Foundation
import Combine

@Observable
class GitHubUserViewModel {
    // MARK: - PROPERTIES
    var githubUserList: [GitHubUser] = []
    var isLoading: Bool = false
    var errorMessage: String?
    private var currentPage: Int = 1
    private let perPage: Int = 30
    private let userService: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    // MARK: - Fetches the next set of users (with pagination).
    func fetchUsers() {
        guard !isLoading else { return }
        isLoading = true
        
        userService.fetchUsers(page: currentPage, perPage: perPage)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
                self?.isLoading = false
            } receiveValue: { [weak self] users in
                self?.githubUserList.append(contentsOf: users)
                //self?.fetchUserDetails(for: users) // Fetch details after getting users
                self?.currentPage += 1
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Fetches details for a list of users concurrently using Publisher.mergeMany and collects the results.
    private func fetchUserDetails(for users: [GitHubUser]) {
        let userDetailsPublishers = users.map { user in
            userService.fetchUserDetails(username: user.login)
                .map { userDetails -> GitHubUser in
                    return userDetails
                }
                .catch { _ in Just(user) } // In case of error, fallback to original user data
                .eraseToAnyPublisher()
        }
        
        Publishers.MergeMany(userDetailsPublishers)
            .collect() // Collect all emitted values into an array.
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] updatedUsers in
                // Now that we have all the updated users, update the user list
                //self?.githubUserList = updatedUsers
                updatedUsers.forEach { updatedUser in
                    if let index = self?.githubUserList.firstIndex(where: { $0.login == updatedUser.login }) {
                        self?.githubUserList[index] = updatedUser
                    }
                }
            }
            .store(in: &cancellables)
    }
}
