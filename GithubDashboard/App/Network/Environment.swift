
enum BuldEnvironment {
    case development
    case staging
    case production

    var baseURL: String {
        switch self {
        case .development: return "https://api.github.com"
        case .staging: return "https://staging.api.github.com"
        case .production: return "https://api.github.com"
        }
    }
}
