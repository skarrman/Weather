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
	private var lastLocation: CLLocation?
	
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
		var userLocation: CLLocation!
		if TARGET_IPHONE_SIMULATOR == 0 {
			userLocation = locations[0] as CLLocation
		}else {
			//userLocation = CLLocation(latitude: 57.857539, longitude: 12.502884)
			userLocation = CLLocation(latitude: 59.331495, longitude: 18.056975)
		}
		manager.stopUpdatingLocation()
		
		let reverseGeocoder = CLGeocoder()
		
		var distance: CLLocationDistance
		
		if lastLocation != nil {
			distance = lastLocation!.distance(from: userLocation)
		}else{
			distance = -1
		}

		reverseGeocoder.reverseGeocodeLocation(userLocation ){ (placemarks, error) in
			if error == nil {
				let firstLocation = placemarks?[0]
				let cityName = firstLocation!.locality!
				
				self.forecastModel.updateForecast(cityName: cityName, longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude, distance: distance)
				self.lastLocation = userLocation
				return
				
			}
			else {
				// An error occurred during geocoding.
				print("An error occurred during geocoding.")
			}
		}
		
//		let geocoder = CLGeocoder()
//
//		geocoder.geocodeAddressString("Hemsjö") { (placemarks, error) in
//			
//			if error == nil {
//				if let location = placemarks?.first {
//					print("City: ", location.locality ?? "No city")
//					print("Coordinates: ", location.location?.coordinate ?? "No coordinates")
//				}
//			}
//			return
//		}
		
//		print("user latitude = \(userLocation.coordinate.latitude)")
//		print("user longitude = \(userLocation.coordinate.longitude)")
		

	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error \(error)")
	}
	
}
