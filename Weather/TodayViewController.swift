//
//  TodayViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-16.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
	
	let cityLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 30)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let tempLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 30)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let dayLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 20)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let rainLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 20)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let rainDropp: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "RainDropp"))
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	let windLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 20)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let windIcon: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "Wind"))
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	let forecastIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	let leftSpacing:CGFloat = 20
	let cemterSpaceing: CGFloat = 10
	

    override func viewDidLoad() {
        super.viewDidLoad()
		//self.view.backgroundColor = .gray
		self.view.addSubview(cityLabel)
		self.view.addSubview(tempLabel)
		self.view.addSubview(forecastIcon)
		self.view.addSubview(dayLabel)
		self.view.addSubview(windIcon)
		self.view.addSubview(windLabel)
		self.view.addSubview(rainDropp)
		self.view.addSubview(rainLabel)
		
		setUpViews()

        // Do any additional setup after loading the view.
    }
	
	func updateWith(forecast: Forecast, cityName: String){
		DispatchQueue.main.async {
			self.tempLabel.text = String("\(Int(forecast.temp.rounded()))°")
			self.dayLabel.text = self.getDayString(components: forecast.date)
			self.rainLabel.text = self.getRainString(precipitation: forecast.precipitationMean)
			self.windLabel.text = "\(forecast.windSpeed) m/s"
			let image = IconHandler.getForecastIcon(symbol: forecast.symbol)
			self.forecastIcon.image = image
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
		return "I dag kl \(time)"
	}
	
	func getRainString(precipitation: Double) -> String {
		return "\(precipitation) mm/h"
	}
	
	func setUpViews(){
		cityLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftSpacing).isActive = true
		cityLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		cityLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
		cityLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		
		forecastIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		forecastIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		forecastIcon.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
		forecastIcon.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
		
		tempLabel.leftAnchor.constraint(equalTo: cityLabel.leftAnchor).isActive = true
		tempLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tempLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
		tempLabel.rightAnchor.constraint(equalTo: forecastIcon.leftAnchor).isActive = true
		
		dayLabel.topAnchor.constraint(equalTo: forecastIcon.topAnchor).isActive = true
		dayLabel.leftAnchor.constraint(equalTo: cityLabel.leftAnchor).isActive = true
		dayLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
		dayLabel.rightAnchor.constraint(equalTo: forecastIcon.leftAnchor).isActive = true
		
		windIcon.leftAnchor.constraint(equalTo: forecastIcon.rightAnchor, constant: cemterSpaceing).isActive = true
		windIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		windIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
		windIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
		
		windLabel.leftAnchor.constraint(equalTo: windIcon.rightAnchor, constant: cemterSpaceing).isActive = true
		windLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -cemterSpaceing).isActive = true
		windLabel.centerYAnchor.constraint(equalTo: windIcon.centerYAnchor).isActive = true
		windLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
		
		rainDropp.leftAnchor.constraint(equalTo: windIcon.leftAnchor).isActive = true
		rainDropp.bottomAnchor.constraint(equalTo: windIcon.topAnchor, constant: -cemterSpaceing).isActive = true
		rainDropp.widthAnchor.constraint(equalToConstant: 30).isActive = true
		rainDropp.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		rainLabel.leftAnchor.constraint(equalTo: rainDropp.rightAnchor, constant: cemterSpaceing).isActive = true
		rainLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -cemterSpaceing).isActive = true
		rainLabel.centerYAnchor.constraint(equalTo: rainDropp.centerYAnchor).isActive = true
		rainLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
	}

}
