
//  Created by rasul on 3/25/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

struct User: Decodable {
	let name: String?
	let login: String
	let id: Int
	let bio: String?
	let avatarUrl: String
	let location: String?
	let publicRepos: Int?
	let publicGists: Int?
	let htmlUrl: String
	let following: Int?
	let followers: Int?
	let type: String
}
