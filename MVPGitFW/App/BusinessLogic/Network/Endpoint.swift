
import Foundation

struct Endpoint {
	let path: String
	let queryItems: [URLQueryItem]
}

enum APISearch: String {
	case github = "/users"
}

extension Endpoint {
	static func search(with login: String, page: Int) -> Endpoint {
		var path = APISearch.github.rawValue
		path = path.appending("/\(login)/followers")
		return Endpoint(
			path: path,
			queryItems: [
				URLQueryItem(name: "per_page", value: "\(100)"),
				URLQueryItem(name: "page", value: "\(page)")
			]
		)
	}
	
	static func userDetail(with login: String) -> Endpoint {
		var path = APISearch.github.rawValue
		path = path.appending("/\(login)")
		return Endpoint(
			path: path,
			queryItems: []
		)
	}
}

extension Endpoint {
	var url: URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.github.com"
		components.path = path
		components.queryItems = queryItems
		return components.url
	}
	
	var request: URLRequest {
		guard let url = url else { fatalError( "Invalid URL") }
		return URLRequest(url: url)
	}
}
