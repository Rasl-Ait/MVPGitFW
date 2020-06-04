
//  Created by rasul on 3/30/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
	
	private let scrollView = UIScrollView()
	
	var configurator: SearchConfiguratorProtocol!
	var presenter: SearchViewPresenterProtocol!
	
	lazy var searchView: SearchView = {
		let view = SearchView()
		return view
	}()
	
	override func loadView() {
		view = scrollView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShowHide(notification:)),
			name: UIResponder.keyboardWillShowNotification, object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShowHide(notification:)),
			name: UIResponder.keyboardWillHideNotification, object: nil
		)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(
			self,
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
		NotificationCenter.default.removeObserver(
			self,
			name: UIResponder.keyboardWillChangeFrameNotification,
			object: nil
		)
	}
}

// MARK: - private SearchViewController

private extension SearchViewController {
	func setupView() {
		configurator.configure(self)
		setupSearchView()
		addTapGesture()
		
		searchView.showAlert = { [weak self ] in
			guard let self = self else { return }
			self.showAlert(title: "Empty login", message: "Please enter a login. We need to know who to look for 😀.")
		}
		
		searchView.actionButtonCloser = { [weak self ] login in
			guard let self = self else { return }
			self.presenter.buttonTapped(login: login )
		}
	}
	
	func setupScrollView() {
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(scrollView)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
	}
	
	func setupSearchView() {
		searchView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(searchView)
		
		NSLayoutConstraint.activate([
			searchView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -64),
			searchView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			searchView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			searchView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			searchView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			searchView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
		])
		
	}
	
	func addTapGesture() {
		let tapGesture = UITapGestureRecognizer(
			target: self,
			action: #selector(hideKeyboard)
		)
		view.addGestureRecognizer(tapGesture)
	}
	
	// Selectors
	
	@objc func keyboardWillShowHide(notification: Notification) {
		guard let userInfo = notification.userInfo else { return }
		let safeAreaBottom = view.safeAreaInsets.bottom
		if let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			let keyboardViewEndFrame = view.convert(keyboardSize, from: view.window)
			if notification.name == UIResponder.keyboardWillHideNotification {
				scrollView.contentInset = .zero
			} else {
				if #available(iOS 11.0, *) {
					self.scrollView.contentInset = UIEdgeInsets(
						top: 0,
						left: 0,
						bottom: keyboardViewEndFrame.height + safeAreaBottom,
						right: 0
					)
				} else {
					self.scrollView.contentInset = UIEdgeInsets(
						top: 0,
						left: 0,
						bottom: keyboardViewEndFrame.height,
						right: 0
					)
				}
			}
		}
	}
	
	@objc func hideKeyboard() {
		self.view.endEditing(true)
	}
}

extension SearchViewController: SearchViewProtocol {}
