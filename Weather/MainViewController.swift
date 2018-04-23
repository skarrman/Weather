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
	
	var forecastTableView: ForecsatTableViewController = {
		let tableViewController = ForecsatTableViewController()
		tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableViewController
	}()
	var activityIndicatorView: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.hidesWhenStopped = true
		return view
	}()
	
	let searchResultController: LocationSearchResultController = LocationSearchResultController()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		
		
		_ = UINavigationController(rootViewController: self)
		forecastModel = ForecastModel()
		locationServices = LocationServices(forecastModel: forecastModel)
		self.view.addSubview(forecastTableView.view)
		self.view.addSubview(activityIndicatorView)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.forecastUpdated), name: NSNotification.Name(rawValue: "ForecastUpdated"), object: nil)
		let image = #imageLiteral(resourceName: "SearchIcon")
		let button: UIButton = {
			let button = UIButton(type: .custom)
			button.setImage(image, for: .normal)
			button.addTarget(self, action: #selector(self.goToLocationSeach), for: .touchUpInside)
			button.translatesAutoresizingMaskIntoConstraints = false
			return button
		}()
		
		button.widthAnchor.constraint(equalToConstant: 25).isActive = true
		button.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
		
		
		
		self.title = ""
		
		//Init UI elements
		initActivityIndicator()
		initTableView()
	}
	
	func startUpdatingForecast(){
		//updated = false
		locationServices.determineMyLocation()
	}
	
	@objc private func goToLocationSeach(){
		let locationSearchContreoller = LocationSearchResultController()
		locationSearchContreoller.locationSearchTableView.forecastModel = forecastModel
		locationSearchContreoller.locationServices = locationServices
		navigationController?.pushViewController(locationSearchContreoller, animated: true)
	}

	
	@objc func forecastUpdated(){
		let forecasts = forecastModel.getForecasts()
		let cityName = forecastModel.getCityName()
		
		forecastTableView.updateWithForecast(forecasts: forecasts)
		DispatchQueue.main.async {
			self.title = cityName
			//self.navigationController?.navigationBar.prefersLargeTitles = true
			//self.viewDidLoad()
			
			if self.activityIndicatorView.isAnimating {
				self.activityIndicatorView.stopAnimating()
			}
		}
		
	}
	
	func initTableView() {
		let tableView = forecastTableView.tableView!
		self.addChildViewController(forecastTableView)
		forecastTableView.didMove(toParentViewController: self)
		tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
	}
	
	func initActivityIndicator() {
		activityIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
		activityIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
		activityIndicatorView.startAnimating()
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}

