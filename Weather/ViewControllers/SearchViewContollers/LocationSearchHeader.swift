//
//  LocationSearchHeader.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-04-20.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class LocationSearchHeader: UIView {
	let label: UILabel = {
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
	
	func setUpViews(){
		backgroundColor = .white
		addSubview(label)
		label.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 20).isActive = true
		label.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
		label.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.9).isActive = true
		label.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
		
	}

}
