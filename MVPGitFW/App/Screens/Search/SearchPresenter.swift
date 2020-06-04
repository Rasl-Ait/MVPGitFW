
//  Created by rasul on 3/30/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

protocol SearchViewProtocol: class { }

protocol SearchViewPresenterProtocol: class {
	init(view: SearchViewProtocol, router: SearchViewRouterProtocol)
	func buttonTapped(login: String)
}

class SearchViewPresenter: SearchViewPresenterProtocol {

	weak var view: SearchViewProtocol?
	var router: SearchViewRouterProtocol?
	
	required init(view: SearchViewProtocol, router: SearchViewRouterProtocol) {
		self.view = view
		self.router = router
	}
	
	func buttonTapped(login: String) {
		router?.showDetail(login: login)
	}
}
