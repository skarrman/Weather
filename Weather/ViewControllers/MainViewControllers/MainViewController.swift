//
//  ViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-02-11.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit
import RxSwift


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
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return ThemeHandler.getInstance().getCurrentTheme().statusBarStyle
	}
	
	let disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		_ = UINavigationController(rootViewController: self)
		forecastModel = ForecastModel()
		locationServices = LocationServices()
		self.view.addSubview(forecastTableView.view)
		
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
		setUpSearchBehavior()
	}
	
	@objc func goToSettings(){
		let settingsViewController = SettingsViewController()
		let nav = UINavigationController(rootViewController: settingsViewController)
		nav.modalPresentationStyle = .popover
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		nav.navigationBar.barStyle = theme.navigationBarStyle
		nav.navigationBar.tintColor = theme.textColor
		nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : theme.textColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)]
		
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
		
		navigationController?.navigationBar.barStyle = theme.navigationBarStyle
		navigationController?.navigationBar.tintColor = theme.textColor
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : theme.textColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)]
		setNeedsStatusBarAppearanceUpdate()
		applyTheme()
	}
	
	@objc func applyTheme(){
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		navigationController?.navigationBar.barStyle = theme.navigationBarStyle
		navigationController?.navigationBar.tintColor = theme.textColor
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : theme.textColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)]
		view.backgroundColor = theme.backgroundColor
		searchButton.tintColor = theme.iconColor
		themeButton.tintColor = theme.iconColor
		setNeedsStatusBarAppearanceUpdate()
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
	
	@objc func updateWithCurrentLocation(){
		startRefreshing()
		if locationServices.isPermissionDetermined(){
			updateForecastForCurrentLocation()
		} else {
			locationServices.makeRequest()
		}
	}
	
	private func setUpSearchBehavior(){
		searchViewController
			.searchTableView
			.locationSubject
			.subscribe(onNext: {
				location in
				
				self.updateForecast(for: location)
				
			}
			).disposed(by: disposeBag)
		
	}

	
	@objc private func goToPlacesSearch(){
		navigationController?.pushViewController(searchViewController, animated: true)
	}
	
	
	
	func refreshForecast(){
		if currentLocation != nil {
			startRefreshing()
			updateForecast(for: currentLocation)
		} else {
			updateWithCurrentLocation()
		}
	}
	
	private func updateForecastForCurrentLocation() {
		locationServices.getCurrentLocation()
			.subscribeOn(CurrentThreadScheduler.instance)
			.map { location in
				return self.forecastModel.getForecast(for: location)
			}
			.observeOn(MainScheduler.instance)
			.subscribe( onSuccess: { single in
				single.subscribe(
					onSuccess: { forecasts in
						self.update(forecasts)
				}, onError: { error in
					print("Error when getting forecast for current location: ",error)
				}).disposed(by: self.disposeBag)
			}
			)
			.disposed(by: disposeBag)
		}
	
	func updateForecast(for location: Location) {
		forecastModel.getForecast(for: location)
			.subscribeOn(CurrentThreadScheduler.instance)
			.observeOn(MainScheduler.instance)
			.subscribe(
				onSuccess: { forecasts in
					
					self.update(forecasts)
				},
				onError: { error in
					print("Error when getting forecast for other location:", error)
				}
			)
			.disposed(by: disposeBag)
	}

	
	func update(_ forecasts: [Forecast]){
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
		self.addChild(forecastTableView)
		forecastTableView.didMove(toParent: self)
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

