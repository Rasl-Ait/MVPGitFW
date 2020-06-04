
//  Created by rasul on 4/13/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
	
	var configurator: FavoritesConfiguratorProtocol!
	var presenter: FavoritesPresenterProtocol?
	
	lazy var favotiresView: FavoritesView = {
		let view = FavoritesView()
		view.delegate = self
		return view
	}()
	
	override func loadView() {
		view = favotiresView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.fetchItems()
			favotiresView.observerRealm()
	}
}

// MARK: - private FavoritesViewController

private extension FavoritesViewController {
	func setupView() {
		navigationController?.navigationBar.prefersLargeTitles = true
		configurator.configure(self)
		setupDataSource()
	}
	
	func setupDataSource() {
		favotiresView.confugureCell = { [weak self] cell, model in
			guard let self = self else { return }
			self.presenter?.configureItemCell(cell: cell, for: model)
		}
	}
}

// MARK: - FavoritesViewDelegate

extension FavoritesViewController: FavoritesViewDelegate {
	func onDeleteItems(row: Int) {
		presenter?.delete(row: row)
	}
	
	func onDidSelectCell(row: Int) {
		presenter?.pushDetail(row: row)
	}
}

// MARK: - FavoriteViewProtocol

extension FavoritesViewController: FavoriteViewProtocol {
	func success(items: Results<UserModel>) {
		favotiresView.addItems(items)
	}
}
