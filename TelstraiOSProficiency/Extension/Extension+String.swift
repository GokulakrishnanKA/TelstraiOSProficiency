import Foundation

extension String {

  /// Convert JSON string to Dictionary
  /// - Returns: Dictionary (Optional)
  func convertToDictionary() -> [String: Any]? {
    if let data = self.data(using: .utf8) {
      if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
        return jsonObject
      }

      return nil
    }

    return nil
  }
}
