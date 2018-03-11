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

	var forecastModel: ForecastModel?
	var locationManager: CLLocationManager!
	var center: CGPoint?
	var activityIndicatorView: UIActivityIndicatorView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		forecastModel = ForecastModel()
		center = CGPoint(x: (UIScreen.main.bounds.width * 0.5), y: (UIScreen.main.bounds.height * 0.5))
		activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.forecastUpdated), name: NSNotification.Name(rawValue: "ForecastUpdated"), object: nil)
		determineMyLocation()
		
		activityIndicatorView!.center = self.view.center
		activityIndicatorView!.startAnimating()
		activityIndicatorView!.hidesWhenStopped = true
		self.view.addSubview(activityIndicatorView!)
	}
	
	@objc func forecastUpdated(){
		print("ForecastUpdated! :)")
		
		
		let forecasts = forecastModel!.getForecasts()
		let dateFormatter = ISO8601DateFormatter()
		for f in forecasts {
			guard let date = dateFormatter.date(from: f.validTime) else { return }
			//print(date)
			let calendar = Calendar.current
			let d = calendar.dateComponents([.day, .hour], from: date)
			print(d.day!, d.hour!)
		}

		//print(date)
		var temp = "--"
		for p in forecasts.first!.parameters {
			if p.name == "t" {
				temp = String(p.values[0])
			}
			DispatchQueue.main.async {
				let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
				tempLabel.center = self.view.center
				tempLabel.textAlignment = .center
				tempLabel.text = "\(temp) ℃"
				tempLabel.font = UIFont.systemFont(ofSize: 78)
				tempLabel.textColor = .white
				self.activityIndicatorView!.stopAnimating()
				self.view.addSubview(tempLabel)
			}
		}
		
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
		
		forecastModel!.updateForecast(longitude: userLocation.coordinate.longitude, latitude: userLocation.coordinate.latitude)
		
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error \(error)")
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}

