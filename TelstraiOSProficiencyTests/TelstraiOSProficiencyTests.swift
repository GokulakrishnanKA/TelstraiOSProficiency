import XCTest
@testable import TelstraiOSProficiency

class TelstraiOSProficiencyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIResponse() {
      let bundle = Bundle(for: type(of: self))

      guard let path = bundle.url(forResource: "APIResponse", withExtension: "json") else {
          XCTFail("Missing file: APIResponse.json")
          return
      }

      do {
        let data = try Data(contentsOf: path, options: .mappedIfSafe)
        guard let factsObject = try? JSONDecoder().decode(ItemModel.self, from: data) else { return }

        XCTAssertNotNil(factsObject)
        XCTAssertNotNil(factsObject.rows)

        if let rows = factsObject.rows {
          XCTAssertEqual(rows.count, 14)
        }
      } catch {
        // handle error
      }
    }

    func testItemModelStructure() throws {
      let noItemModel = ItemModel(title: "About Canada", rows: [])

      XCTAssertNotNil(noItemModel)
      XCTAssertEqual(noItemModel.title, "About Canada")
      XCTAssertNotNil(noItemModel.rows)
      XCTAssertEqual(noItemModel.rows!.count, 0)

      let sampleTitle = "Transportation"
      let sampleDescription = """
                              It is a well known fact that polar bears are the main mode of
                              transportation in Canada. They consume far less gas and have the
                              added benefit of being difficult to steal.
                              """
      let sampleImageURL = """
                            http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/
                            U89miaCkcyo/s400/the_golden_compass_still.jpg
                            """

      let itemModel = ItemModel(
        title: "About Canada",
        rows: [
          Item(title: sampleTitle, rowDescription: sampleDescription, imageHref: sampleImageURL)
        ]
      )

      XCTAssertNotNil(itemModel)
      XCTAssertEqual(itemModel.rows!.count, 1)
      XCTAssertEqual(itemModel.rows![0].title, sampleTitle)
      XCTAssertEqual(itemModel.rows![0].rowDescription, sampleDescription)
      XCTAssertEqual(itemModel.rows![0].imageHref, sampleImageURL)
    }

    func testInternetConnectivity() throws {
      let connectionStatus = NetworkHandler().isNetworkConnectionAvailable()
      XCTAssertTrue(connectionStatus)
    }
}
