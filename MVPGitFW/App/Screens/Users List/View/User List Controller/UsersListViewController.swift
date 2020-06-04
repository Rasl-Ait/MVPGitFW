
//  Created by rasul on 3/25/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

class UsersListViewController: BaseViewController {
	
	var configurator: UsersListConfiguratorProtocol!
	var presenter: UsersListViewPresenterProtocol!
  var searchController: UISearchController!
	
	lazy var userListView: UsersListView = {
		let view = UsersListView()
		view.delegate = self
		return view
	}()
	
	override func loadView() {
		view = userListView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
}

private extension UsersListViewController {
	func setupView() {
		configurator.configure(self)
		presenter.fetchItems()
		
		userListView.confugureCell = { [weak self] cell, model in
			guard let self = self else { return }
			let viewmodel = UserListViewModel(follower: model)
			self.presenter.configureUserCell(cell: cell, for: viewmodel)
		}
		setupNavigationBar()
		setUpSearchBar()
	}
	
	func setupNavigationBar() {
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(addBarButtonTapped)
		)
	}
	
	func setUpSearchBar() {
		let searchController = UISearchController()
		searchController.searchResultsUpdater = self
		searchController.searchBar.placeholder = "Search for a login"
		searchController.obscuresBackgroundDuringPresentation = false
		navigationItem.searchController = searchController
	}
	
	// MARK: - Selectors
	
	@objc func addBarButtonTapped() {
		presenter.addButtonPressed()
	}
}

// MARK: - UsersListViewProtocol

extension UsersListViewController: UsersListViewProtocol {
	func success(message: String) {
		showAlert(title: "Something went wrong", message: message)
	}
	func success(login: String) {
		showAlert(title: "User \(login)", message: "You have successfully favorited this user 🎉")
	}
	
	func showIndicator() {
		super.showLoadingView(userListView.tableView)
	}
	
	func hideIndicator() {
		super.hideLoadingView(userListView.tableView)
	}
	
	func success(items: [FollowerProtocol]) {
		userListView.addUsers(items)
		
	}
	
	func failure(error: Error) {
		showAlert(title: "Error", message: error.localizedDescription)
	}
}

// MARK: - UsersListViewDelegate

extension UsersListViewController: UsersListViewDelegate {
	func openUserDetailsView(row: Int) {
		presenter.didSelectRowAt(row: row)
	}
	
	func fetchItems() {
		guard presenter.isMoreItems else { return }
		presenter.page += 1
		presenter.fetchItems()
	}
}

// MARK: - UISearchResultsUpdating

extension UsersListViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		if let searchText = searchController.searchBar.text {
		userListView.searchText(text: searchText)
		}
	}
}
