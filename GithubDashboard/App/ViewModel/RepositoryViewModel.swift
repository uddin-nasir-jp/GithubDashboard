
import Foundation
import Combine

@Observable
final class RepositoryViewModel {
    // MARK: - PROPERTIES
    var repositories: [GitHubRepository] = []
    var isLoading = false
    var errorMessage: String?
    private var repositoryService: RepositoryServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private let perPage: Int = 30
    
    init(repositoryService: RepositoryServiceProtocol) {
        self.repositoryService = repositoryService
    }
    
    func fetchRepositories(for userName: String) {
        isLoading = true
        
        repositoryService.fetchUserRepositories(username: userName, page: currentPage, perPage: perPage)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { repositories in
                self.repositories.append(contentsOf: repositories)
                self.currentPage += 1
            })
            .store(in: &cancellables)
    }
}
