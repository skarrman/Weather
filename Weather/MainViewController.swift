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
	
	
	var todayViewController: TodayViewController = {
		let viewController = TodayViewController()
		viewController.view.translatesAutoresizingMaskIntoConstraints = false
		return viewController
	}()
	var forecastTableView: ForecsatTableViewController = {
		let tableViewController = ForecsatTableViewController()
		tableViewController.view.translatesAutoresizingMaskIntoConstraints = false
		return tableViewController
	}()
	var activityIndicatorView: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.hidesWhenStopped = true
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		
		
		_ = UINavigationController(rootViewController: self)
		forecastModel = ForecastModel()
		locationServices = LocationServices(forecastModel: forecastModel)
		self.view.addSubview(todayViewController.view)
		self.view.addSubview(forecastTableView.view)
		self.view.addSubview(activityIndicatorView)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.forecastUpdated), name: NSNotification.Name(rawValue: "ForecastUpdated"), object: nil)
		
		//Init UI elements
		initTodayView()
		initActivityIndicator()
		initTableView()
	}
	
	func startUpdatingForecast(){
		//updated = false
		locationServices.determineMyLocation()
	}

	
	@objc func forecastUpdated(){
		let forecasts = forecastModel.getForecasts()
		let cityName = forecastModel.getCityName()
		
		todayViewController.updateWith(forecast: forecasts.first!, cityName: cityName)
		forecastTableView.updateWithForecast(forecasts: forecasts)
		DispatchQueue.main.async {
			if self.activityIndicatorView.isAnimating {
				self.activityIndicatorView.stopAnimating()
			}
		}
		
	}
	
	func initTableView() {
		let tableView = forecastTableView.view!
		self.addChildViewController(forecastTableView)
		forecastTableView.didMove(toParentViewController: self)
		tableView.topAnchor.constraint(equalTo: todayViewController.view.bottomAnchor, constant: 20).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
	}
	
	func initActivityIndicator() {
		activityIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
		activityIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
		activityIndicatorView.startAnimating()
	}
	
	func initTodayView() {
		self.addChildViewController(todayViewController)
		todayViewController.didMove(toParentViewController: self)
		//todayViewController.view.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height * 0.3)

		//Contraints
		let todayView = todayViewController.view!
		todayView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		todayView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
		todayView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
		todayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}

