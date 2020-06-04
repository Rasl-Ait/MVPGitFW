
//  Created by rasul on 5/20/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

protocol UserDetailConfiguratorProtocol {
	func configure(_ viewController: UserDetailViewController)
}

class UserDetailConfigurator: UserDetailConfiguratorProtocol {
	
	let user: FollowerProtocol
	
	init(user: FollowerProtocol) {
		self.user = user
	}
	
	func configure(_ viewController: UserDetailViewController) {
		let router = UserDetailRouter(viewController: viewController)
		let service = DataFetcherService()
		let presenter = UserDetailPresenter(view: viewController, user: user, service: service, router: router)
		viewController.presenter = presenter
	}
}
