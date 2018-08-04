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
		//locationManager.requestWhenInUseAuthorization()
		
	}
	
	func makeRequest() {
		locationManager.requestWhenInUseAuthorization()
	}
	
	func determineMyLocation(){
		if isPermissionDetermined() && CLLocationManager.locationServicesEnabled(){
			locationManager.startUpdatingLocation()
		}else {
			reverseGeocode(userLocation: CLLocation(latitude: 59.331495, longitude: 18.056975))
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse {
			locationManager.startUpdatingLocation()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		var userLocation: CLLocation!
		if TARGET_IPHONE_SIMULATOR == 0 {
			userLocation = locations[0] as CLLocation
		}else {
			userLocation = CLLocation(latitude: 57.857539, longitude: 12.502884)
			//userLocation = CLLocation(latitude: 59.331495, longitude: 18.056975)
		}
		manager.stopUpdatingLocation()
		
		
		reverseGeocode(userLocation: userLocation)
		
//		let geocoder = CLGeocoder()
//
//		geocoder.geocodeAddressString("Göteborg") { (placemarks, error) in
//
//			if error == nil {
//				for location in placemarks!{
//					print("City: ", location.locality ?? "No city")
//					print("Coordinates: ", location.location?.coordinate ?? "No coordinates")
//				}
//			}
//			return
//		}
//
//		print("user latitude = \(userLocation.coordinate.latitude)")
//		print("user longitude = \(userLocation.coordinate.longitude)")
		

	}
	
	private func reverseGeocode(userLocation: CLLocation){
		let reverseGeocoder = CLGeocoder()
		reverseGeocoder.reverseGeocodeLocation(userLocation ){ (placemarks, error) in
			if error == nil {
				let firstLocation = placemarks?[0]
				let cityName = firstLocation!.locality!
				let l = Location(name: cityName, longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude)
				self.forecastModel.updateForecast(location: l)
				return
				
			}
			else {
				// An error occurred during geocoding.
				print("An error occurred during geocoding.")
			}
		}
	}
	
	func isPermissionDetermined() -> Bool {
		return CLLocationManager.authorizationStatus() != .notDetermined
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error \(error)")
	}
	
}
