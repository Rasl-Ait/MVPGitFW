
//  Created by rasul on 4/13/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel: Object, FollowerProtocol {
	@objc dynamic var id = 0
	@objc dynamic var login = ""
	@objc dynamic var avatarUrl = ""
	@objc dynamic var type = ""
	
	enum Property: String {
		case id, login, image
	}
	
	convenience init(id: Int, login: String, avatarUrl: String, type: String) {
		self.init()
		self.type = type
		self.id = id
		self.login = login
		self.avatarUrl = avatarUrl
	}
	
	override class func primaryKey() -> String? {
		return UserModel.Property.id.rawValue
	}
}
