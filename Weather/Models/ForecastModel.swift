//
//  ForecastModel.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-09-11.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation
import RxSwift

public class ForecastModel {
	
	private var forecasts: [Forecast] = [Forecast]()
	private var location: Location!
	private var referenceTime: Date?
	private let disposeBag = DisposeBag()
	
	func getForecasts() -> [Forecast]{
		return forecasts
	}
	
	func getLocation() -> Location {
		return location
	}
	
	func getForecast(for location: Location) -> Single<[Forecast]>{
		return Single<[Forecast]>.create { single in
		
			self.location = location
			
			let apiClient = APIClient()
	
			apiClient.send(apiRequest: ForecastRequest(location: location))
				.subscribeOn(CurrentThreadScheduler.instance)
				.subscribe(
					onSuccess: { forecastsJson in
						self.forecasts = self.decodeForecasts(forecasts: forecastsJson)
						single(.success(self.forecasts))
					},
					onError: { error in
						single(.error(error))
					}
				)
				.disposed(by: self.disposeBag)
			
			return Disposables.create{}
		}
		
	}
	
	func decodeForecasts(forecasts: Forecasts) -> [Forecast] {
		//let order = ["msl", "t", "vis", "wd", "ws", "r", "tstm", "tcc_mean", "lcc_mean", "mcc_mean", "hcc_mean", "gust", "pmin", "pmax", "spp", "pcat", "pmean", "pmedian", "Wsymb2"]
		let dateFormatter = ISO8601DateFormatter()
		referenceTime = dateFormatter.date(from: forecasts.referenceTime)
		let calendar = Calendar.current
		//let components = calendar.dateComponents([.weekday, .month, .day, .hour], from: referenceTime!)
		
		let timeSeries = forecasts.timeSeries
		var f = [Forecast]()
		
		for t in timeSeries {
			var date: DateComponents!, airPressure: Double!, temp: Double!, visiblity: Double!, windDirection: Int!, windSpeed: Double!, humidity: Int!, thunderProb: Int!, totalCloudCover: Int!, lowCloudCover: Int!, mediumCloudCover: Int!, highCloudCover: Int!, windGustSpeed: Double!, minPrecipitation: Double!, maxPrecipitation: Double!, frozenPrecipitationPercent: Int!, category: Category!, precipitationMean: Double!, precipitationMedian: Double!, symbol: Symbol!
			
			date = calendar.dateComponents([.weekday, .month, .day, .hour], from: dateFormatter.date(from: t.validTime)!)
			for p in t.parameters {
				
				switch p.name {
				case "msl":
					airPressure = p.values.first!
				case "t":
					temp = p.values.first!
				case "vis":
					visiblity = p.values.first!
				case "wd":
					windDirection = Int(p.values.first!)
				case "ws":
					windSpeed = p.values.first!
				case "r":
					humidity = Int(p.values.first!)
				case "tstm":
					thunderProb = Int(p.values.first!)
				case "tcc_mean":
					totalCloudCover = Int(p.values.first!)
				case "lcc_mean":
					lowCloudCover = Int(p.values.first!)
				case "mcc_mean":
					mediumCloudCover = Int(p.values.first!)
				case "hcc_mean":
					highCloudCover = Int(p.values.first!)
				case "gust":
					windGustSpeed = p.values.first!
				case "pmin":
					minPrecipitation = p.values.first!
				case "pmax":
					maxPrecipitation = p.values.first!
				case "spp":
					frozenPrecipitationPercent = Int(p.values.first!)
				case "pcat":
					category = Category(rawValue: Int(p.values.first!))!
				case "pmean":
					precipitationMean = p.values.first!
				case "pmedian":
					precipitationMedian = p.values.first!
				case "Wsymb2":
					symbol = Symbol(rawValue: Int(p.values.first!))!
				default:
					print("Soemting went wrong")
				}
				
			}
			f.append(Forecast(date: date, airPressure: airPressure, temp: temp, visiblity: visiblity, windDirection: windDirection, windSpeed: windSpeed, humidity: humidity, thunderProb: thunderProb, totalCloudCover: totalCloudCover, lowCloudCover: lowCloudCover, mediumCloudCover: mediumCloudCover, highCloudCover: highCloudCover, windGustSpeed: windGustSpeed, minPrecipitation: minPrecipitation, maxPrecipitation: maxPrecipitation, frozenPrecipitationPercent: frozenPrecipitationPercent, category: category, precipitationMean: precipitationMean, precipitationMedian: precipitationMedian, symbol: symbol))
		}
		return f
	}
	
	func isTimeForNewForecast() -> Bool {
		if referenceTime != nil {
			
			let now = Date(timeIntervalSinceNow: 0)
			let calendar = Calendar.current
			let nowHour = calendar.component(.hour, from: now)
			let referencHour = calendar.component(.hour, from: referenceTime!)
			
			print(nowHour, referencHour)
			
			return nowHour >= (referencHour + 1) //No need to Update forecast
		}
		return true
	}
	
	func userHasMoved(distance: Double) -> Bool {
		return distance == -1 || distance > 10000
	}
}

