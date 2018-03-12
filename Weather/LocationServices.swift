//
//  LocationServices.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-12.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation
import CoreLocation

class LocationServices: NSObject, CLLocationManagerDelegate {
	
	var forecastModel: ForecastModel
	var locationManager: CLLocationManager!
	
	init(forecastModel: ForecastModel) {
		locationManager = CLLocationManager()
		self.forecastModel = forecastModel
		super.init()
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		
	}
	
	func determineMyLocation(){
		if CLLocationManager.locationServicesEnabled() {
			locationManager.startUpdatingLocation()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation:CLLocation = locations[0] as CLLocation
		
		manager.stopUpdatingLocation()
		
		let geocoder = CLGeocoder()

		geocoder.reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) in
			if error == nil {
				let firstLocation = placemarks?[0]
				let cityName = firstLocation!.locality!
				print(firstLocation?.locality ?? "No location given")
				
				self.forecastModel.updateForecast(cityName: cityName, longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude)
			}
			else {
				// An error occurred during geocoding.
				print("An error occurred during geocoding.")
			}
		})
		
		print("user latitude = \((userLocation.coordinate.latitude * 10000).rounded() / 10000)")
		print("user longitude = \((userLocation.coordinate.longitude * 10000).rounded() / 10000)")
		
		
		
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error \(error)")
	}
	
}
