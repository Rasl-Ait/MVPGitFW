
//  Created by rasul on 3/31/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit.UILabel

extension UILabel {
	
	static var titleLabel: UILabel {
		let label = UILabel(frame: .zero)
		label.font = UIFont.systemFont(ofSize: 18)
		label.textColor = UIColor.black
		label.numberOfLines = 2
		return label
	}
	
	static var shortDescriptionLabel: UILabel {
		let label = UILabel(frame: .zero)
		label.font = UIFont.systemFont(ofSize: 16)
		label.textColor = UIColor.black.withAlphaComponent(0.7)
		label.numberOfLines = 2
		return label
	}
	
	static var fullDescriptionLabel: UILabel {
		let label = UILabel(frame: .zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.black.withAlphaComponent(0.7)
		label.numberOfLines = 0
		return label
	}
	
	static var subTitleLabel: UILabel {
		let label = UILabel(frame: .zero)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.black.withAlphaComponent(0.5)
		label.numberOfLines = 2
		return label
	}
}
