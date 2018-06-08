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
			return #imageLiteral(resourceName: "Sun").withRenderingMode(.alwaysTemplate)
		case .nearlyClearSky, .variableCloudiness, .halfclearSky:
			return #imageLiteral(resourceName: "SunCloud").withRenderingMode(.alwaysTemplate)
		case .cloudySky, .overcast:
			return #imageLiteral(resourceName: "Cloud").withRenderingMode(.alwaysTemplate)
		case .fog:
			return #imageLiteral(resourceName: "Fog").withRenderingMode(.alwaysTemplate)
		case .lightRainShowers, .moderateRainShowers, .heavyRainShowers, .lightSleetShowers, .moderateSleetShowers, .heavySleetShowers, .lightRain, .moderateRain, .heavyRain, .lightSleet, .moderateSleet, .heavySleet:
			return #imageLiteral(resourceName: "Rain").withRenderingMode(.alwaysTemplate)
		case .lightSnowShowers, .moderateSnowShowers, .heavySnowShowers, .lightSnowfall, .moderateSnowfall, .heavySnowfall:
			return #imageLiteral(resourceName: "Snow").withRenderingMode(.alwaysTemplate)
		case .thunder, .thunderstorm:
			return #imageLiteral(resourceName: "Thunder").withRenderingMode(.alwaysTemplate)
		}
	}
}
