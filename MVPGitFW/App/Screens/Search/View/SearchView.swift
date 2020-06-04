
//  Created by rasul on 3/30/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

class SearchView: UIView {
	
	private let logoImageView = UIImageView()
	private let loginTextField = UITextField()
	private let getFollowersButton = UIButton()
	private let stackView = CustomStackView(axis: .vertical, spacing: 30)
	
	var actionButtonCloser: ItemClosure<String>?
	var showAlert: VoidClosure?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension SearchView {
	func setupView() {
		backgroundColor = .white
		setupLogoImageView()
		setupLoginTextField()
		setupActionButton()
		setupStackView()
		createDismissKeyboardTapGesture()
	}
	
	func setupLogoImageView() {
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = UIImage(named: "gh-logo")
		addSubview(logoImageView)
		
		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
			logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			logoImageView.widthAnchor.constraint(equalToConstant: 200),
			logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1 / 1)
		])
	}
	
	func setupLoginTextField() {
		loginTextField.translatesAutoresizingMaskIntoConstraints = false
		loginTextField.placeholder = "Enter user name"
		loginTextField.textAlignment = .center
		loginTextField.font = UIFont.preferredFont(forTextStyle: .title2)
		loginTextField.clearButtonMode = .whileEditing
		loginTextField.layer.cornerRadius = 10
		loginTextField.layer.borderWidth = 2
		loginTextField.layer.borderColor = UIColor.systemGray4.cgColor
		loginTextField.delegate = self
		
		NSLayoutConstraint.activate([
			loginTextField.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	func setupActionButton() {
		getFollowersButton.translatesAutoresizingMaskIntoConstraints = false
		getFollowersButton.setTitle("Get Followers", for: .normal)
		getFollowersButton.layer.cornerRadius = 10
		getFollowersButton.setTitleColor(.white, for: .normal)
		getFollowersButton.backgroundColor = .systemPurple
		getFollowersButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		getFollowersButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
	}
	
	func setupStackView() {
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		
		stackView.addArrangedSubview(loginTextField)
		stackView.addArrangedSubview(getFollowersButton)
		addSubview(stackView)
		
		NSLayoutConstraint.activate([
				stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
				stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
				stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)])
	}
	
	@objc func actionButtonTapped() {
		guard let login = loginTextField.text, !login.isEmpty else {
			showAlert?()
			return
		}
		actionButtonCloser?(login)
	}
	
	func createDismissKeyboardTapGesture() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
		addGestureRecognizer(tap)
	}
}

// MARK: - UITextFieldDelegate

extension SearchView: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let login = textField.text, !login.isEmpty else {
			showAlert?()
			return false
		}
		actionButtonCloser?(login)
		return true
	}
}
