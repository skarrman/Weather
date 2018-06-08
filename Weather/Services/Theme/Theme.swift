//
//  Theme.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-06-04.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit


class Theme {
	//MARK: Main colors
	let backgroundColor: UIColor
	let textColor: UIColor
	let contrastTextColor: UIColor
	let iconColor: UIColor
	
	//MARK: UI appearences
	let statusBarStyle: UIStatusBarStyle
	let navigationBarStyle: UIBarStyle
	
	init(backgroundColor: UIColor, textColor: UIColor, contrastTextColor: UIColor, iconColor: UIColor, statusBarStyle: UIStatusBarStyle, navigationBarStyle: UIBarStyle){
		self.backgroundColor = backgroundColor
		self.textColor = textColor
		self.contrastTextColor = contrastTextColor
		self.iconColor = iconColor
		self.statusBarStyle = statusBarStyle
		self.navigationBarStyle = navigationBarStyle
	}
}
