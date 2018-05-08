//
//  SearchTableViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-05-08.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit
import GooglePlaces
import os.log

class SearchTableViewController: UITableViewController {
	
	var forecastModel: ForecastModel!
	var savedLocations = [Location]()
	var searchedPlaces = [PlaceSearchItem]()


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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return savedLocations.count > 0 ? 2 : 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		if savedLocations.count > 0 {
			return section == 0 ? savedLocations.count : searchedPlaces.count
		}else {
			return searchedPlaces.count
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
				cell.cityLabel.attributedText = searchedPlaces[indexPath.row].string
			}
		}else {
			cell.cityLabel.attributedText = searchedPlaces[indexPath.row].string
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Before",savedLocations)
		if savedLocations.count > 0 && indexPath.section == 0 {
			var location: Location!
			if indexPath.row == 0 {
				location = savedLocations[indexPath.row]
			}else{
				location = savedLocations[indexPath.row]
				addToSaved(location: location)
				saveLocations()
			}
			forecastModel.updateForecast(location: location)
			navigationController?.popViewController(animated: true)
		}else{
			let client = GMSPlacesClient.shared()
			client.lookUpPlaceID(searchedPlaces[indexPath.row].placeID) { (place, error) in
				if place != nil {
					let location = Location(name: place!.name, longitude: place!.coordinate.longitude, latitude: place!.coordinate.latitude)
					self.addToSaved(location: location)
					self.saveLocations()
					self.forecastModel.updateForecast(location: location)
					self.navigationController?.popViewController(animated: true)
				}
			}
		}
	}
	
	private func addToSaved(location: Location) {
		print("After",savedLocations)
		if savedLocations.count == 0 {
			savedLocations.append(location)
		}else{
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

