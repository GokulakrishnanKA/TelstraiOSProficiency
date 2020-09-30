import Foundation

class ItemsDataParser {

  /// Parsing API response
  /// - Parameters:
  ///   - data: Success data
  ///   - convertToModel: Type of model data should be converted into
  /// - Returns: Type of model described in convertToModel
  func parseItems<T: Decodable>(data: Data, convertToModel: T.Type) -> T? {
    guard let jsonData = String(decoding: data, as: UTF8.self).data(using: .utf8) else {
      return nil
    }

    guard let factsObject = try? JSONDecoder().decode(T.self, from: jsonData) else {
      return nil
    }

    return factsObject
  }
}
