import UIKit

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

    // Setting cell min height
    contentView.heightAnchor.constraint(
      greaterThanOrEqualToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 108 : 72).isActive = true
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
    itemImageView.contentMode = .scaleAspectFit

    let marginGuide = contentView.layoutMarginsGuide

    NSLayoutConstraint.activate([
        itemImageView.widthAnchor.constraint(
          equalToConstant: getFontSize()),
        itemImageView.heightAnchor.constraint(equalToConstant: getFontSize()),
        itemImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: -5),
        itemImageView.leftAnchor.constraint(equalTo: marginGuide.leftAnchor)
    ])
  }

  /// Constraints for itemTitle
  private func setItemTitleLabelConstraints() {

    let marginGuide = contentView.layoutMarginsGuide

    itemTitle.translatesAutoresizingMaskIntoConstraints = false
    itemTitle.numberOfLines = 0
    itemTitle.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10).isActive = true
    itemTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
    itemTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
  }

  /// Constraints for itemDescription
  private func setItemDescriptionLabelConstraints() {

    let marginGuide = contentView.layoutMarginsGuide
    itemDescription.translatesAutoresizingMaskIntoConstraints = false
    itemDescription.numberOfLines = 0
    itemDescription.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10).isActive = true
    itemDescription.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    itemDescription.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    itemDescription.topAnchor.constraint(equalTo: itemTitle.bottomAnchor).isActive = true
  }
}
