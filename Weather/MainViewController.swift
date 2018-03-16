//
//  ViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-02-11.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

	var forecastModel: ForecastModel!
	var locationServices: LocationServices!
	
	var activityIndicatorView: UIActivityIndicatorView!
	var cityLabel: UILabel!
	var tempLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		forecastModel = ForecastModel()
		locationServices = LocationServices(forecastModel: forecastModel)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.forecastUpdated), name: NSNotification.Name(rawValue: "ForecastUpdated"), object: nil)
	
		//UIApplication.shared.statusBarFrame.height
		
		//Init UI elements
		initActivityIndicator()
		initTempLabel()
		initCityLabel()
	}
	
	func startUpdatingForecast(){
		//updated = false
		locationServices.determineMyLocation()
	}
	
	@objc func forecastUpdated(){
		let forecasts = forecastModel.getForecasts()
		let cityName = forecastModel.getCityName()
		
		let temp = forecasts.first!.temp

		//print(date)
		DispatchQueue.main.async {
			self.tempLabel.text = "\(temp) ℃"
			self.cityLabel.text = cityName
			if self.activityIndicatorView.isAnimating {
				self.activityIndicatorView.stopAnimating()
			}
			self.view.addSubview(self.tempLabel)
			self.view.addSubview(self.cityLabel)
			
		}
		
//		for (i, f) in forecasts.enumerated() {
//			print(i, f)
//		}
		/*
{"validTime":"2018-02-27T09:00:00Z","parameters":[
 msl t vis wd ws r tstm tcc_mean lcc_mean mcc_mean hcc_mean gust pmin pmax spp pcat pmean pmedian Wsymb2"*/
		
	}
	
	func initActivityIndicator() {
		activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		activityIndicatorView.center = self.view.center
		activityIndicatorView.startAnimating()
		activityIndicatorView.hidesWhenStopped = true
		self.view.addSubview(activityIndicatorView!)
	}
	
	func initTempLabel() {
		tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
		tempLabel.center = self.view.center
		tempLabel.textAlignment = .center
		tempLabel.font = UIFont.systemFont(ofSize: 60)
		tempLabel.textColor = .white
	}
	
	func initCityLabel() {
		cityLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
		cityLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y - self.view.center.y * 0.5)
		cityLabel.textAlignment = .center
		cityLabel.font = UIFont.systemFont(ofSize: 60)
		cityLabel.textColor = .white
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}

