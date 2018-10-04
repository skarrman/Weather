//
//  APIRequest.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-09-20.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation

public enum RequestType: String {
	case GET, POST
}

protocol APIRequest {
	var method: RequestType { get }
	var path: String { get }
//	var parameters: [String : String] { get }

}

extension APIRequest {
	func request(with baseURL: URL) -> URLRequest {
		guard let components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
			fatalError("Unable to create URL components")
		}

		guard let url = components.url else {
			fatalError("Could not get url")
		}

		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		return request
	}
}
