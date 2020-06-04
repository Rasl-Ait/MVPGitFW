
//  Created by rasul on 3/26/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

protocol UsersRouterProtocol {
	func showDetail(user: FollowerProtocol)
}

class UsersRouter: UsersRouterProtocol {
	private weak var viewController: UsersListViewController?
	
	init(viewController: UsersListViewController) {
		self.viewController = viewController
	}
	
	func showDetail(user: FollowerProtocol) {
		let configurator = UserDetailConfigurator(user: user)
		let userDetailController = UserDetailViewController()
		userDetailController.configurator = configurator
		viewController?.navigationController?.pushViewController(userDetailController, animated: true)
	}
}
