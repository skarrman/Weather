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
	var todayViewController: TodayViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		forecastModel = ForecastModel()
		locationServices = LocationServices(forecastModel: forecastModel)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.forecastUpdated), name: NSNotification.Name(rawValue: "ForecastUpdated"), object: nil)
	
		//UIApplication.shared.statusBarFrame.height
		
		//Init UI elements
		initMainView()
		initTodayView()
		initActivityIndicator()
	
		
	}
	
	func startUpdatingForecast(){
		//updated = false
		locationServices.determineMyLocation()
	}
	
	@objc func forecastUpdated(){
		let forecasts = forecastModel.getForecasts()
		let cityName = forecastModel.getCityName()
		
		//let temp = forecasts.first!.temp

		//print(date)
		todayViewController.updateWith(forecast: forecasts.first!, cityName: cityName)
		DispatchQueue.main.async {
			if self.activityIndicatorView.isAnimating {
				self.activityIndicatorView.stopAnimating()
			}
		}
		
//		for (i, f) in forecasts.enumerated() {
//			print(i, f)
//		}
		/*
{"validTime":"2018-02-27T09:00:00Z","parameters":[
 msl t vis wd ws r tstm tcc_mean lcc_mean mcc_mean hcc_mean gust pmin pmax spp pcat pmean pmedian Wsymb2"*/
		
	}
	
	func initMainView() {
		//view.translatesAutoresizingMaskIntoConstraints = false
		//Asså this shit...
		//view.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
		view.backgroundColor = .black
	}
	
	func initActivityIndicator() {
		activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		activityIndicatorView.center = self.view.center
		activityIndicatorView.startAnimating()
		activityIndicatorView.hidesWhenStopped = true
		self.view.addSubview(activityIndicatorView!)
	}
	
	func initTodayView() {
		todayViewController = TodayViewController()
		self.addChildViewController(todayViewController)
		todayViewController.didMove(toParentViewController: self)
		
		//Contraints
		todayViewController.view.translatesAutoresizingMaskIntoConstraints = false
		todayViewController.view.bounds = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.bounds.width, height: self.view.bounds.height * 0.3)
		todayViewController.view.center = CGPoint(x: self.view.center.x, y: todayViewController.view.bounds.height * 0.5 + UIApplication.shared.statusBarFrame.height)
		self.view.addSubview(todayViewController.view)
		
	}
	

	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}

