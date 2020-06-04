
//  Created by rasul on 4/15/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

class BasicDataSource: NSObject {
	
	func numberOfItems(in section: Int) -> Int {
		fatalError("\(self): \(#function) Should be implemented to get the number of item in section")
	}
	
	func getTableViewCell(in tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		fatalError("\(self): \(#function) Should be implemented to get the tableView cell")
	}
	
	func getCellHeight(_ indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

extension BasicDataSource: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return numberOfItems(in: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return self.getTableViewCell(in: tableView, indexPath: indexPath)
	}
}

extension BasicDataSource: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return getCellHeight(indexPath)
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {}
}
