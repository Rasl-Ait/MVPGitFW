
//  Created by rasul on 3/28/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

protocol UsersListViewDelegate: AnyObject {
	func fetchItems()
	func openUserDetailsView(row: Int)
}

class UsersListView: UIView {
	let tableView = UITableView(frame: .zero, style: .plain)
	
	private var dataSource = GenericTableViewDataSource<Follower, UserCell>()
	
	typealias ConfigureUserCell = ((UserCellView, Follower) -> Void)
	
	weak var delegate: UsersListViewDelegate?
	var confugureCell: ConfigureUserCell?
	
	convenience init() {
		self.init(frame: .zero)
		setupUI()
	}
	
	private func setupUI() {
		setupTableView()
		setupDataSource()
	}
	
	func setupTableView() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorStyle = .none
		addSubview(tableView)
		
		[
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor)].forEach { $0.isActive = true }
	}
	
	func searchText(text: String) {
		dataSource.search(query: text, tableView: tableView)
		
	}
	
	func addUsers(_ users: [FollowerProtocol]) {
		self.dataSource.addItems(users as! [Follower], in: self.tableView)
		tableView.reloadData()
	}

	private func setupDataSource() {
		
		dataSource.onConfigureCell = { [weak self] cell, model in
			guard let self = self else { fatalError(" ") }
			self.confugureCell?(cell, model)
			return cell
		}
		
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
		
		self.dataSource.fetchItems = { [weak self] in
			guard let self = self else { return }
			self.delegate?.fetchItems()
		}
		
		self.dataSource.cellHeight = {
			return UserCell.height
		}
		
		self.dataSource.onDidSelectCell = { [weak self ] index in
			guard let self = self else { fatalError(" ") }
			self.delegate?.openUserDetailsView(row: index)
		}
		
		self.tableView.estimatedRowHeight = 100
		
		tableView.registerDelegate(with: dataSource)
		tableView.register(UserCell.self)
	}
}
