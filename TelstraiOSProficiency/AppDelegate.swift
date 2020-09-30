import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    // Add navigation controller to window and add ViewController as root view controller to navigation controller
    window = UIWindow(frame: UIScreen.main.bounds)
    let mainVC = ItemsController()
    let navigationController = UINavigationController(rootViewController: mainVC)
    // set navigation bar title and tint color
    navigationController.navigationBar.barTintColor = UIColor(red: 36.0/255.0, green: 92.0/255.0, blue: 191.0/255.0, alpha: 1)
    navigationController.navigationBar.titleTextAttributes =
    [NSAttributedString.Key.foregroundColor: UIColor.white]
    // set window root view controller
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.backgroundColor = UIColor.white
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    return true
  }
}
