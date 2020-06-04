
//  Created by rasul on 3/30/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

protocol SearchViewRouterProtocol {
	func showDetail(login: String)
}

class SearchRouter: SearchViewRouterProtocol {
	private weak var viewController: SearchViewController?
	
	init(viewController: SearchViewController) {
		self.viewController = viewController
	}
	
	func showDetail(login: String) {
		let configurator = UsersListConfigurator(login: login)
		let usersController = UsersListViewController()
		usersController.configurator = configurator
		viewController?.navigationController?.pushViewController(usersController, animated: true)
	}
}
