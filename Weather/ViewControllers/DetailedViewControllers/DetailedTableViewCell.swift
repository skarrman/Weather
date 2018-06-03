//
//  DetailedTableViewCell.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-04-02.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class DetailedTableViewCell: UITableViewCell {

	let dayLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.textAlignment = .left
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let forecastIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	let tempLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 18)
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
	let rainIcon: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "RainDropp"))
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	let windLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.textAlignment = .left
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let rainLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.textAlignment = .left
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	func setUpCell(forecast: Forecast, daysInForecast: Int){
		backgroundColor = .black
		let leftView: UIView = {
			let view = UIView()
			view.translatesAutoresizingMaskIntoConstraints = false
			return view
		}()
		let leftCenterView: UIView = {
			let view = UIView()
			view.translatesAutoresizingMaskIntoConstraints = false
			return view
		}()
		let rightCenterView: UIView = {
			let view = UIView()
			view.translatesAutoresizingMaskIntoConstraints = false
			return view
		}()
		let rightView: UIView = {
			let view = UIView()
			view.translatesAutoresizingMaskIntoConstraints = false
			return view
		}()
		
		addSubview(leftView)
		leftView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		leftView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		leftView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		leftView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
		leftView.addSubview(dayLabel)
		dayLabel.leftAnchor.constraint(equalTo: leftView.leftAnchor, constant: 20).isActive = true
		dayLabel.centerYAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
		dayLabel.widthAnchor.constraint(equalTo: leftView.widthAnchor).isActive = true
		dayLabel.heightAnchor.constraint(equalTo: leftView.heightAnchor, multiplier: 0.8).isActive = true
		
		addSubview(leftCenterView)
		leftCenterView.leftAnchor.constraint(equalTo: leftView.rightAnchor).isActive = true
		leftCenterView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		leftCenterView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		leftCenterView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
		
		leftCenterView.addSubview(forecastIcon)
		forecastIcon.centerXAnchor.constraint(equalTo: leftCenterView.centerXAnchor).isActive = true
		forecastIcon.centerYAnchor.constraint(equalTo:leftCenterView.centerYAnchor).isActive = true
		forecastIcon.heightAnchor.constraint(equalTo: leftCenterView.heightAnchor, multiplier: 0.8).isActive = true
		forecastIcon.widthAnchor.constraint(equalTo: leftCenterView.heightAnchor, multiplier: 0.8).isActive = true
		
		addSubview(rightCenterView)
		rightCenterView.leftAnchor.constraint(equalTo: leftCenterView.rightAnchor).isActive = true
		rightCenterView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		rightCenterView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		rightCenterView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
		
		addSubview(rightView)
		rightView.leftAnchor.constraint(equalTo: rightCenterView.rightAnchor).isActive = true
		rightView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		rightView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		rightView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		
		rightView.addSubview(windIcon)
		windIcon.leftAnchor.constraint(equalTo: rightView.leftAnchor).isActive = true
		windIcon.bottomAnchor.constraint(equalTo: rightView.bottomAnchor, constant: -10).isActive = true
		windIcon.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
		windIcon.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
		
		rightView.addSubview(rainIcon)
		rainIcon.leftAnchor.constraint(equalTo: rightView.leftAnchor).isActive = true
		rainIcon.topAnchor.constraint(equalTo: rightView.topAnchor, constant: 10).isActive = true
		rainIcon.widthAnchor.constraint(equalTo: rightView.heightAnchor, multiplier: 0.3).isActive = true
		rainIcon.heightAnchor.constraint(equalTo: rightView.heightAnchor, multiplier: 0.3).isActive = true
		
		rightView.addSubview(windLabel)
		windLabel.centerYAnchor.constraint(equalTo: windIcon.centerYAnchor).isActive = true
		windLabel.leftAnchor.constraint(equalTo: windIcon.rightAnchor, constant: 10).isActive = true
		windLabel.rightAnchor.constraint(equalTo: rightView.rightAnchor, constant: -10).isActive = true
		windLabel.heightAnchor.constraint(equalTo: windIcon.heightAnchor).isActive = true
		
		
		rightView.addSubview(rainLabel)
		rainLabel.centerYAnchor.constraint(equalTo: rainIcon.centerYAnchor).isActive = true
		rainLabel.leftAnchor.constraint(equalTo: rainIcon.rightAnchor, constant: 10).isActive = true
		rainLabel.rightAnchor.constraint(equalTo: rightView.rightAnchor, constant: -10).isActive = true
		rainLabel.heightAnchor.constraint(equalTo: rainIcon.heightAnchor).isActive = true
		
		
		dayLabel.text = getDetailedDayString(components: forecast.date)
		
		forecastIcon.image = IconHandler.getForecastIcon(symbol: forecast.symbol)
		
		rightCenterView.addSubview(tempLabel)
		tempLabel.centerYAnchor.constraint(equalTo: rightCenterView.centerYAnchor).isActive = true
		tempLabel.centerXAnchor.constraint(equalTo: rightCenterView.centerXAnchor).isActive = true
		tempLabel.widthAnchor.constraint(equalTo: rightCenterView.widthAnchor).isActive = true
		tempLabel.heightAnchor.constraint(equalTo: rightCenterView.heightAnchor, multiplier: 0.9).isActive = true
		
		tempLabel.text = "\(Int(forecast.temp))°"
		
		
		
		windLabel.text = "\(forecast.windSpeed) m/s"
		let rainUnit = daysInForecast == 24 ? "mm/h" : "mm/\(24/daysInForecast)h"
		rainLabel.text = "\(forecast.precipitationMean) \(rainUnit)"
	}

	
	private func getDetailedDayString(components: DateComponents) -> String {
		return components.hour! < 10 ? "kl. 0\(components.hour!): " : "kl. \(components.hour!): "
	}
	
}
