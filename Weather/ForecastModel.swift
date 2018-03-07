//
//  ForecastModel.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-07.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation
import CoreLocation

class ForecastModel: NSObject, CLLocationManagerDelegate {
	
	var forecasts: [TimeSeries]?
	
	var locationManager: CLLocationManager!
	
	override init() {
		super.init()
		determineMyLocation()
	}
	
	
	func updateForecast(longitude: Double, latitude: Double){
		let long = (longitude * 1000).rounded() / 1000
		let lat = (latitude * 1000).rounded() / 1000
		
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
	
	func determineMyLocation(){
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.startUpdatingLocation()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation:CLLocation = locations[0] as CLLocation
		
		manager.stopUpdatingLocation()
		
		print("user latitude = \((userLocation.coordinate.latitude * 1000).rounded() / 1000)")
		print("user longitude = \((userLocation.coordinate.longitude * 1000).rounded() / 1000)")
		
		updateForecast(longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude)
		
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error \(error)")
	}
	
	
	
	
	
	
	
}
