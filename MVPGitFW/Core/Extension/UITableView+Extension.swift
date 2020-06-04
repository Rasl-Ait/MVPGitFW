
//  Created by rasul on 3/28/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit
import RealmSwift

extension UITableView {
	
	func register<T: UITableViewCell>(_ :T.Type) {
		register(T.self, forCellReuseIdentifier: T.name)
	}
	
	func registerDelegate(with dataSource: BasicDataSource) {
		self.dataSource = dataSource
		self.delegate = dataSource
	}
	
	func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withIdentifier: T.name, for: indexPath) as? T else {
			fatalError("Could not deque cell with identifier")
		}
		return cell
	}
}

extension IndexPath {
  static func fromRow(_ row: Int) -> IndexPath {
    return IndexPath(row: row, section: 0)
  }
}

extension UITableView {
  func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
    beginUpdates()
    deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
    insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
    reloadRows(at: updates.map(IndexPath.fromRow), with: .automatic)
    endUpdates()
  }
}
