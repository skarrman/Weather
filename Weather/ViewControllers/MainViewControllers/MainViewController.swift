//
//  ViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-02-11.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {

	//MARK: Model members
	var forecastModel: ForecastModel!
	var locationServices: LocationServices!
	var currentLocation: Location!
	
	//MARK: View controllers
	let searchViewController: SearchViewController = SearchViewController()
	
	//MARK: UI members
	let loadingView: LoadingView = {
		let view = LoadingView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
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
	
	let themeButton: UIButton = {
		let image = #imageLiteral(resourceName: "SettingsIcon")
		let renderedImage = image.withRenderingMode(.alwaysTemplate)
		let button = UIButton(type: .custom)
		button.setImage(renderedImage, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let locationButton: UIButton = {
		let image = #imageLiteral(resourceName: "LocationIcon")
		let renderedImage = image.withRenderingMode(.alwaysTemplate)
		let button = UIButton(type: .custom)
		button.setImage(renderedImage, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		_ = UINavigationController(rootViewController: self)
		forecastModel = ForecastModel()
		locationServices = LocationServices(forecastModel: forecastModel)
		self.view.addSubview(forecastTableView.view)
//		self.view.addSubview(activityIndicatorView)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.forecastUpdated), name: NSNotification.Name(rawValue: "ForecastUpdated"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.applyTheme), name: NSNotification.Name(rawValue: "ThemeChanged"), object: nil)
		
		searchButton.addTarget(self, action: #selector(self.goToPlacesSearch), for: .touchUpInside)
		themeButton.addTarget(self, action: #selector(self.goToSettings), for: .touchUpInside)
		locationButton.addTarget(self, action: #selector(self.updateWithCurrentLocation), for: .touchUpInside)
		
		
		let search = UIBarButtonItem(customView: searchButton)
		let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
		space.width = 25
		let location = UIBarButtonItem(customView: locationButton)
		navigationItem.rightBarButtonItems = [search, space, location]
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: themeButton)

		
		self.title = ""
		//Init UI elements
//		initActivityIndicator()
		initTableView()
	
		applyTheme()
	}
	
	@objc func goToSettings(){
		let settingsViewController = SettingsViewController()
		let nav = UINavigationController(rootViewController: settingsViewController)
		nav.modalPresentationStyle = .popover
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		nav.navigationBar.barStyle = theme.navigationBarStyle
		nav.navigationBar.tintColor = theme.textColor
		nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : theme.textColor, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 24)]
		
		let popOver = nav.popoverPresentationController
		popOver?.delegate = self
		popOver?.barButtonItem = navigationItem.leftBarButtonItem
//		popOver?.barButtonItem = UIBarButtonItem.
		self.present(nav, animated: true, completion: nil)
	}
	
	func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
		return .popover
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
	
	@objc func applyTheme(){
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		UIApplication.shared.statusBarStyle = theme.statusBarStyle
		navigationController?.navigationBar.barStyle = theme.navigationBarStyle
		navigationController?.navigationBar.tintColor = theme.textColor
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : theme.textColor, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 24)]
		view.backgroundColor = theme.backgroundColor
		searchButton.tintColor = theme.iconColor
		themeButton.tintColor = theme.iconColor
		forecastTableView.applyTheme()
	}
	
	private func startRefreshing(){
		DispatchQueue.main.async {
			self.view.addSubview(self.loadingView)
			self.loadingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
			self.loadingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
			self.loadingView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
			self.loadingView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
			self.loadingView.startRefreshing()
		}
	}
	
	private func  stopRefreshing(){
		loadingView.stopRefreshing()
		DispatchQueue.main.async {
			self.loadingView.removeFromSuperview()
		}
		
	}
	
	@objc func startUpdatingForecast(){
		//updated = false
		startRefreshing()
		locationServices.determineMyLocation()
	}
	
	@objc func updateWithCurrentLocation(){
		startRefreshing()
		if locationServices.isPermissionDetermined(){
			locationServices.determineMyLocation()
		} else {
			locationServices.makeRequest()
		}
	}

	
	@objc private func goToPlacesSearch(){
		let placesSearchViewController = SearchViewController()
		placesSearchViewController.searchTableView.forecastModel = forecastModel
		navigationController?.pushViewController(placesSearchViewController, animated: true)
	}
	
	func refreshForecast(){
		
		if currentLocation != nil {
			startRefreshing()
			forecastModel.updateForecast(location: currentLocation)
		}else{
			startUpdatingForecast()
		}
	}

	
	@objc func forecastUpdated(){
		let forecasts = forecastModel.getForecasts()
		currentLocation = forecastModel.getLocation()
		stopRefreshing()
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

