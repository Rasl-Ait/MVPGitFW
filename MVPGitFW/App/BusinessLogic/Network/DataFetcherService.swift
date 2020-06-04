
//  Created by rasul on 3/26/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

protocol DateFetcherServiceProtocol {
	func fetchItemsList(endpoint: Endpoint, completion: @escaping CompletionBlock<[Follower]?, Error>)
	func fetchItemDetail(endpoint: Endpoint, completion: @escaping CompletionBlock<User?, Error>)
}

class DataFetcherService: DateFetcherServiceProtocol {

	let dataFetcher: DataFetcher

	init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
		self.dataFetcher = dataFetcher
	}

	func fetchItemsList(endpoint: Endpoint, completion: @escaping CompletionBlock<[Follower]?, Error>) {
		dataFetcher.fetchGenericJSONData(request: endpoint.request, completion: completion)
	}

	func fetchItemDetail(endpoint: Endpoint, completion: @escaping CompletionBlock<User?, Error>) {
		dataFetcher.fetchGenericJSONData(request: endpoint.request, completion: completion)
	}
}
