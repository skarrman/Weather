//
//  ForecastRequest.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-09-20.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation

class ForecastRequest: APIRequest {
	var method: RequestType = RequestType.GET
	var path: String = ""
//	var parameters: [String : String] = [String : String]()
	
	init(location: Location){
		path = "lon/\(location.longitude)/lat/\(location.latitude)/data.json"
	}
}
