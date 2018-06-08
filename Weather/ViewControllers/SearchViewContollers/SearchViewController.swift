//
//  SearchViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-05-06.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchViewController: UIViewController, UISearchResultsUpdating {
	
	let searchTableView: SearchTableViewController = SearchTableViewController()
	var locationServices: LocationServices!
	
    override func viewDidLoad() {
		
		self.title = "Sök prognos"
		
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		self.view.backgroundColor = theme.backgroundColor
		
		let imageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "powered_by_google_on_non_white"))
		imageView.image?.withRenderingMode(.alwaysTemplate)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(imageView)
		imageView.contentMode = .center
		
		imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
		imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
		imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.04).isActive = true
		imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
		searchTableView.didMove(toParentViewController: self)
		addChildViewController(searchTableView)
		let searchView = searchTableView.view!
		searchView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(searchView)
		searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		searchView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10).isActive = true
		
		let searchController = UISearchController(searchResultsController: nil)
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Sök plats"
		navigationItem.searchController = searchController
		searchController.searchBar.keyboardAppearance = .dark
		
		navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true
		
		let image = #imageLiteral(resourceName: "LocationIcon").withRenderingMode(.alwaysTemplate)
		
		let button: UIButton = {
			let button = UIButton(type: .custom)
			button.setImage(image, for: .normal)
			button.addTarget(self, action: #selector(self.userLocation), for: .touchUpInside)
			button.translatesAutoresizingMaskIntoConstraints = false
			return button
		}()
		button.tintColor = theme.iconColor
		
		button.widthAnchor.constraint(equalToConstant: 25).isActive = true
		button.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
		
		
		
		
	}
	
	@objc func userLocation(){
		locationServices.determineMyLocation()
		self.navigationController?.popViewController(animated: true)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func updateSearchResults(for searchController: UISearchController) {
		if searchController.searchBar.text!.count > 0 {
			let googleClient = GMSPlacesClient.shared()
			let filter = GMSAutocompleteFilter()
			
			let theme = ThemeHandler.getInstance().getCurrentTheme()
			filter.type = GMSPlacesAutocompleteTypeFilter.city
			filter.country = "SE"
			googleClient.autocompleteQuery(searchController.searchBar.text!, bounds: nil, boundsMode: GMSAutocompleteBoundsMode.restrict , filter: filter , callback: { (results, error) in
				if results != nil {
					var places = [PlaceSearchItem]()
					for r in results!{
					
						let placeID = r.placeID!
					
						let regularFont = UIFont.systemFont(ofSize: 18)
						let boldFont = UIFont.systemFont(ofSize: 18)

						let string = r.attributedPrimaryText.mutableCopy() as! NSMutableAttributedString
						string.enumerateAttribute(NSAttributedStringKey(rawValue: kGMSAutocompleteMatchAttribute), in: NSMakeRange(0, string.length), options: 	NSAttributedString.EnumerationOptions(rawValue: 0), using: { (value, range, stop) in
							let font = value == nil ? regularFont : boldFont
							let color = value == nil ? theme.contrastTextColor : theme.textColor
							string.addAttributes([NSAttributedStringKey.font : font], range: range)
							string.addAttributes([NSAttributedStringKey.foregroundColor : color], range: range)
						})
				
						places.append(PlaceSearchItem(string: string, placeID: placeID))
					}
					self.searchTableView.searchedPlaces = places
					self.searchTableView.tableView.reloadData()
				}
				
			})
		}else {
			self.searchTableView.searchedPlaces.removeAll()
			self.searchTableView.tableView.reloadData()
		}
	}
}
