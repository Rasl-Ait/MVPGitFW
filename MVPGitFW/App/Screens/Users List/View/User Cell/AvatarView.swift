
//  Created by rasul on 5/10/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

class AvatarView: UIView {
	
	private let avatarImage = CustomImageView(frame: .zero)
	
	private var isLayout: Bool!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupAvataImage()
		shadowView(view: self, shadowRadius: 6, shadowOpacity: 0.7)
		isUserInteractionEnabled = true
		addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateTap)))
		
	}
	
	 convenience init(isLayout: Bool) {
		self.init(frame: .zero)
		self.isLayout = isLayout
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		isLayout == true ? layout(cornerRadius: bounds.width / 2) : layout(cornerRadius: 20)
	}
	
	private func layout(cornerRadius: CGFloat) {
		avatarImage.layer.cornerRadius = cornerRadius
			layer.cornerRadius = cornerRadius
	}
	
	func prepareForReuse() {
		avatarImage.image = nil
	}
	
	func setImage(imageName: String) {
		avatarImage.downloadImage(from: URL(string: imageName))
	}
	
	func setupAvataImage() {
		avatarImage.translatesAutoresizingMaskIntoConstraints = false
		avatarImage.contentMode = .scaleAspectFill
		avatarImage.clipsToBounds = true
		addSubview(avatarImage)
		
		NSLayoutConstraint.activate([
			avatarImage.topAnchor.constraint(equalTo: topAnchor),
			avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor),
			avatarImage.trailingAnchor.constraint(equalTo: trailingAnchor),
			avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
	func shadowView(view: UIView, shadowRadius: CGFloat, shadowOpacity: Float) {
		view.layer.shadowRadius = shadowRadius
		view.layer.shadowOpacity = shadowOpacity
		view.layer.shadowOffset = CGSize(width: 0, height: 2)
		view.layer.borderColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
		view.layer.borderWidth = 1
	}
	
	@objc func animateTap(_ sender: UITapGestureRecognizer) {
		self.superview?.layoutIfNeeded()
		UIView.animate(
			withDuration: 0.075,
			delay: 0,
			usingSpringWithDamping: 0.08,
			initialSpringVelocity: 0.4,
			options: .curveEaseOut,
			animations: {
				self.avatarImage.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
		 }, completion: { _ in
			self.avatarImage.transform = .identity
		 })
	}
}
