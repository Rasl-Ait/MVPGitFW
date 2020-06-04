
//  Created by rasul on 3/30/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

protocol SearchConfiguratorProtocol {
	func configure(_ viewController: SearchViewController)
}

class SearchConfigurator: SearchConfiguratorProtocol {
	func configure(_ viewController: SearchViewController) {
		let router = SearchRouter(viewController: viewController)
		let presenter = SearchViewPresenter(view: viewController, router: router)
		viewController.presenter = presenter
	}
}
