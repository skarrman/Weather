//
//  ViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-02-11.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
	@IBOutlet weak var tempLabel: UILabel!
	@IBOutlet weak var coordinatesLabel: UILabel!
	

	let forecastModel: ForecastModel
	
	required init?(coder aDecoder: NSCoder) {
		forecastModel = ForecastModel()
		super.init(coder: aDecoder)
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	func updateTemp(){
//		let dateFormatter = ISO8601DateFormatter()
//		for f in forecasts! {
//			guard let date = dateFormatter.date(from: f.validTime) else { return }
//			//print(date)
//			let calendar = Calendar.current
//			let d = calendar.dateComponents([.day, .hour], from: date)
//			print(d.day!, d.hour!)
//		}
//
//		//print(date)
//		for p in forecasts!.first!.parameters {
//			if p.name == "t" {
//				DispatchQueue.main.async {
//					self.tempLabel.text = String(p.values[0])
//				}
//			}
//		}
		
	}
	
	
	
	
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	


}

