//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-18.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
	
	let dayLabel: UILabel = {
		let label = UILabel()
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
	let highTempLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 18)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let lowTempLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 18)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	let windIcon: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "Wind").withRenderingMode(.alwaysTemplate))
		imageView.image?.withRenderingMode(.alwaysTemplate)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	let rainIcon: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "RainDropp").withRenderingMode(.alwaysTemplate))
		imageView.image?.withRenderingMode(.alwaysTemplate)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	let windLabel: UILabel = {
		let label = UILabel()
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
	
	func setUpCell(forecast: [Forecast]){
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
	
		applyTheme()
		
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
		
		
		dayLabel.text = getDayString(components: forecast.first!.date)
		forecastIcon.image = IconHandler.getForecastIcon(symbol: symbolFor(forecasts: forecast))
		forecastIcon.image?.withRenderingMode(.alwaysTemplate)
		rightCenterView.addSubview(highTempLabel)
		highTempLabel.centerYAnchor.constraint(equalTo: rightCenterView.centerYAnchor).isActive = true
		
		if forecast.count > 1 {
			rightCenterView.addSubview(lowTempLabel)
			highTempLabel.leftAnchor.constraint(equalTo: rightCenterView.leftAnchor).isActive = true
			highTempLabel.widthAnchor.constraint(equalTo: rightCenterView.widthAnchor, multiplier: 0.5).isActive = true
			highTempLabel.heightAnchor.constraint(equalTo: rightCenterView.heightAnchor).isActive = true
			
			lowTempLabel.centerYAnchor.constraint(equalTo: rightCenterView.centerYAnchor).isActive = true
			lowTempLabel.rightAnchor.constraint(equalTo: rightCenterView.rightAnchor).isActive = true
			lowTempLabel.widthAnchor.constraint(equalTo: rightCenterView.widthAnchor, multiplier: 0.5).isActive = true
			lowTempLabel.heightAnchor.constraint(equalTo: rightCenterView.heightAnchor).isActive = true
			
			let temps = getTemps(forecasts: forecast)
			highTempLabel.text = "\(Int(temps.0))°"
			lowTempLabel.text = "\(Int(temps.1))°"
			
		}else {
			lowTempLabel.text = ""
			highTempLabel.centerXAnchor.constraint(equalTo: rightCenterView.centerXAnchor).isActive = true
			highTempLabel.heightAnchor.constraint(equalTo: rightCenterView.heightAnchor, multiplier: 0.8).isActive = true
			highTempLabel.widthAnchor.constraint(equalTo: rightCenterView.widthAnchor).isActive = true
			highTempLabel.text = "\(Int(forecast.first!.temp.rounded()))°"
		}
		
		windLabel.text = "\(getMeanWind(forecasts: forecast)) m/s"
		let rainParameters = getTotalPrecipitation(forecsts: forecast)
		rainLabel.text = "\(rainParameters.0) \(rainParameters.1)"
	}
	
	private func applyTheme(){
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		backgroundColor = theme.backgroundColor
		dayLabel.textColor = theme.textColor
		highTempLabel.textColor = theme.textColor
		lowTempLabel.textColor = theme.contrastTextColor
		windLabel.textColor = theme.textColor
		rainLabel.textColor = theme.textColor
		rainIcon.tintColor = theme.iconColor
		windIcon.tintColor = theme.iconColor
		forecastIcon.tintColor = theme.iconColor
	}
	
	private func getTotalPrecipitation(forecsts: [Forecast]) -> (Double, String) {
		let prefix = forecsts.count > 1 ? "mm/24h" : "mm/h"
		var sum = 0.0
		for f in forecsts {
			sum += f.precipitationMean
		}
		
		return (sum, prefix)
	}
	
	private func getTemps(forecasts: [Forecast]) -> (Double, Double) {
		var lowest = forecasts.first!.temp
		var highest = forecasts.first!.temp
		
		for f in forecasts {
			if f.temp < lowest {
				lowest = f.temp
			}
			if f.temp > highest {
				highest = f.temp
			}
		}
		return (highest, lowest)
	}
	
	private func getMeanWind(forecasts: [Forecast]) -> Double {
		var totalWind = 0.0
		
		for f in forecasts {
			totalWind += f.windSpeed
		}
		
		return ((10 * (totalWind / Double(forecasts.count))).rounded()) / 10
	}
	
	private func symbolFor(forecasts: [Forecast]) -> Symbol {
		var occations = Array(repeating: 0, count: 28)
		
		for f in forecasts {
			occations[f.symbol.rawValue] += 1
		}
		return Symbol(rawValue: occations.index(of: occations.max()!)!)!
	}
	
	private func getDayString(components: DateComponents) -> String {
		let dateFormatter = DateFormatter()
		let today = (Calendar.current).component(.day, from: Date(timeIntervalSinceNow: 0))
		let day = components.day!
		if day == today{
			return "Idag kl \(components.hour!):"
		}
		else if day == today + 1 {
			return "Imorgon:"
		}
			dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
		
			let weekday = dateFormatter.weekdaySymbols[components.weekday! - 1].capitalized
			let month = dateFormatter.monthSymbols[components.month! - 1].capitalized
		
		if day < today + 5 && !(day < today) {
			return "\(weekday): "
		
		}else{
			return "\(day) \(month): "
		}
	}


}
