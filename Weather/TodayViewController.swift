//
//  TodayViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-16.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
	
	var cityLabel: UILabel!
	var tempLabel: UILabel!
	var dayLabel: UILabel!
	var rainLabel: UILabel!
	var rainDropp: UIImageView!
	var windLabel: UILabel!
	var windIcon: UIImageView!
	let leftSpacing:CGFloat = 20
	let cemterSpaceing: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
		//self.view.backgroundColor = .white
		

        // Do any additional setup after loading the view.
    }
	
	func updateWith(forecast: Forecast, cityName: String){
		DispatchQueue.main.async {
			self.initCityLabel()
			self.initTempLabel()
			self.initDateLabel()
			self.initRainLabel()
			self.initWindIcon()
			
		
			self.tempLabel.text = String("\(Int(forecast.temp.rounded()))℃")
			self.dayLabel.text = self.getDayString(components: forecast.date)
			self.rainLabel.text = self.getRainString(precipitation: forecast.precipitationMean)
			self.windLabel.text = "\(forecast.windSpeed) m/s"
			//self.tempLabel.text = String("-42℃")
			//self.tempLabel.text = String("40℃")
			
			self.cityLabel.text = cityName
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func getDayString(components: DateComponents) -> String {
		let dateFormatter = DateFormatter()
		
		dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
		let time = components.hour!

//		let weekday = dateFormatter.weekdaySymbols[components.weekday! - 1].capitalized
//		let day = components.day!
//		let month = dateFormatter.monthSymbols[components.month!].capitalized
		
		return "I dag kl \(time)"
	}
	
	func getRainString(precipitation: Double) -> String {
		return "\(precipitation) mm/h"
	}
	
	func initRainLabel(){
		rainLabel = UILabel(frame: CGRect(x: view.center.x + self.view.bounds.height * 0.1 + cemterSpaceing, y: self.view.frame.origin.y + self.view.bounds.height * 0.2 , width: self.view.bounds.width - cemterSpaceing * 0.5, height: self.view.bounds.height * 0.2))
		//rainLabel.backgroundColor = .orange
		rainLabel.textAlignment = .left
		rainLabel.adjustsFontSizeToFitWidth = true
		rainLabel.font = UIFont.systemFont(ofSize: rainLabel.bounds.height * 0.5)
		rainLabel.textColor = .white
		self.view.addSubview(self.rainLabel)
		rainDropp = UIImageView(frame: CGRect(x: self.view.center.x, y: rainLabel.center.y - self.view.bounds.height * 0.05, width: self.view.bounds.height * 0.1, height: self.view.bounds.height * 0.1))
		rainDropp.image = #imageLiteral(resourceName: "RainDropp")
		self.view.addSubview(rainDropp)
		
	}
	
	func initWindIcon(){
		windLabel = UILabel(frame: CGRect(x: view.center.x + self.view.bounds.height * 0.1 + cemterSpaceing, y: self.view.center.y - self.view.bounds.height * 0.2 , width: self.view.bounds.width - cemterSpaceing * 0.5, height: self.view.bounds.height * 0.2))
		windLabel.center.y = tempLabel.center.y
		//rainLabel.backgroundColor = .orange
		windLabel.textAlignment = .left
		windLabel.adjustsFontSizeToFitWidth = true
		windLabel.font = UIFont.systemFont(ofSize: windLabel.bounds.height * 0.5)
		windLabel.textColor = .white
		self.view.addSubview(self.windLabel)
		windIcon = UIImageView(frame: CGRect(x: self.view.center.x, y: 0, width: self.view.bounds.height * 0.1, height: self.view.bounds.height * 0.1))
		windIcon.center.y = tempLabel.center.y
		windIcon.image = #imageLiteral(resourceName: "Wind")
		self.view.addSubview(windIcon)
		
	}
	
	func initDateLabel(){
		dayLabel = UILabel(frame: CGRect(x: leftSpacing, y: self.view.frame.origin.y + self.view.bounds.height * 0.2 , width: self.view.bounds.width - leftSpacing * 0.5, height: self.view.bounds.height * 0.2))
		//dayLabel.backgroundColor = .orange
		dayLabel.textAlignment = .left
		dayLabel.adjustsFontSizeToFitWidth = true
		dayLabel.font = UIFont.systemFont(ofSize: tempLabel.bounds.height * 0.4)
		dayLabel.textColor = .white
		self.view.addSubview(self.dayLabel)
	}
	
	
	func initTempLabel() {
		tempLabel = UILabel(frame: CGRect(x: leftSpacing, y: 0, width: self.view.bounds.width * 0.3, height: self.view.bounds.height * 0.2))
		tempLabel.center = CGPoint(x: tempLabel.bounds.width * 0.5 + leftSpacing, y: self.view.center.y)
		//tempLabel.backgroundColor = .green
		tempLabel.textAlignment = .left
		tempLabel.adjustsFontSizeToFitWidth = true
		tempLabel.font = UIFont.systemFont(ofSize: tempLabel.bounds.height - 10)
		tempLabel.textColor = .white
		self.view.addSubview(self.tempLabel)
		
	}
	
	func initCityLabel() {
		cityLabel = UILabel(frame: CGRect(x: leftSpacing, y: self.view.frame.origin.y, width: self.view.bounds.width - leftSpacing, height: self.view.bounds.height * 0.2))
		cityLabel.textAlignment = .left
		//cityLabel.backgroundColor = .red
		cityLabel.adjustsFontSizeToFitWidth = true
		cityLabel.font = UIFont.systemFont(ofSize: cityLabel.bounds.height - 10)
		cityLabel.textColor = .white
		self.view.addSubview(self.cityLabel)
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
