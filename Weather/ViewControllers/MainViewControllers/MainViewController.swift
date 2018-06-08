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
	
	let searchButton: UIButton = {
		let image = #imageLiteral(resourceName: "SearchIcon")
		let renderedImage = image.withRenderingMode(.alwaysTemplate)
		let button = UIButton(type: .custom)
		button.setImage(renderedImage, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let themebutton: UIButton = {
		let image = #imageLiteral(resourceName: "Fog")
		let renderedImage = image.withRenderingMode(.alwaysTemplate)
		let button = UIButton(type: .custom)
		button.setImage(renderedImage, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

//	let searchResultController: LocationSearchResultController = LocationSearchResultController()
	var currentLocation: Location!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		_ = UINavigationController(rootViewController: self)
		forecastModel = ForecastModel()
		locationServices = LocationServices(forecastModel: forecastModel)
		self.view.addSubview(forecastTableView.view)
//		self.view.addSubview(activityIndicatorView)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.forecastUpdated), name: NSNotification.Name(rawValue: "ForecastUpdated"), object: nil)
		
		searchButton.addTarget(self, action: #selector(self.goToPlacesSearch), for: .touchUpInside)
		themebutton.addTarget(self, action: #selector(self.changeTheme), for: .touchUpInside)
		
		searchButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
		searchButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		themebutton.widthAnchor.constraint(equalToConstant: 25).isActive = true
		themebutton.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: themebutton)
		
		
		
		self.title = ""
		//Init UI elements
//		initActivityIndicator()
		initTableView()
		applyTheme()
	}
	
	@objc func changeTheme(){
		let handler = ThemeHandler.getInstance()
		if view.backgroundColor == .black {
			handler.changeTheme(to: .white)
		}else {
			handler.changeTheme(to: .black)
		}
		let theme = handler.getCurrentTheme()
		UIApplication.shared.statusBarStyle = theme.statusBarStyle
		navigationController?.navigationBar.barStyle = theme.navigationBarStyle
		navigationController?.navigationBar.tintColor = theme.textColor
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : theme.textColor, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 24)]
		applyTheme()
	}
	
	func applyTheme(){
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		view.backgroundColor = theme.backgroundColor
		searchButton.tintColor = theme.iconColor
		themebutton.tintColor = theme.iconColor
		forecastTableView.applyTheme()
	}
	
	func startUpdatingForecast(){
		//updated = false
		locationServices.determineMyLocation()
	}

	
	@objc private func goToPlacesSearch(){
		let placesSearchViewController = SearchViewController()
		placesSearchViewController.locationServices = locationServices
		placesSearchViewController.searchTableView.forecastModel = forecastModel
		navigationController?.pushViewController(placesSearchViewController, animated: true)
	}
	
	func refreshForecast(){
		forecastTableView.startRefreshing()
		if currentLocation != nil {
			forecastModel.updateForecast(location: currentLocation)
		}else{
			startUpdatingForecast()
		}
	}

	
	@objc func forecastUpdated(){
		let forecasts = forecastModel.getForecasts()
		currentLocation = forecastModel.getLocation()
		
		forecastTableView.updateWithForecast(forecasts: forecasts)
		DispatchQueue.main.async {
			self.title = self.currentLocation.name
			//self.navigationController?.navigationBar.prefersLargeTitles = true
			//self.viewDidLoad()
			
//			if self.activityIndicatorView.isAnimating {
//				self.activityIndicatorView.stopAnimating()
//			}
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
	

	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}

