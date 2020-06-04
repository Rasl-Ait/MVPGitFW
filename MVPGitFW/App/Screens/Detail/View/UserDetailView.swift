
import UIKit

class UserDetailView: UIView {
	
	// MARK: - Properties
	private let stackView = CustomStackView(axis: .vertical, spacing: 40)
	private let avatarView = AvatarView(isLayout: false)
	private let userNameLabel: UILabel = UILabel.titleLabel
	private let followersLabel: UILabel = UILabel.fullDescriptionLabel
	private let followingLabel: UILabel = UILabel.fullDescriptionLabel
	private let publicRepoLabel: UILabel = UILabel.fullDescriptionLabel
	private let publicGistLabel: UILabel = UILabel.fullDescriptionLabel
	private let userTypeLabel: UILabel = UILabel.subTitleLabel
	private let getFollowersButton = UIButton()
	private let gitProfielButton = UIButton()
	
	var buttonClicked: VoidClosure?
	var getFollowerClicked: VoidClosure?
	var gitProfileClicked: VoidClosure?
	
	convenience init() {
		self.init(frame: .zero)
		setupView()
	}
	
	func configureView(viewmodel: UserDetailModelView) {
		userNameLabel.text = viewmodel.name
		userTypeLabel.text = "★ " + (viewmodel.type ?? "")
		followersLabel.text = "Followers (\(viewmodel.followers ?? 0))"
		followingLabel.text = "Following (\(viewmodel.following ?? 0))"
		publicRepoLabel.text = "Public Repo (\(viewmodel.publicRepos ?? 0))"
		publicGistLabel.text =  "Public Gist(\(viewmodel.publicGists ?? 0))"
		avatarView.setImage(imageName: viewmodel.avatarUrl ?? "")
	}
}

// MARK: - private extension UserDetailView 

private extension UserDetailView {
	func setupView() {
		backgroundColor = .white
		setupAvatarView()
		setupStackView()
		setupGetFollowersButton()
	}
	
	func setupAvatarView() {
		avatarView.translatesAutoresizingMaskIntoConstraints = false
		
		avatarView.widthAnchor.constraint(equalToConstant: 300).isActive = true
		avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor, multiplier: 5 / 3).isActive = true
	}
	
	func setupStackView() {
		let avatarViewStackView = CustomStackView(axis: .vertical, spacing: 0)
		avatarViewStackView.alignment = .center
		avatarViewStackView.addArrangedSubview(avatarView)
		stackView.addArrangedSubview(avatarViewStackView)
		
		let verticalStackView = CustomStackView(axis: .vertical, spacing: 5)
		verticalStackView.distribution = .fillEqually
		verticalStackView.addArrangedSubview(userNameLabel)
		verticalStackView.addArrangedSubview(userTypeLabel)
		verticalStackView.addArrangedSubview(followersLabel)
		verticalStackView.addArrangedSubview(followingLabel)
		verticalStackView.addArrangedSubview(publicGistLabel)
		verticalStackView.addArrangedSubview(publicRepoLabel)
		stackView.addArrangedSubview(verticalStackView)
		addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)])
	}
	
	func setupGetFollowersButton() {
		
		getFollowersButton.setTitle("Get Followers", for: .normal)
		getFollowersButton.layer.cornerRadius = 10
		getFollowersButton.setTitleColor(.white, for: .normal)
		getFollowersButton.backgroundColor = .systemPurple
		getFollowersButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		getFollowersButton.addTarget(self, action: #selector(getFollowersButtonTapped), for: .touchUpInside)
		
		gitProfielButton.setTitle("Github Profile", for: .normal)
		gitProfielButton.layer.cornerRadius = 10
		gitProfielButton.setTitleColor(.white, for: .normal)
		gitProfielButton.backgroundColor = .systemBlue
		gitProfielButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		gitProfielButton.addTarget(self, action: #selector(gitProfileButtonTapped), for: .touchUpInside)
		
		getFollowersButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
		
		let stackview = CustomStackView(axis: .horizontal, spacing: 10)
		stackview.alignment = .fill
		stackview.distribution = .fillEqually
		
		stackview.addArrangedSubview(getFollowersButton)
		stackview.addArrangedSubview(gitProfielButton)

		addSubview(stackview)
		
		NSLayoutConstraint.activate([
			stackview.centerXAnchor.constraint(equalTo: centerXAnchor),
			stackview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
		])
	}
	
	@objc func gitProfileButtonTapped() {
		gitProfileClicked?()
	}
	
	@objc func getFollowersButtonTapped() {
		getFollowerClicked?()
	}
	
	@objc func buttonTapped() {
		buttonClicked?()
	}
}
