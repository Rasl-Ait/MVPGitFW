
//  Created by rasul on 3/30/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UITabBar.appearance().tintColor = .systemPurple
		
		let searchConfigurator = SearchConfigurator()
		let searchController = SearchViewController()
		searchController.configurator = searchConfigurator
		
		let searchTabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		searchController.tabBarItem = searchTabBarItem
		searchController.title = "Search"
		
		let favoritesConfigurator = FavoritesConfigurator()
		let favoritesController = FavoritesViewController()
		favoritesController.configurator = favoritesConfigurator
		
		let favoriteTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		favoritesController.tabBarItem = favoriteTabBarItem
		favoritesController.title = "Favorites"
		
		viewControllers = [searchController, favoritesController].map { UINavigationController(rootViewController: $0) }
	}
}
