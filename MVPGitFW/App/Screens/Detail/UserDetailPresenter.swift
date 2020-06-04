
//  Created by rasul on 3/25/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

protocol UserDetailViewProtocol: class {
	func success(user: User)
	func failure(error: Error)
	func presentSafariVC(urlString: String)
}

protocol UserDetailViewPresenterProtocol: class {
	init(view: UserDetailViewProtocol, user: FollowerProtocol, service: DateFetcherServiceProtocol, router: UserDetailRouterProtocol)
	func getUser()
	func buttonTapped()
	func showDetai()
	func presentSafariVC()
}

class UserDetailPresenter: UserDetailViewPresenterProtocol {
	weak var view: UserDetailViewProtocol?
	let user: FollowerProtocol
	var router: UserDetailRouterProtocol
	let service: DateFetcherServiceProtocol
	
	private var urlString = ""
	
	required init(view: UserDetailViewProtocol, user: FollowerProtocol, service: DateFetcherServiceProtocol, router: UserDetailRouterProtocol) {
		self.view = view
		self.user = user
		self.router = router
		self.service = service
	}
	
	func getUser() {
		service.fetchItemDetail(endpoint: .userDetail(with: user.login)) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let user):
				DispatchQueue.main.async {
					guard let user = user else { return }
					self.urlString = user.htmlUrl
					self.view?.success(user: user)
				}
			case .failure(let error):
				DispatchQueue.main.async {
					self.view?.failure(error: error)
				}
			}
		}
	}
	
	func buttonTapped() {
		router.popToRoot()
	}
	
	func showDetai() {
		router.pushDetail(user.login)
	}
	
	func presentSafariVC() {
		view?.presentSafariVC(urlString: urlString)
	}
}
