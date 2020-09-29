import UIKit
import SDWebImage

class ItemCell: UITableViewCell {

  // MARK: - Properties

  static let classIdentifier = "ItemCell"

  let itemTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
    label.textAlignment = .left
    return label
  }()

  let itemDescription: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .left
    return label
  }()

  let itemImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 10.0
    imageView.layer.masksToBounds = true
    return imageView
  }()

  // MARK: - Lifecycle Methods

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    configureCell()
  }

  // MARK: - Private Methods

  /// Function to configure cell UI
  private func configureCell() {

    selectionStyle = .none

    addSubview(itemImageView)
    addSubview(itemTitle)
    addSubview(itemDescription)

    setItemImageViewConstraints()
    setItemTitleLabelConstraints()
    setItemDescriptionLabelConstraints()
  }

   /// Function to display data on cell
   /// - Parameter record: Fact record passed from view controller
   func prepareCellForDisplay(record: Item) {
     itemTitle.text = record.title ?? ""
     itemDescription.text = record.rowDescription ?? " "
     itemImageView.sd_setImage(with: URL(string: record.imageHref ?? ""),
                               placeholderImage: UIImage(named: "placeHolderImage"))
   }

  /// Get font size as per device
  /// - Returns: Font size in CGFloat
  private func getFontSize() -> CGFloat {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return FontSizeEnum.iPadImageWidthHeight.rawValue
    } else {
      return FontSizeEnum.iPhoneImageWidthHeight.rawValue
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Extension for setting constraints on views
extension ItemCell {

  /// Constraints for itemImageView
  private func setItemImageViewConstraints() {
    itemImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.init(item: itemImageView, attribute: .leading, relatedBy: .equal,
                            toItem: self, attribute: .centerX, multiplier: 10/187.5, constant: 0).isActive = true
    NSLayoutConstraint.init(item: itemImageView, attribute: .bottom, relatedBy: .lessThanOrEqual,
                            toItem: self, attribute: .bottom, multiplier: 1, constant: -10).isActive = true
    itemImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
    itemImageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
    itemImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
  }

  /// Constraints for itemTitle
  private func setItemTitleLabelConstraints() {
    itemTitle.translatesAutoresizingMaskIntoConstraints = false
    itemTitle.topAnchor.constraint(equalTo: itemImageView.topAnchor).isActive = true
    itemTitle.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10).isActive = true

    NSLayoutConstraint.init(item: itemTitle, attribute: .trailing, relatedBy: .equal,
                            toItem: self, attribute: .centerX, multiplier: 365/187.5, constant: 0).isActive = true
  }

  /// Constraints for itemDescription
  private func setItemDescriptionLabelConstraints() {
    itemDescription.translatesAutoresizingMaskIntoConstraints = false

    itemDescription.leadingAnchor.constraint(equalTo: itemTitle.leadingAnchor).isActive = true
    itemDescription.trailingAnchor.constraint(equalTo: itemTitle.trailingAnchor).isActive = true
    itemDescription.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: 5.0).isActive = true
    itemDescription.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10.0).isActive = true
  }
}
