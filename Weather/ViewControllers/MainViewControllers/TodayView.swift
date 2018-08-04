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
		label.textAlignment = .right
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
		label.font = UIFont.systemFont(ofSize: 20)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let rainDropp: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "RainDropp").withRenderingMode(.alwaysTemplate))
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	let windLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .right
		label.font = UIFont.systemFont(ofSize: 20)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let windIcon: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "Wind").withRenderingMode(.alwaysTemplate))
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
			image.withRenderingMode(.alwaysTemplate)
			self.forecastIcon.image = image

		}
	}
	func getDayString(components: DateComponents) -> String {
		let dateFormatter = DateFormatter()
		
		dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
		let time = components.hour!
		return "\(NSLocalizedString("today_at", comment: "")) \(time)"
	}
	
	func getRainString(precipitation: Double) -> String {
		return "\(precipitation) mm/h"
	}
	
	private func applyTheme(){
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		backgroundColor = theme.backgroundColor
		tempLabel.textColor = theme.textColor
		dayLabel.textColor = theme.textColor
		windLabel.textColor = theme.textColor
		rainLabel.textColor = theme.textColor
		forecastIcon.tintColor = theme.iconColor
		rainDropp.tintColor = theme.iconColor
		windIcon.tintColor = theme.iconColor
	}
	
	func setUpViews(){
		addSubview(tempLabel)
		addSubview(forecastIcon)
		addSubview(dayLabel)
		addSubview(windIcon)
		addSubview(windLabel)
		addSubview(rainDropp)
		addSubview(rainLabel)
		
		forecastIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		forecastIcon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
		forecastIcon.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
		forecastIcon.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
		
		tempLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,constant: -20).isActive = true
		tempLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
		tempLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
		tempLabel.leftAnchor.constraint(equalTo: forecastIcon.rightAnchor).isActive = true
		
		dayLabel.topAnchor.constraint(equalTo: forecastIcon.topAnchor).isActive = true
		dayLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
		dayLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
		dayLabel.rightAnchor.constraint(equalTo: forecastIcon.leftAnchor).isActive = true
		
		rainDropp.leftAnchor.constraint(equalTo: dayLabel.leftAnchor).isActive = true
		rainDropp.bottomAnchor.constraint(equalTo:safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
		rainDropp.widthAnchor.constraint(equalToConstant: 30).isActive = true
		rainDropp.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		rainLabel.leftAnchor.constraint(equalTo: rainDropp.rightAnchor, constant: cemterSpaceing).isActive = true
		rainLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -cemterSpaceing).isActive = true
		rainLabel.centerYAnchor.constraint(equalTo: rainDropp.centerYAnchor).isActive = true
		rainLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
		
		windLabel.rightAnchor.constraint(equalTo: tempLabel.rightAnchor).isActive = true
		windLabel.heightAnchor.constraint(equalTo: rainLabel.heightAnchor).isActive = true
		windLabel.centerYAnchor.constraint(equalTo: rainLabel.centerYAnchor).isActive = true
		
		windIcon.rightAnchor.constraint(equalTo: windLabel.leftAnchor, constant: -cemterSpaceing).isActive = true
		windIcon.centerYAnchor.constraint(equalTo: windLabel.centerYAnchor).isActive = true
		windIcon.heightAnchor.constraint(equalTo: rainDropp.heightAnchor).isActive = true
		windIcon.widthAnchor.constraint(equalTo: rainDropp.widthAnchor).isActive = true
		
		applyTheme()
	}

}
