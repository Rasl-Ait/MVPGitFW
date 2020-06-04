//  Created by rasul on 3/27/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

class UserCell: BaseUITableViewCell {
	
	private let stackView = CustomStackView(axis: .horizontal, spacing: 15)
	private let avatarView = AvatarView(isLayout: true)
	private let loginLabel = UILabel()
	private let typeLabel = UILabel()
	
	static let height: CGFloat = 120
	
	override func addSubViews() {
		setupView()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		avatarView.prepareForReuse()
		loginLabel.text = nil
		typeLabel.text = nil
	}
}

private extension UserCell {
	func setupView() {
		setupAvatarView()
		setupStackView()
	}
	
	func setupAvatarView() {
		avatarView.translatesAutoresizingMaskIntoConstraints = false
		avatarView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		avatarView.widthAnchor.constraint(equalToConstant: 100).isActive = true
	}
	
	func setupStackView() {
		stackView.addArrangedSubview(avatarView)
		
		let verticalStackView = CustomStackView(axis: .vertical, spacing: 0)
		verticalStackView.alignment = .top
		verticalStackView.distribution = .fillEqually
		verticalStackView.addArrangedSubview(loginLabel)
		verticalStackView.addArrangedSubview(typeLabel)
		stackView.addArrangedSubview(verticalStackView)
		addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)])
	}
}

extension UserCell: UserCellView {
	func displayImage(image: String) {
		avatarView.setImage(imageName: image)
	}
	
	func displayLogin(login: String) {
		loginLabel.text = login
	}
	
	func displayType(type: String) {
		typeLabel.text = type
	}
}
