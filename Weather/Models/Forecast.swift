//
//  Forecast.swift
//  Forecast
//
//  Created by Simon Kärrman on 2018-09-10.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation

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

struct Forecasts: Decodable {
	//{"approvedTime":"2018-02-08T15:05:11Z","referenceTime":"2018-02-08T15:00:00Z","geometry":{"type":"Point","coordinates":[[16.178786,58.573639]]},"timeSeries":[{"validTime":"2018-02-08T16:00:00Z","parameters":[{"name":"spp","levelType":"hl","level":0,"unit":"percent","values":[-9]}
	
	let approvedTime: String
	let referenceTime: String
	let geometry: Geometry
	let timeSeries: [TimeSeries]
}

enum Category: Int {
	case none = 0, snow, snowAndRain, rain, drizzle, freezingRain, freezingDrizzle
}

enum Symbol: Int {
	case clearSky = 1, nearlyClearSky,variableCloudiness, halfclearSky, cloudySky, overcast, fog, lightRainShowers, moderateRainShowers, heavyRainShowers, thunderstorm, lightSleetShowers, moderateSleetShowers, heavySleetShowers, lightSnowShowers,moderateSnowShowers, heavySnowShowers, lightRain, moderateRain, heavyRain, thunder, lightSleet, moderateSleet, heavySleet, lightSnowfall, moderateSnowfall, heavySnowfall
}

struct Forecast {
	let date: DateComponents
	let airPressure: Double
	let temp: Double
	let visiblity: Double
	let windDirection: Int
	let windSpeed: Double
	let humidity: Int
	let thunderProb: Int
	let totalCloudCover: Int
	let lowCloudCover: Int
	let mediumCloudCover: Int
	let highCloudCover: Int
	let windGustSpeed: Double
	let minPrecipitation: Double
	let maxPrecipitation: Double
	let frozenPrecipitationPercent: Int
	let category: Category
	let precipitationMean: Double
	let precipitationMedian: Double
	let symbol: Symbol
}

