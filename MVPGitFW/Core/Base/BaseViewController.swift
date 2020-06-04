import UIKit

class BaseViewController: UIViewController {
	
	lazy var activityIndicatorView: UIActivityIndicatorView = {
		let activityIndicatorView = UIActivityIndicatorView()
		activityIndicatorView.color = UIColor.red
		activityIndicatorView.sizeToFit()
		return activityIndicatorView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	func showLoadingView(_ tableView: UITableView) {
		tableView.sectionFooterHeight = 60
		tableView.tableFooterView = activityIndicatorView
		activityIndicatorView.startAnimating()
	}
	
	func hideLoadingView(_ tableView: UITableView) {
		if activityIndicatorView.isDescendant(of: tableView) {
			activityIndicatorView.stopAnimating()
			activityIndicatorView.removeFromSuperview()
			tableView.tableFooterView = nil
		}
	}
}
