
//  Created by rasul on 4/26/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

class UserListViewModel {
	var follower: Follower
	
	var login: String? {
		return follower.login
	}
	
	var avatarUrl: String? {
		return follower.avatarUrl
	}
	
	var type: String? {
		return follower.type
	}
	
	init(follower: Follower) {
		self.follower = follower
	}
}
