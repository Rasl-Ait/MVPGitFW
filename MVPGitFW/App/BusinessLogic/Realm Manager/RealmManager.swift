
//  Created by rasul on 4/13/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
	func createItem(item: Object)
	func fetchItems<T: Object>(ofType type: T.Type) -> Results<T>
	func save(_ object: Object)
	func filter(item: UserModel) -> Bool
	func detete<T: Object>(_ object: T)
}

class RealmManager: RealmManagerProtocol {
	var realm: Realm {
		return try! Realm(configuration: .defaultConfiguration)
	}
	
	func filter(item: UserModel) -> Bool {
		let objects = realm.objects(UserModel.self)
		guard let _ = objects.first(where: { $0.id == item.id }) else {
			return false
		}
		return true
	}
	
	func createItem(item: Object) {
		if filter(item: item as! UserModel) {
			return
		}
		save(item)
	}
	
	func fetchItems<T>(ofType type: T.Type) -> Results<T> where T: Object {
		let byKeyPath = UserModel.Property.login.rawValue
		return realm.objects(T.self).sorted(byKeyPath: byKeyPath)
	}
	
	func save(_ object: Object) {
		do {
			try realm.write {
				realm.add(object)
				print(realm.configuration.fileURL?.absoluteURL ?? "")
			}
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func detete<T>(_ object: T) where T: Object {
		do {
			try realm.write {
				realm.delete(object)
			}
		} catch {
			print(error.localizedDescription)
		}
	}
}
