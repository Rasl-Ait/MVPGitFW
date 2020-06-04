
//  Created by rasul on 3/25/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit
import SafariServices

class UserDetailViewController: UIViewController {
	
	var configurator: UserDetailConfiguratorProtocol!
	var presenter: UserDetailViewPresenterProtocol!
	
	lazy var detailView: UserDetailView = {
		let view = UserDetailView()
		return view
	}()
	
	override func loadView() {
		view = detailView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(self)
		presenter.getUser()
		
		detailView.buttonClicked = { [weak self] in
			guard let self = self else { return }
			self.presenter.buttonTapped()
		}
		
		detailView.getFollowerClicked = { [weak self] in
			guard let self = self else { return }
			self.presenter.showDetai()
		}
		
		detailView.gitProfileClicked = { [weak self] in
			guard let self = self else { return }
			self.presenter.presentSafariVC()
		}
	}
}

// MARK: - UserDetailViewProtocol

extension UserDetailViewController: UserDetailViewProtocol {
	
	func success(user: User) {
		let viewmodel = UserDetailModelView(user: user)
		detailView.configureView(viewmodel: viewmodel)
	}
	
	func failure(error: Error) {
		showAlert(title: "Error", message: error.localizedDescription)
	}
	
	func presentSafariVC(urlString: String) {
		guard let url = URL(string: urlString) else {
			showAlert(title: "Invalid URL", message: "The url attached to this user is invalid.")
			return
		}
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredControlTintColor = .systemPurple
		present(safariVC, animated: true)
	}
}
