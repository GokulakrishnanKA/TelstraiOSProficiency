import UIKit

extension UIViewController {
  // it show alert controller on main window with ok button only
  static func showAlertMessage(withTitle title: String, withMessage message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okAction)

    DispatchQueue.main.async {
      if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
        appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
      }
    }
  }
}
