//
//  LocationSearchTableViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-04-03.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit
import os.log

class LocationSearchTableViewController: UITableViewController {
	
	var forecastModel: ForecastModel!
	var savedLocations = [Location]()
	var locations = [Location]()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.register(LocationSearchTableViewCell.self, forCellReuseIdentifier: "cell")
		
		
		tableView.backgroundColor = .black
		
		tableView.estimatedRowHeight = 50
		tableView.rowHeight = 50
		tableView.estimatedSectionHeaderHeight = 30
		tableView.sectionHeaderHeight = 30
		
		guard let saved = loadLocations() else {
			print("No locations saved")
			return
		}
		savedLocations += saved
    }
	
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
		return savedLocations.count > 0 ? 2 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		if savedLocations.count > 0 {
			return section == 0 ? savedLocations.count : locations.count
		}else {
			return locations.count
		}
    }
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = LocationSearchHeader()
		header.setUpViews()
		if savedLocations.count > 0 {
			header.label.text = section == 0 ? "Nyligen sökta" : "Sökning"
		} else {
			header.label.text = "Sökning"
		}
		return header
	}

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationSearchTableViewCell

		// Configure the cell...
		
		if savedLocations.count > 0 {
			if indexPath.section == 0 {
				cell.cityLabel.text = savedLocations[indexPath.row].name
			}else {
				cell.cityLabel.text = locations[indexPath.row].name
			}
		}else {
			cell.cityLabel.text = locations[indexPath.row].name
		}
        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Before",savedLocations)
		let location: Location!
		if savedLocations.count > 0 && indexPath.section == 1 {
			location = locations[indexPath.row]
			addToSaved(location: location)
			saveLocations()
		}else if savedLocations.count < 1 {
			location = locations[indexPath.row]
			savedLocations.append(location)
			saveLocations()
		}else if indexPath.row == 0 {
			location = savedLocations[indexPath.row]
		}else{
			location = savedLocations[indexPath.row]
			addToSaved(location: location)
			saveLocations()
		}
		forecastModel.updateForecast(location: location)
		self.navigationController?.popViewController(animated: true)
	}
	
	private func addToSaved(location: Location) {
		print("After",savedLocations)
		savedLocations.append(savedLocations[savedLocations.count-1])
		let size = savedLocations.count-1
		for i in 0..<size {
			savedLocations[size - i] = savedLocations[size - i - 1]
		}
		
		removeFromSaved(location: location)
		
		savedLocations[0] = location
		if savedLocations.count > 5 {
			savedLocations.remove(at: 5)
		}
	}
	
	private func removeFromSaved(location: Location){
		var i = 0
		while true {
			if savedLocations[i].name == location.name {
				savedLocations.remove(at: i)
				i -= 1
				//removed += 1
			}
			i += 1
			if i == savedLocations.count {
				break
			}
		}
	}
	
	
	private func saveLocations() {
		if savedLocations.count < 1 {
			return
		}
		let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(savedLocations, toFile: Location.ArchiveURL.path)
		
		if isSuccessfulSave {
			os_log("Locations successfully saved.", log: OSLog.default, type: .debug)
		} else {
			os_log("Failed to save locations...", log: OSLog.default, type: .error)
		}
	}
	
	private func loadLocations() -> [Location]?  {
		return NSKeyedUnarchiver.unarchiveObject(withFile: Location.ArchiveURL.path) as? [Location]
	}

}
