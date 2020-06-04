
import Foundation
import UIKit

protocol UsersListConfiguratorProtocol {
	func configure(_ viewController: UsersListViewController)
}

class UsersListConfigurator: UsersListConfiguratorProtocol {
	
	var login: String!
	
	init(login: String) {
		self.login = login
	}
	
	func configure(_ viewController: UsersListViewController) {
		let service = DataFetcherService()
		let router = UsersRouter(viewController: viewController)
		let manager = RealmManager()
		let presenter = UsersListPresenter(
			view: viewController,
			login: login,
			service: service,
			router: router,
			manager: manager
		)
		viewController.title = login
		viewController.presenter = presenter
	}
}
