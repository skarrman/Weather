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
	

	let forecastModel: ForecastModel
	var locationManager: CLLocationManager!
	
	required init?(coder aDecoder: NSCoder) {
		forecastModel = ForecastModel()
		super.init(coder: aDecoder)
		determineMyLocation()
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	func updateTemp(){
//		let dateFormatter = ISO8601DateFormatter()
//		for f in forecasts! {
//			guard let date = dateFormatter.date(from: f.validTime) else { return }
//			//print(date)
//			let calendar = Calendar.current
//			let d = calendar.dateComponents([.day, .hour], from: date)
//			print(d.day!, d.hour!)
//		}
//
//		//print(date)
//		for p in forecasts!.first!.parameters {
//			if p.name == "t" {
//				DispatchQueue.main.async {
//					self.tempLabel.text = String(p.values[0])
//				}
//			}
//		}
		
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
		
		print("user latitude = \((userLocation.coordinate.latitude * 10000).rounded() / 10000)")
		print("user longitude = \((userLocation.coordinate.longitude * 10000).rounded() / 10000)")
		
		forecastModel.updateForecast(longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude)
		
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error \(error)")
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}

