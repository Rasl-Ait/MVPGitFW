
//  Created by rasul on 3/30/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

protocol UserDetailRouterProtocol {
	func popToRoot()
	func pushDetail(_ login: String)
}

class UserDetailRouter: UserDetailRouterProtocol {
	
	private weak var viewController: UserDetailViewController?
	
	init(viewController: UserDetailViewController) {
		self.viewController = viewController
	}
	
	func popToRoot() {
		viewController?.navigationController?.dismiss(animated: true, completion: nil)
		
	}
	
	func pushDetail(_ login: String) {
		let configurator = UsersListConfigurator(login: login)
		let usersController = UsersListViewController()
		usersController.configurator = configurator
		viewController?.navigationController?.pushViewController(usersController, animated: true)
	}
}
