//
//  ThemeName.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-06-07.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import Foundation
import os.log

class ThemeName: NSObject, NSCoding {
	enum Identifier: Int {
		case black = 1, white
	}
	
	let identifier: Identifier
	
	static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
	static let ArchiveURL = DocumentsDirectory.appendingPathComponent("theme")
	
	required convenience init?(coder aDecoder: NSCoder) {
		
//		guard let id = aDecoder.decodeObject(forKey: "id") as? Int else {
//			os_log("Unable to decode theme", log: OSLog.default, type: .debug)
//			return nil
//		}
		
		let id = aDecoder.decodeInt32(forKey: "id")
		self.init(identifier: Identifier.init(rawValue: Int(id))!)
	}
	
	init(identifier: Identifier){
		self.identifier = identifier
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(self.identifier.rawValue, forKey: "id")
	}
}

