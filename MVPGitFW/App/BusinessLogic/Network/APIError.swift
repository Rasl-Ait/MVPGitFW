
//  Created by rasul on 3/26/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

enum APIError: Error {
	case networkingError(Error)
	case serverError // HTTP 5xx
	case requestError(Int, String) // HTTP 4xx
	case invalidResponse
	case decodingError(DecodingError)
	
	var localizedDescription: String {
		switch self {
		case .networkingError(let error):
			return "Error sending request: \(error.localizedDescription)"
		case .serverError:
			return "HTTP 500 Server Error"
		case .requestError(let status, let body):
			return "HTTP \(status)\n\(body)"
		case .invalidResponse:
			return "Invalid Response"
		case .decodingError(let error):
			
			return "Decoding error: \(error.localizedDescription)"
		}
	}
}
