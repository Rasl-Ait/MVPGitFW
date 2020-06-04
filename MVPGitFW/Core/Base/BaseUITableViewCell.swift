
import UIKit

class BaseUITableViewCell: UITableViewCell {
	
	// MARK: - Lifecycle
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.selectionStyle = .none
		self.addSubViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
		
	func addSubViews() {
		fatalError("Should override " + #function + " in " + String(describing: type(of: self)))
	}
}
