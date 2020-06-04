
//  Created by rasul on 4/15/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit
import RealmSwift

class GenericRealmDataSource<CellType: UITableViewCell, ItemType: Object >: BasicDataSource {
	
	typealias CellConfiguration = ((_ cell: CellType, _ item: ItemType) -> CellType)
	
	var itemsList: Results<ItemType>?
	var onConfigureCell: CellConfiguration?
	var onDidSelectCell: ItemClosure<Int>?
	var cellHeight: ItemClosureReturn<CGFloat>?
	var onDeleteItems: ItemClosure<Int>?
	
	private var isSearchActive: Bool = false
	
	func addItems(_ items: Results<ItemType>, in tableView: UITableView) {
		self.itemsList = items
		tableView.reloadData()
	}
	
	// MARK: - UITableViewDataSource
	
	override func numberOfItems(in section: Int) -> Int {
		return itemsList?.count ?? 0
	}
	
	override func getTableViewCell(in tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		let cell: CellType = tableView.dequeueReusableCell(forIndexPath: indexPath)
		guard let model = itemsList?[indexPath.row] else { fatalError( " " ) }
		return onConfigureCell?(cell, model) ?? UITableViewCell()
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		onDidSelectCell?(indexPath.row)
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		onDeleteItems?(indexPath.row)
	}
	
	override func getCellHeight(_ indexPath: IndexPath) -> CGFloat {
		return cellHeight?() ?? 44
	}
}
