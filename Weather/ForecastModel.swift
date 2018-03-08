//
//  ForecastModel.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-07.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation


class ForecastModel {
	
	var forecasts: [TimeSeries]?
	
	func updateForecast(longitude: Double, latitude: Double){
		let long = (longitude * 10000).rounded() / 10000
		let lat = (latitude * 10000).rounded() / 10000
		
		let urlString = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/\(long)/lat/\(lat)/data.json"
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data else { return }
			
			//Check for error and response
			
			print(error ?? "No error provided")
			print(response ?? "No response provided")
			
			do{
				let forecast = try JSONDecoder().decode(Forecast.self, from: data)
				self.forecasts = forecast.timeSeries
				
				print(self.forecasts!.first ?? "No forecast")
				
			}  catch let jsonErr {
				print("Error serilizing json", jsonErr)
			}
		}.resume()
	}
	
	
	
	
	
	
	
}
