
//  Created by rasul on 4/15/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

protocol GenericDataSourceProtocol {
	associatedtype Item
	
	var itemsList: [Item] { get set }
	
	//    func item(at: IndexPath) -> Item
	//    func add(item: Item, at: IndexPath)
	//    func replace(at indexPath: IndexPath, with item: Item)
	//    func remove(at indexPath: IndexPath)
}

class GenericTableViewDataSource<ItemType: Searchable, CellType: UITableViewCell>: BasicDataSource, GenericDataSourceProtocol {
	
	typealias CellConfiguration = ((_ cell: CellType, _ item: ItemType) -> CellType)
	
	var itemsList: [ItemType] = []
	var filterItemsList: [ItemType] = []
	var onConfigureCell: CellConfiguration?
	var onDidSelectCell: ItemClosure<Int>?
	var cellHeight: ItemClosureReturn<CGFloat>?
	var fetchItems: VoidClosure?
	
	private var isSearchActive: Bool = false
	
	func addItems(_ items: [ItemType], in tableView: UITableView) {
		guard !items.isEmpty else {
			return
		}
		
		let countBeforeInsert = self.itemsList.count
		self.itemsList.append(contentsOf: items)
		let countAfterInsert = countBeforeInsert + items.count
		let range = countBeforeInsert...countAfterInsert - 1
		let indices = range.map {
			IndexPath(row: $0, section: 0)
		}
		UIView.performWithoutAnimation {
			tableView.insertRows(at: indices, with: .none)
		}
	}
	
	// MARK: - UITableViewDataSource
	
	override func numberOfItems(in section: Int) -> Int {
		return isSearchActive ? filterItemsList.count :  itemsList.count
	}
	
	override func getTableViewCell(in tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		let cell: CellType = tableView.dequeueReusableCell(forIndexPath: indexPath)
		let model = getModelAt(indexPath)
		return onConfigureCell?(cell, model) ?? UITableViewCell()
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		onDidSelectCell?(indexPath.row)
	}
	
	override func getCellHeight(_ indexPath: IndexPath) -> CGFloat {
		return cellHeight?() ?? 44
	}
	
	private func getModelAt(_ indexPath: IndexPath) -> ItemType {
		return isSearchActive ? filterItemsList[indexPath.row] :  itemsList[indexPath.row]
	}
	
	// MARK: - UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let offset = 1
		if indexPath.row >= self.itemsList.count - offset {
			self.fetchItems?()
		}
	}
	
	func search(query: String, tableView: UITableView) {
		isSearchActive = !query.isEmpty
		if !query.isEmpty {
			filterItemsList = itemsList.filter({ $0.query.lowercased().contains(query.lowercased()) })
		}
		
		tableView.reloadData()
	}
}
