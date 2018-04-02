//
//  TodayViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-16.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class TodayView: UITableViewCell {
	
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
	
	func updateWith(forecast: Forecast){
		DispatchQueue.main.async {
			self.tempLabel.text = String("\(Int(forecast.temp.rounded()))°")
			self.dayLabel.text = self.getDayString(components: forecast.date)
			self.rainLabel.text = self.getRainString(precipitation: forecast.precipitationMean)
			self.windLabel.text = "\(forecast.windSpeed) m/s"
			let image = IconHandler.getForecastIcon(symbol: forecast.symbol)
			self.forecastIcon.image = image

		}
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
		backgroundColor = .black
		addSubview(tempLabel)
		addSubview(forecastIcon)
		addSubview(dayLabel)
		addSubview(windIcon)
		addSubview(windLabel)
		addSubview(rainDropp)
		addSubview(rainLabel)
		
		forecastIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		forecastIcon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
		forecastIcon.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
		forecastIcon.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
		
		tempLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor,constant: 20).isActive = true
		tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
		tempLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
		tempLabel.rightAnchor.constraint(equalTo: forecastIcon.leftAnchor).isActive = true
		
		dayLabel.topAnchor.constraint(equalTo: forecastIcon.topAnchor).isActive = true
		dayLabel.leftAnchor.constraint(equalTo: tempLabel.leftAnchor).isActive = true
		dayLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
		dayLabel.rightAnchor.constraint(equalTo: forecastIcon.leftAnchor).isActive = true
		
		windIcon.leftAnchor.constraint(equalTo: forecastIcon.rightAnchor, constant: cemterSpaceing).isActive = true
		windIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
		windIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
		windIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
		
		windLabel.leftAnchor.constraint(equalTo: windIcon.rightAnchor, constant: cemterSpaceing).isActive = true
		windLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -cemterSpaceing).isActive = true
		windLabel.centerYAnchor.constraint(equalTo: windIcon.centerYAnchor).isActive = true
		windLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
		
		rainDropp.leftAnchor.constraint(equalTo: windIcon.leftAnchor).isActive = true
		rainDropp.bottomAnchor.constraint(equalTo: windIcon.topAnchor, constant: -cemterSpaceing).isActive = true
		rainDropp.widthAnchor.constraint(equalToConstant: 30).isActive = true
		rainDropp.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		rainLabel.leftAnchor.constraint(equalTo: rainDropp.rightAnchor, constant: cemterSpaceing).isActive = true
		rainLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -cemterSpaceing).isActive = true
		rainLabel.centerYAnchor.constraint(equalTo: rainDropp.centerYAnchor).isActive = true
		rainLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
	}

}
