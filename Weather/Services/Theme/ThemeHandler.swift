//
//  ThemeHandler.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-06-04.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation
import os.log

class ThemeHandler {
	
	private static let instance = ThemeHandler()
	private var currentTheme: Theme!
	
	private init(){}
	
	static func getInstance() -> ThemeHandler {
		return instance
	}
	
	func changeTheme(to: ThemeName.Identifier){
		saveSelected(themeName: ThemeName(identifier: to))
		switch to {
		case .black:
			currentTheme = blackTheme()
		case .white:
			currentTheme =  whiteTheme()
		}
	}
	
	private func saveSelected(themeName: ThemeName) {
		
		let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(themeName, toFile: ThemeName.ArchiveURL.path)
		
		if isSuccessfulSave {
			os_log("Theme successfully saved.", log: OSLog.default, type: .debug)
		} else {
			os_log("Failed to save theme...", log: OSLog.default, type: .error)
		}
	}
	
	private func whiteTheme() -> Theme {
		return Theme(backgroundColor: .white, textColor: .black, contrastTextColor: .gray, iconColor: .black, statusBarStyle: .default, navigationBarStyle: .default)
	}
	
	private func blackTheme() -> Theme {
		return Theme(backgroundColor: .black, textColor: .white, contrastTextColor: .gray, iconColor: .white, statusBarStyle: .lightContent, navigationBarStyle: .black)
	}
	
	func getCurrentTheme() -> Theme {
		return currentTheme != nil ? currentTheme : loadTheme()
	}
	
	func loadTheme() -> Theme {
		let name = loadThemeName()
		if let name  = name {
			switch name.identifier {
			case .black:
				return blackTheme()
			case .white:
				return whiteTheme()
			}
		}else{
			let themeName = ThemeName(identifier: .black)
			saveSelected(themeName: themeName)
			currentTheme = blackTheme()
			return currentTheme
		}
		
	}
	private func loadThemeName() -> ThemeName?  {
		return NSKeyedUnarchiver.unarchiveObject(withFile: ThemeName.ArchiveURL.path) as? ThemeName
	}
}
