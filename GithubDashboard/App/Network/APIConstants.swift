
struct APIConstants {
    static let environment = Environment.development

    static var baseURL: String {
        return environment.baseURL
    }
    
    static let ACCESS_TOKEN = "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"
    
    static let users = "/users"
    
    static func userDetails(username: String) -> String {
        return "/users/\(username)"
    }
    
    static func userRepositories(username: String) -> String {
        return "/users/\(username)/repos"
    }
}