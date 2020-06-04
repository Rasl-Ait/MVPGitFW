
//  Created by rasul on 3/27/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
	
	let cache = NSCache<NSString, UIImage>()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		configure()
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	func downloadImage(from imageURL: URL?) {
		let cacheKey = NSString(string: imageURL?.absoluteString ?? "")
		
		if let image = cache.object(forKey: cacheKey) {
			self.image = image
			return
		}
		
		guard let url = imageURL else { return }
		
		let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self = self else { return }
			guard
				let data = data,
				error == nil else { return }
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
			
			guard let image = UIImage(data: data) else { return }
			self.cache.setObject(image, forKey: cacheKey)
			
			DispatchQueue.main.async {
				self.image = image
			}
		}
		
		task.resume()
	}
}
