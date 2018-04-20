//
//  Location.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-04-11.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation
import os.log

class Location: NSObject, NSCoding {

	let name: String
	let longitude: Double
	let latitude: Double
	
	static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
	static let ArchiveURL = DocumentsDirectory.appendingPathComponent("locations")
	
	struct PropertyKey {
		static let name = "name"
		static let latitude = "latidude"
		static let longitude = "longitude"
	}
	
	required convenience init?(coder aDecoder: NSCoder) {
		
		guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
			os_log("Unable to decode name for Location object", log: OSLog.default, type: .debug)
			return nil
		}
		let longitude = aDecoder.decodeDouble(forKey: PropertyKey.longitude)
		let latitude = aDecoder.decodeDouble(forKey: PropertyKey.latitude) 
		
		self.init(name: name, longitude: longitude, latitude: latitude)
	}
	
	init(name: String, longitude: Double, latitude: Double){
		self.name = name
		self.longitude = longitude
		self.latitude = latitude
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(self.name, forKey: PropertyKey.name)
		aCoder.encode(self.latitude, forKey: PropertyKey.latitude)
		aCoder.encode(self.longitude, forKey: PropertyKey.longitude)
	}
	
}
