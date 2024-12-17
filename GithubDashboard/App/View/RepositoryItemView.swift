
import SwiftUI

struct RepositoryItemView: View {
    // MARK: - PROPERTIES
    var repository: GitHubRepository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(repository.name)
                .font(.headline)
            
            if let description = repository.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            
            HStack {
                if let language = repository.language {
                    Text("Language: \(language)")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                
                Text("⭐ \(repository.stargazers_count)")
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            Divider()
                .padding(.top, 4)
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    RepositoryItemView(repository: GitHubRepository.testData)
}
