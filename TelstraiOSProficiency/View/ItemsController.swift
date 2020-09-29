import UIKit

class ItemsController: UIViewController {
  // MARK: - Properties
  private var viewModel: ItemViewModel = {
    return ItemViewModel.init(Constants.apiURL)
  }()

  let tableView: UITableView = {
    let tableView = UITableView()

    let footerViewFrame = CGRect(x: 0,
                                 y: 0,
                                 width: tableView.bounds.width,
                                 height: 30)
    let footerView = UIView(frame: footerViewFrame)

    footerView.backgroundColor = .white
    tableView.tableFooterView = footerView
    tableView.estimatedRowHeight = 200.0
    tableView.allowsSelection = false
    tableView.rowHeight = UITableView.automaticDimension
    return tableView
  }()

  private let refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = .gray
    refreshControl.addTarget(self, action: #selector(pullToRefersh(_:)), for: .valueChanged)
    return refreshControl
  }()

  // MARK: - Lifecycle Methods
    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .white
      view.addSubview(tableView)

      configureTableView()
      getItems()
  }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransition(to: size, with: coordinator)
      tableView.reloadData()
    }

    /// Function to get facts from API. It calls method on viewModel and returns data
    /// - Returns: Void
    private func getItems() {

      // Calling viewModel method to get facts data from API
      viewModel.getItemsFromAPI {[weak self] (result) in
        switch result {
        case .failure(.noItemsAvailable):
          break
        case .failure(.inValidData):
          break
        case .success(let itemsResponse):
          self?.viewModel.updateItemArray(itemsResponse.rows ?? [])
          DispatchQueue.main.async {[weak self] in
            guard let self = self else {
              return
            }
            self.title = itemsResponse.title ?? ""
            self.tableView.reloadData()
          }
        }
      }
    }

    // MARK: - Private Methods

    /// Configure tableView
    /// - Returns: Void
    private func configureTableView() {

      // Register cell in tableView
      tableView.register(
        ItemCell.self,
        forCellReuseIdentifier: ItemCell.classIdentifier)

      // Set tableView data source & delegate
      tableView.delegate = self
      tableView.dataSource = self

      // Add pull to refresh
      tableView.refreshControl = refreshControl

      // Set constraints
      addTableViewConstraints()
    }

    // MARK: - Selector Methods

    /// pullToRefersh function
    /// - Parameter refershControl: refershControl Object
    @objc private func pullToRefersh(_ refershControl: UIRefreshControl) {

      // Stopping pull to refresh
      refershControl.endRefreshing()
    }
}

// MARK: - UITableViewDelegate
extension ItemsController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.itemsArray.count
  }
}

// MARK: - UITableViewDataSource
extension ItemsController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.classIdentifier) as? ItemCell {
      let item = viewModel.itemsArray[indexPath.row]
      cell.prepareCellForDisplay(record: item)
      return cell
    }
    return UITableViewCell()
  }
}

// MARK: - Extension for setting constraints on views
extension ItemsController {

  /// Function to set tableView constraints
  /// - Returns: Void
  private func addTableViewConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
}
