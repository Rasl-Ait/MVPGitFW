
//  Created by rasul on 4/13/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoriteViewProtocol: class {
	func success(items: Results<UserModel>)

}

protocol FavoritesPresenterProtocol: class {
	var router: FavoritesRouterProtocol { get }
	func fetchItems()
	func delete(row: Int)
	func configureItemCell(cell: UserCellView, for item: UserModel?)
	func pushDetail(row: Int)
}

class FavoritesPresenter<T: RealmManagerProtocol>: FavoritesPresenterProtocol {
	private(set)var items: Results<UserModel>?

	weak var view: FavoriteViewProtocol?
	var router: FavoritesRouterProtocol
	
	let manager: T
	
	required init(view: FavoriteViewProtocol, manager: T, router: FavoritesRouterProtocol) {
		self.view = view
		self.manager = manager
		self.router = router
	}
	
	func fetchItems() {
		let items = manager.fetchItems(ofType: UserModel.self)
		self.items = items
		view?.success(items: items)
	}
	
	func delete(row: Int) {
		guard let user = items?[row] else { fatalError( " " ) }
		manager.detete(user)
	}
	
	func configureItemCell(cell: UserCellView, for item: UserModel?) {
		guard let item = item else { return }
		cell.displayLogin(login: item.login)
		cell.displayImage(image: item.avatarUrl)
		cell.displayType(type: item.type)
	}
	
	func pushDetail(row: Int) {
		guard let user = items?[row] else { fatalError( " " ) }
		router.pushDetailModule(user)
	}
}
