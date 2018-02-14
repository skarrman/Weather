//
//  ViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-02-11.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

struct Course: Decodable{
	
	let id: Int
	let name: String
	let link: String
	let imageUrl: String
	
}
class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let urlString = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/16.158/lat/58.5812/data.json"
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data else { return }
			
			//Check for error and response
			
			do{
				let forecast = try JSONDecoder().decode(Forecast.self, from: data)
				print(forecast)
			}  catch let jsonErr {
				print("Error serilizing json", jsonErr)
			}
		}.resume()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

