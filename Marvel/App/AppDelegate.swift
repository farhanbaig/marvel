import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavbar()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let viewModel = ListViewModel(characterfetcher: CharacterFetcher(), squadFetcher: SquadFetcher())
        window?.rootViewController = UINavigationController(rootViewController: CharacterListViewController(viewModel: viewModel))
        return true
    }
}


extension AppDelegate {
    // SETUP NAVBAR
    private func setupNavbar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.darkBackground
        appearance.shadowColor = UIColor.lightBackground
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance}
}

