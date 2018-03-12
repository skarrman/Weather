//
//  ForecastModel.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-07.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation

class ForecastModel {
	
	private var forecasts: [TimeSeries]!
	private var cityName: String!
	
	func getForecasts() -> [TimeSeries]{
		return forecasts
	}
	
	func getCityName() -> String {
		return cityName
	}
	
	func updateForecast(cityName: String, longitude: Double, latitude: Double){
		let long = (longitude * 10000).rounded() / 10000
		let lat = (latitude * 10000).rounded() / 10000
		self.cityName = cityName
		
		//Ryd test url
		//let urlString = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/12.5033/lat/57.8579/data.json"
		
		let urlString = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/\(long)/lat/\(lat)/data.json"
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data else { return }
			
			//Check for error and response
			
			print(error ?? "No error provided")
			print(response ?? "No response provided")
			
			guard let httpResponse = response as! HTTPURLResponse? else{print("Not a HTTP");return}
			print("StatusCode:",httpResponse.statusCode)
			
			if httpResponse.statusCode != 200 {
				NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "BadRequest")))
				return
			}
			do{
				let forecast = try JSONDecoder().decode(Forecast.self, from: data)
				self.forecasts = forecast.timeSeries
				
				//print(self.forecasts!.first ?? "No forecast")
				NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "ForecastUpdated")))
				
			}  catch let jsonErr {
				print("Error serilizing json", jsonErr)
			}
		}.resume()
	}
	
	
	
	
	
	
	
}
