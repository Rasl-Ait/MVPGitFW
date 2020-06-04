
//  Created by rasul on 3/26/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

protocol DataFetcher {
	func fetchGenericJSONData<T: Decodable>(request: URLRequest, completion: @escaping CompletionBlock<T?, Error>)
}

class NetworkDataFetcher: DataFetcher {
	var networkService: NetworkServiceProtocol
	
	init(networkService: NetworkServiceProtocol = NetworkService()) {
		self.networkService = networkService
	}
	
	func fetchGenericJSONData<T: Decodable>(request: URLRequest, completion: @escaping CompletionBlock<T?, Error>) {
		networkService.request(request: request, completion: parseDecodable(completion: completion))
	}
	
	private func parseDecodable<T: Decodable>(completion: @escaping CompletionBlock<T?, Error>) -> CompletionDataBlock {
		return { result in
			switch result {
			case .success(let data):
				let object = self.decodeJSON(type: T.self, data: data)
				DispatchQueue.main.async {
					completion(.success(object))
				}
			case .failure(let error):
				DispatchQueue.main.async {
					completion(.failure(error))
				}
			}
		}
	}
	
	private func decodeJSON<T: Decodable>(type: T.Type, data: Data) -> T? {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
		
		do {
			let objects = try decoder.decode(type.self, from: data)
			return objects
		} catch let jsonError as DecodingError {
			print("Failed to decode JSON", jsonError)
			return nil
		} catch {
			fatalError("Unhandled error raised.")
		}
	}
}
