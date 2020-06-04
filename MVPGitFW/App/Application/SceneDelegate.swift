
//  Created by rasul on 3/25/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.makeKeyAndVisible()
		let tabBarController = BaseTabBarViewController()
		window?.rootViewController = tabBarController
		
		setupBaseUI()
		
		var config = Realm.Configuration()
		config.deleteRealmIfMigrationNeeded = true
		Realm.Configuration.defaultConfiguration = config
	}
	
	func setupBaseUI() {
		let tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
		
		let backImage = UIImage(named: "BackButton")
		
		UINavigationBar.appearance().backIndicatorImage = backImage
		UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
		UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(
			UIOffset(horizontal: -1000, vertical: 0), for: UIBarMetrics.default)
		
		let ui = UINavigationBar.appearance()
		ui.tintColor = tintColor
		ui.isTranslucent = true
		ui.titleTextAttributes =
			[NSAttributedString.Key.foregroundColor: tintColor,
			 NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Bold", size: 23) as Any
		]
		
		if #available(iOS 11.0, *) {
			ui.prefersLargeTitles = false
			ui.largeTitleTextAttributes = [
				NSAttributedString.Key.foregroundColor: tintColor,
				NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Bold", size: 23) as Any
			]
		}
	}

	func sceneDidDisconnect(_ scene: UIScene) {}
	
	func sceneDidBecomeActive(_ scene: UIScene) {}
	
	func sceneWillResignActive(_ scene: UIScene) {}
	
	func sceneWillEnterForeground(_ scene: UIScene) {}
	
	func sceneDidEnterBackground(_ scene: UIScene) {}
}
