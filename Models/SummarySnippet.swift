import Foundation

struct SummarySnippet: Identifiable, Equatable {
    let order: Int
    let text: String
    var id: Int { order }
}
