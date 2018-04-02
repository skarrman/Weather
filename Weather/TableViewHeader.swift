//
//  TableViewHeader.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-30.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class TableViewHeader: UIView{
	
	let dayLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.textAlignment = .left
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	func setDayText(components: DateComponents) {
		let dateFormatter = DateFormatter()
		let today = (Calendar.current).component(.day, from: Date(timeIntervalSinceNow: 0))
		let day = components.day!
		var dayString: String!
		if day == today{
			dayString = "Idag"
		}
		else if day == today + 1 {
			dayString = "Imorgon"
		}else{
			dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
		
			let weekday = dateFormatter.weekdaySymbols[components.weekday! - 1].capitalized
			let month = dateFormatter.monthSymbols[components.month! - 1].capitalized
			
			dayString = "\(weekday) den \(day) \(month)"
			
		}
		
		dayLabel.text = dayString
	}
	
	func setUpViews(){
		backgroundColor = .white
		addSubview(dayLabel)
		dayLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 20).isActive = true
		dayLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
		dayLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.9).isActive = true
		dayLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
		
	}
}
