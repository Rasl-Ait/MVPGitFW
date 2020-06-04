
//  Created by rasul on 3/31/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

public extension UIViewController {
	func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		alert.addAction(action)
		
		DispatchQueue.main.async {
			self.present(alert, animated: true, completion: nil)
		}
	}
}
