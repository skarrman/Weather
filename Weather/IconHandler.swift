//
//  IconHandler.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-20.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation
import UIKit

struct IconHandler {
	static func getForecastIcon(symbol: Symbol) -> UIImage {
		switch symbol {
		case .clearSky:
			return #imageLiteral(resourceName: "Sun")
		case .nearlyClearSky, .variableCloudiness, .halfclearSky:
			return #imageLiteral(resourceName: "SunCloud")
		case .cloudySky, .overcast:
			return #imageLiteral(resourceName: "Cloud")
		case .fog:
			return #imageLiteral(resourceName: "Fog")
		case .lightRainShowers, .moderateRainShowers, .heavyRainShowers, .lightSleetShowers, .moderateSleetShowers, .heavySleetShowers, .lightRain, .moderateRain, .heavyRain, .lightSleet, .moderateSleet, .heavySleet:
			return #imageLiteral(resourceName: "Rain")
		case .lightSnowShowers, .moderateSnowShowers, .heavySnowShowers, .lightSnowfall, .moderateSnowfall, .heavySnowfall:
			return #imageLiteral(resourceName: "Snow")
		case .thunder, .thunderstorm:
			return #imageLiteral(resourceName: "Thunder")
		}
	}
}
