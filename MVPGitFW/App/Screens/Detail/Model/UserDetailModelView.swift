
//  Created by rasul on 4/26/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

class UserDetailModelView {
	var user: User
	
	init(user: User) {
		self.user = user
	}
	
	var name: String? {
		return user.name
	}
	
	var type: String? {
		return user.type
	}
	
	var followers: Int? {
		return user.followers
	}
	
	var following: Int? {
		return user.following
	}
	
	var publicRepos: Int? {
		return user.publicRepos
	}
	
	var publicGists: Int? {
		return user.publicGists
	}
	
	var avatarUrl: String? {
		return user.avatarUrl
	}	
}
