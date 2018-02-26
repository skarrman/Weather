//
//  ViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-02-11.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
	@IBOutlet weak var tempLabel: UILabel!
	@IBOutlet weak var coordinatesLabel: UILabel!
	
	var forecast: Forecast?
	
	var locationManager: CLLocationManager!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		determineMyLocation()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
	}
	
	func updateTemp(){
		for p in forecast!.timeSeries[0].parameters {
			if p.name == "t" {
				DispatchQueue.main.async {
					self.tempLabel.text = String(p.values[0])
				}
			}
		}
		print(forecast?.geometry.coordinates ?? "")
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
				self.forecast = try JSONDecoder().decode(Forecast.self, from: data)
				self.updateTemp()
				
				
				//print(forecast)
				
			}  catch let jsonErr {
				print("Error serilizing json", jsonErr)
			}
			}.resume()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation:CLLocation = locations[0] as CLLocation
		
		manager.stopUpdatingLocation()
		coordinatesLabel.text = "\(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)"
		
		updateForecast(longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude)
		
		print("user latitude = \(userLocation.coordinate.latitude)")
		print("user longitude = \(userLocation.coordinate.longitude)")
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error \(error)")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}

