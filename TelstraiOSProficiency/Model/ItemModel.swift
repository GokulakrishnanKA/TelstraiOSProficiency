import Foundation

struct ItemModel: Codable {
  var title: String?
  var rows: [Item]?
}

struct Item: Codable {
  var title, rowDescription: String?
  var imageHref: String?

  enum CodingKeys: String, CodingKey {
    case title
    case rowDescription = "description"
    case imageHref
  }
}
