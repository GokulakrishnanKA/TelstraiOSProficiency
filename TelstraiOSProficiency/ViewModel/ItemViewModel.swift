import Foundation

enum ItemsError: Error {
  case noItemsAvailable
  case inValidData
}

typealias GetItemsDataCompletionHandler = (Result<ItemModel, ItemsError>) -> Void

struct ItemViewModel {
  var itemsArray: [Item]
  var title: String
  let itemsAPI: String

  init(_ apiURL: String) {
    itemsAPI = apiURL
    itemsArray = []
    title = ""
  }

  mutating func updateItemArray(_ array: [Item]) {
    itemsArray = array
  }

  /// Function to get facts data
  /// - Parameter completion: Code block to be executed after API is executed
  /// - Returns: Void
  func getItemsFromAPI(completion: @escaping GetItemsDataCompletionHandler) {
    if NetworkHandler().isNetworkConnectionAvailable() {
      WebServiceHandler.getAPI(url: itemsAPI) { (data) in
        guard let data = data else {
          completion(.failure(.inValidData))
          return
        }

        if let response = ItemsDataParser().parseItems(data: data, convertToModel: ItemModel.self) {
          completion(.success(response))
        } else {
          completion(.failure(.inValidData))
        }
      }
    } else {
      print("No internet connectivity available.")
    }
  }
}
