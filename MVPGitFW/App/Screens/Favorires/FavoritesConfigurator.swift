
//  Created by rasul on 4/14/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

protocol FavoritesConfiguratorProtocol {
	func configure(_ viewController: FavoritesViewController)
}

class FavoritesConfigurator: FavoritesConfiguratorProtocol {
	func configure(_ viewController: FavoritesViewController) {
		let manager = RealmManager()
		let router = FavoritesRouter(viewController: viewController)
		let presenter = FavoritesPresenter(view: viewController, manager: manager, router: router)
		viewController.presenter = presenter
	}
}
