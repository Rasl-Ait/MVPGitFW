
//  Created by rasul on 5/20/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

protocol Searchable {
	var query: String { get }
}

protocol FollowerProtocol {
	var id: Int { get }
	var login: String { get }
	var avatarUrl: String { get }
	var type: String { get }
}

struct Follower: Decodable, FollowerProtocol, Searchable {
	let id: Int
	let login: String
	let avatarUrl: String
	let type: String
	
	var query: String {
		return login
	}
}
