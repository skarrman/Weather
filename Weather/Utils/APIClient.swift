//
//  APIClient.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-09-20.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation
import RxSwift

class APIClient {
	let baseURL = URL(string: "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/")!
	func send(apiRequest: APIRequest) -> Single<Forecasts> {
		return Single<Forecasts>.create { single in
			let request = apiRequest.request(with: self.baseURL)
//			print("URL", request.url ?? "No url")
			let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
				if let error = error {
					single(.error(error))
					return
				}
				do {
					if let data = data {
//						print("Data:", data)
						let json: Forecasts = try JSONDecoder().decode(Forecasts.self, from: data)
						single(.success(json))
					} else {
						print("Data error")
					}
				} catch let error {
					print("JSON error")
					single(.error(error))
				}
				
			}
			task.resume()

			return Disposables.create {
				task.cancel()
			}
		}
	}
}
