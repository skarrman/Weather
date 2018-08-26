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
	var googleCell: GoogleTableViewCell!
	var inSearch: Bool!


    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
		
		inSearch = false
		
		
		tableView.backgroundColor = ThemeHandler.getInstance().getCurrentTheme().backgroundColor
		
		tableView.estimatedRowHeight = 50
		tableView.rowHeight = 50
		tableView.estimatedSectionHeaderHeight = 30
		tableView.sectionHeaderHeight = 30
		
		googleCell = GoogleTableViewCell()
		googleCell.setUp()
		
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
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		if  inSearch {
			return 6
		}else {
			return savedLocations.count
		}
	}
	
	func inSearch(value: Bool){
		inSearch = value
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = LocationSearchHeader()
		header.setUpViews()
		if inSearch {
			header.label.text = NSLocalizedString("search", comment: "")
		}else {
			header.label.text = NSLocalizedString("latest_search", comment: "")
		}
		return header
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
		
		// Configure the cell...
		cell.cityLabel.textColor = ThemeHandler.getInstance().getCurrentTheme().textColor
		if inSearch {
			if searchedPlaces.count > 0 {
				if indexPath.row < searchedPlaces.count {
					cell.cityLabel.attributedText = searchedPlaces[indexPath.row].string
				}
			} else {
			if indexPath.row == 0 {
				cell.cityLabel.textColor = ThemeHandler.getInstance().getCurrentTheme().contrastTextColor
					cell.cityLabel.text = NSLocalizedString("no_hits", comment: "")
				}else {
					cell.cityLabel.text = ""
				}
			}
			
		if indexPath.row == 5 {
			return googleCell
		}
			
		}else{
			cell.cityLabel.text = savedLocations[indexPath.row].name
		}
		return cell
	}
	
//	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		print("Before",savedLocations)
//		if savedLocations.count > 0 && indexPath.section == 0 {
//			var location: Location!
//			if indexPath.row == 0 {
//				location = savedLocations[indexPath.row]
//			}else{
//				location = savedLocations[indexPath.row]
//				addToSaved(location: location)
//				saveLocations()
//			}
//			forecastModel.updateForecast(location: location)
//			navigationController?.popViewController(animated: true)
//		}else{
//			let client = GMSPlacesClient.shared()
//			client.lookUpPlaceID(searchedPlaces[indexPath.row].placeID) { (place, error) in
//				if place != nil {
//					let location = Location(name: place!.name, longitude: place!.coordinate.longitude, latitude: place!.coordinate.latitude)
//					self.addToSaved(location: location)
//					self.saveLocations()
//					self.forecastModel.updateForecast(location: location)
//					self.navigationController?.popViewController(animated: true)
//				}
//			}
//		}
//	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if searchedPlaces.count > 0 {
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
		} else {
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

