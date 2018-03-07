//
//  Forecast.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-01.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//



struct DataPoint : Decodable {
	//	[{"name":"spp","levelType":"hl","level":0,"unit":"percent","values":[-9]},{"name":"pcat","levelType":"hl","level":0,"unit":"category","values":[0]},
	
	let name: String
	let levelType: String
	let level: Int
	let unit: String
	let values: [Double]
	
}

struct Geometry : Decodable {
	let type: String
	let coordinates: [[Double]]
}

struct TimeSeries : Decodable {
	let validTime: String
	let parameters: [DataPoint]
}

struct Forecast: Decodable {
	//{"approvedTime":"2018-02-08T15:05:11Z","referenceTime":"2018-02-08T15:00:00Z","geometry":{"type":"Point","coordinates":[[16.178786,58.573639]]},"timeSeries":[{"validTime":"2018-02-08T16:00:00Z","parameters":[{"name":"spp","levelType":"hl","level":0,"unit":"percent","values":[-9]}
	
	let approvedTime: String
	let referenceTime: String
	let geometry: Geometry
	let timeSeries: [TimeSeries]
}

