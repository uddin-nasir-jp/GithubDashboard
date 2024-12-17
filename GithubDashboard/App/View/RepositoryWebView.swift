
import SwiftUI

struct RepositoryWebView: View {
    let url: String

    var body: some View {
        if let validURL = URL(string: url) {
            WebView(url: validURL)
                .navigationTitle("Repository")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            Text("Invalid URL")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
