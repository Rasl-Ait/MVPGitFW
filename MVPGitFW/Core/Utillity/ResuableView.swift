
//  Created by rasul on 3/28/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

protocol ReusableView {
	static var name: String { get }
}

extension ReusableView {
	static var name: String {
		return String(describing: self)
	}
}

extension UITableViewCell: ReusableView { }
