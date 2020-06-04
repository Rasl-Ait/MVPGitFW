
//  Created by rasul on 3/25/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
	var session: URLSession { get }
	func request(request: URLRequest, completion: @escaping CompletionDataBlock)
}

class NetworkService: NetworkServiceProtocol {
	var session: URLSession
	
	init() {
		let config = URLSessionConfiguration.default
		config.requestCachePolicy = .reloadIgnoringLocalCacheData
		config.urlCache = nil
		session = URLSession(configuration: config)
	}
	
	func request(request: URLRequest, completion: @escaping CompletionDataBlock) {
		let task = perform(request: request, completion: completion)
		task.resume()
	}
	
	private	func perform(request: URLRequest, completion: @escaping CompletionDataBlock) -> URLSessionDataTask {
		return session.dataTask(with: request) { data, response, error in
			if let error = error as NSError? {
				if error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
					return
				}
				
				completion(.failure(.networkingError(error)))
				return
			}
			
			guard let http = response as? HTTPURLResponse, let data = data else {
				completion(.failure(.invalidResponse))
				return
			}
			
			switch http.statusCode {
			case 200:
				completion(.success(data))
				
			case 400...499:
				let body = String(data: data, encoding: .utf8)
				completion(.failure(.requestError(http.statusCode, body ?? "<no body>")))
				
			case 500...599:
				completion(.failure(.serverError))
				
			default:
				fatalError("Unhandled HTTP status code: \(http.statusCode)")
			}
		}
	}
}
