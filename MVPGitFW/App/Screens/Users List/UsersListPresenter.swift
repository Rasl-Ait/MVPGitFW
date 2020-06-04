
//  Created by rasul on 3/25/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

protocol UsersListViewProtocol: class {
	func success(items: [FollowerProtocol])
	func success(login: String)
	func success(message: String)
	func failure(error: Error)
	func showIndicator()
	func hideIndicator()
}

protocol UserCellView {
	func displayImage(image: String)
	func displayLogin(login: String)
	func displayType(type: String)
}

protocol UsersListViewPresenterProtocol: class {
	var router: UsersRouterProtocol { get }
	
	var users: [FollowerProtocol] { get }
	var login: String? { get }
	var page: Int { get set }
	var isMoreItems: Bool { get set }
	
	func fetchItems()
	func configureUserCell(cell: UserCellView, for item: UserListViewModel)
	func didSelectRowAt(row: Int)
	func addButtonPressed()
}

class UsersListPresenter: UsersListViewPresenterProtocol {
	
	private(set) var users = [FollowerProtocol]()
	
	var login: String?
	var page: Int = 1
	
	weak var view: UsersListViewProtocol?
	let service: DateFetcherServiceProtocol
	var router: UsersRouterProtocol
	let manager: RealmManagerProtocol
	
	var isMoreItems = true
	
	required init(
		view: UsersListViewProtocol,
		login: String?,
		service: DateFetcherServiceProtocol,
		router: UsersRouterProtocol,
		manager: RealmManagerProtocol) {
		
		self.view = view
		self.service = service
		self.router = router
		self.login = login
		self.manager = manager
	}
	
	func fetchItems() {
		self.view?.showIndicator()
		service.fetchItemsList(endpoint: .search(with: login ?? "", page: page)) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let items):
				DispatchQueue.main.async {
					guard let items = items else { return }
					self.users = items
					if items.count < 100 { self.isMoreItems = false }
					self.view?.success(items: items)
					self.view?.hideIndicator()
				}
			case .failure(let error):
				DispatchQueue.main.async {
					self.view?.failure(error: error)
				}
			}
		}
	}
	
	func addButtonPressed() {
		service.fetchItemDetail(endpoint: .userDetail(with: login ?? "")) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let item):
				guard let item = item else { return }
				let object = UserModel(id: item.id, login: item.login, avatarUrl: item.avatarUrl, type: item.type)
				if self.manager.filter(item: object) {
					self.view?.success(message: "You've already favorited this user.")
					return
				}
				self.manager.createItem(item: object)
				self.view?.success(login: item.login)
			case .failure(let error):
				DispatchQueue.main.async {
					self.view?.failure(error: error)
				}
			}
		}
	}
	
	func configureUserCell(cell: UserCellView, for item: UserListViewModel) {
		cell.displayImage(image: item.avatarUrl ?? "")
		cell.displayLogin(login: item.login ?? "")
		cell.displayType(type: item.type ?? "")
	}
	
	// MARK: - Action
	
	func didSelectRowAt(row: Int) {
		let user = users[row]
		router.showDetail(user: user)
	}
}
