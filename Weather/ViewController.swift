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
	
		activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.forecastUpdated), name: NSNotification.Name(rawValue: "ForecastUpdated"), object: nil)
		tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
		tempLabel.center = self.view.center
		tempLabel.textAlignment = .center
		tempLabel.font = UIFont.systemFont(ofSize: 60)
		tempLabel.textColor = .white
		
		cityLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
		cityLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y - self.view.center.y * 0.5)
		cityLabel.textAlignment = .center
		cityLabel.font = UIFont.systemFont(ofSize: 60)
		cityLabel.textColor = .white
	}
	
	func startUpdatingForecast(){
		activityIndicatorView!.center = self.view.center
		activityIndicatorView!.startAnimating()
		activityIndicatorView!.hidesWhenStopped = true
		self.view.addSubview(activityIndicatorView!)
		locationServices.determineMyLocation()
	}
	
	@objc func forecastUpdated(){
		
		
		let forecasts = forecastModel.getForecasts()
		let cityName = forecastModel.getCityName()
		let dateFormatter = ISO8601DateFormatter()
		for f in forecasts {
			guard let date = dateFormatter.date(from: f.validTime) else { return }
			//print(date)
			let calendar = Calendar.current
			let d = calendar.dateComponents([.day, .hour], from: date)
			//print(d.day!, d.hour!)
		}

		//print(date)
		var temp = "--"
		for p in forecasts.first!.parameters {
			if p.name == "t" {
				temp = String(p.values[0])
			}
			DispatchQueue.main.async {
				self.tempLabel.text = "\(temp) ℃"
				self.cityLabel.text = cityName
				self.activityIndicatorView!.stopAnimating()
				self.view.addSubview(self.tempLabel)
				self.view.addSubview(self.cityLabel)
			}
		}
		var corr = true
		for f in forecasts {
			let order = ["msl", "t", "vis", "wd", "ws", "r", "tstm", "tcc_mean", "lcc_mean", "mcc_mean", "hcc_mean", "gust", "pmin", "pmax", "spp", "pcat", "pmean", "pmedian", "Wsymb2"]
			for (i , p) in f.parameters.enumerated() {
				//print(p.name, order[i])
				if(p.name != order[i]){
					corr = false
					break
				}
			}
		}
		print(corr)
		
		/*
{"validTime":"2018-02-27T09:00:00Z","parameters":[
 msl t vis wd ws r tstm tcc_mean lcc_mean mcc_mean hcc_mean gust pmin pmax spp pcat pmean pmedian Wsymb2"*/
		
	}
	
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}

