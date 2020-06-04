
//  Created by rasul on 4/13/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

protocol FavoritesRouterProtocol {
	func pushDetailModule(_ user: FollowerProtocol)
}

class FavoritesRouter: FavoritesRouterProtocol {
	private weak var viewController: FavoritesViewController?
	
	init(viewController: FavoritesViewController) {
		self.viewController = viewController
	}
	
	func pushDetailModule(_ user: FollowerProtocol) {
		let configurator = UserDetailConfigurator(user: user)
		let userDetailController = UserDetailViewController()
		userDetailController.configurator = configurator
		viewController?.navigationController?.pushViewController(userDetailController, animated: true)
	}
}
