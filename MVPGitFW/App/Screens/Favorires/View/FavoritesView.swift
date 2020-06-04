
//  Created by rasul on 4/16/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit
import RealmSwift

protocol FavoritesViewDelegate: AnyObject {
	func onDidSelectCell(row: Int)
	func onDeleteItems(row: Int)
}

class FavoritesView: UIView {
	let tableView = UITableView(frame: .zero, style: .plain)
	
	private var items: Results<UserModel>?
	
	private var dataSource = GenericRealmDataSource<UserCell, UserModel>()
	private var token: NotificationToken?
	
	typealias ConfigureUserCell = ((UserCellView, UserModel) -> Void)
	
	weak var delegate: FavoritesViewDelegate?
	var confugureCell: ConfigureUserCell?
	
	convenience init() {
		self.init(frame: .zero)
		setupUI()
	}
	
	private func setupUI() {
		setupTableView()
		setupDatasource()
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
	
	func addItems(_ items: Results<UserModel>) {
    dataSource.addItems(items, in: self.tableView)
		self.items = items
		tableView.reloadData()
	}
	
	func observerRealm() {
		token = self.items?.observe { [weak tableView] changes in
			guard let tableView = tableView else { return }
			
			switch changes {
			case .initial:
				tableView.reloadData()
			case .update(_, let deletions, let insertions, let updates):
				tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
			case .error:
				break
			}
		}
	}
	
	func setupDatasource() {
		dataSource.onConfigureCell = { [weak self] cell, model in
			guard let self = self else { fatalError(" ") }
			self.confugureCell?(cell, model)
			return cell
		}
		
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
		
		self.dataSource.cellHeight = {
			return UserCell.height
		}
		
		self.dataSource.onDidSelectCell = { [weak self ]  index in
			guard let self = self else { fatalError(" ") }
			self.delegate?.onDidSelectCell(row: index)
		}
		
		dataSource.onDeleteItems = { [weak self ]  index in
			guard let self = self else { fatalError(" ") }
			self.delegate?.onDeleteItems(row: index)
		}
		
		tableView.estimatedRowHeight = 100
		tableView.registerDelegate(with: dataSource)
		tableView.register(UserCell.self)
	}
}
