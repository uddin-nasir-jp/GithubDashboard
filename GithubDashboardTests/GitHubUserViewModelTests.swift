import XCTest
@testable import GithubDashboard

@MainActor
final class GitHubUserViewModelTests: XCTestCase {
    var mockUserService: MockUserService!
    var viewModel: GitHubUserViewModel!

    override func setUp() {
        super.setUp()
        mockUserService = MockUserService()
        viewModel = GitHubUserViewModel(userService: mockUserService)
    }

    override func tearDown() {
        mockUserService = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() async throws {
        // Arrange
        let expectedUsers = GitHubUser.testDataList
        mockUserService.mockUsers = expectedUsers

        // fetch users
        viewModel.fetchUsers()

        // Assert
        XCTAssertEqual(viewModel.githubUserList.count, expectedUsers.count)
        XCTAssertEqual(viewModel.githubUserList.first?.login, "user1")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchUsersFailure() async throws {
        // Arrange
        let expectedError = NetworkError.mockNetworkError
        mockUserService.mockError = expectedError

        // fetch users
        viewModel.fetchUsers()

        // Assert
        XCTAssertTrue(viewModel.githubUserList.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
    }
}
