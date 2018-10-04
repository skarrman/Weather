//
//  TodayViewController.swift
//  ForecastTodayView
//
//  Created by Simon Kärrman on 2018-09-10.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit
import NotificationCenter
import RxSwift

class TodayViewController: UIViewController, NCWidgetProviding {
	
	private let locationServices: LocationServices = LocationServices()
	private let forecastModel: ForecastModel = ForecastModel()
	private let disposeBag: DisposeBag = DisposeBag()
	
	let label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 18)
		label.textAlignment = .center
		return label
	}()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
		
		self.view.addSubview(label)
		label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
		
		locationServices.getCurrentLocation()
			.subscribeOn(CurrentThreadScheduler.instance)
			.map { location in
				return self.forecastModel.getForecast(for: location)
			}
			.observeOn(MainScheduler.instance)
			.subscribe(onSuccess: { single in
				single.subscribe(onSuccess: { forecasts in
					self.label.text = "\(forecasts.first!.temp.rounded())°"
					completionHandler(NCUpdateResult.newData)
				})
				.disposed(by: self.disposeBag)
			})
			.disposed(by: disposeBag)
    }
    
}
