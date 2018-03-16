//
//  ForecastModel.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-07.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation

class ForecastModel {
	
	private var forecasts: [Forecast]!
	private var cityName: String!
	private var referenceTime: Date?
	
	func getForecasts() -> [Forecast]{
		return forecasts
	}
	
	func getCityName() -> String {
		return cityName
	}
	
	func updateForecast(cityName: String, longitude: Double, latitude: Double, distance: Double){
		let decimals = 1000000.0
		let long = (longitude * decimals).rounded() / decimals
		let lat = (latitude * decimals).rounded() / decimals
		
		
//		if !isTimeForNewForecast() && !userHasMoved(distance: distance) {
//			return
//		}
		self.cityName = cityName
		
		//Ryd test url
		//let urlString = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/12.5033/lat/57.8579/data.json"
		
		let urlString = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/\(long)/lat/\(lat)/data.json"
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data else { return }
			
			//Check for error and response
			
			//print(error ?? "No error provided")
			//print(response ?? "No response provided")
			
			guard let httpResponse = response as! HTTPURLResponse? else{print("Not a HTTP");return}
			print("StatusCode:",httpResponse.statusCode)
			
			if httpResponse.statusCode != 200 {
				NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "BadRequest")))
				return
			}
			do{
				let forecast = try JSONDecoder().decode(Forecasts.self, from: data)
				self.decodeForecasts(forecasts: forecast)
				
				//print(self.forecasts!.first ?? "No forecast")
				
			}  catch let jsonErr {
				print("Error serilizing json", jsonErr)
			}
		}.resume()
	}
	
	func decodeForecasts(forecasts: Forecasts){
		//let order = ["msl", "t", "vis", "wd", "ws", "r", "tstm", "tcc_mean", "lcc_mean", "mcc_mean", "hcc_mean", "gust", "pmin", "pmax", "spp", "pcat", "pmean", "pmedian", "Wsymb2"]
		let dateFormatter = ISO8601DateFormatter()
		referenceTime = dateFormatter.date(from: forecasts.referenceTime)
		let calendar = Calendar.current
		let components = calendar.dateComponents([.weekday, .month, .day, .hour], from: referenceTime!)
		
		print(components)
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
		self.forecasts = f
		NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "ForecastUpdated")))
		
	
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
