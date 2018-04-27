//
//  LocationSearchResultController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-04-03.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchResultController: UIViewController, UISearchResultsUpdating {
	
	let locationSearchTableView: LocationSearchTableViewController = LocationSearchTableViewController()
	var locationServices: LocationServices!
	
	var heightAnchor: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
		//view.backgroundColor = .green
		//locationSearchTableView.view.backgroundColor =
		
		locationSearchTableView.didMove(toParentViewController: self)
		addChildViewController(locationSearchTableView)
		let searchView = locationSearchTableView.view!
		searchView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(searchView)
		searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		
		
		let searchController = UISearchController(searchResultsController: nil)
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Sök plats"
		navigationItem.searchController = searchController
		searchController.searchBar.keyboardAppearance = .dark
		
		navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true
		
		let image = #imageLiteral(resourceName: "LocationIcon")
		let button: UIButton = {
			let button = UIButton(type: .custom)
			button.setImage(image, for: .normal)
			button.addTarget(self, action: #selector(self.userLocation), for: .touchUpInside)
			button.translatesAutoresizingMaskIntoConstraints = false
			return button
		}()
		
		button.widthAnchor.constraint(equalToConstant: 25).isActive = true
		button.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)


		
		
    }
	
	@objc func userLocation(){
		locationServices.determineMyLocation()
		self.navigationController?.popViewController(animated: true)
	}
	
//	override func viewDidAppear(_ animated: Bool) {
//		super.viewDidAppear(animated)
//		
//		DispatchQueue.main.async {
//			self.navigationItem.searchController?.searchBar.becomeFirstResponder()
//		}
//	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func updateSearchResults(for searchController: UISearchController) {
		if searchController.searchBar.text!.count > 2 {
			let request = MKLocalSearchRequest()
			let searchText = searchController.searchBar.text!
			request.naturalLanguageQuery = searchText
			let search = MKLocalSearch(request: request)
			search.start { response, _ in
				guard let response = response else {
					return
				}

				let items = response.mapItems
				self.locationSearchTableView.locations.removeAll()
				for i in items {
					guard let local = i.placemark.locality else { continue }
					
					if local.contains(searchText){ //i.placemark.locality!.contains(searchText)
						print(i.placemark)
						self.locationSearchTableView.locations.append(Location(name: i.placemark.locality!, longitude: i.placemark.coordinate.longitude, latitude: i.placemark.coordinate.latitude))
					}
				}
			
				self.locationSearchTableView.tableView.reloadData()
				return
			}
		}
	}

}
