//
//  JsonHandler.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-02-11.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation

class JsonHandler {
	
	func getForecast(longitude: Double, latitude: Double) -> [TimeSeries] {
		
		var timeSeries: [TimeSeries]?
		
		let long = (longitude * 1000).rounded() / 1000
		let lat = (latitude * 1000).rounded() / 1000
		
		let urlString = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/\(long)/lat/\(lat)/data.json"
		guard let url = URL(string: urlString) else { fatalError() }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data else { return }
			
			//Check for error and response
			
			print(error ?? "No error provided")
			print(response ?? "No response provided")
			
			
			do{
				let forecast = try JSONDecoder().decode(Forecast.self, from: data)
				timeSeries = forecast.timeSeries
				
				print(forecast)
				
			}  catch let jsonErr {
				print("Error serilizing json", jsonErr)
			}
			}.resume()
		
		while timeSeries == nil {}
		
		return timeSeries!
	}
	
}
