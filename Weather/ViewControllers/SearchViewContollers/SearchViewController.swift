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
	var latestSearchConstraint: NSLayoutConstraint!
	var searchConstraint: NSLayoutConstraint!
	var searchController: UISearchController!
	
    override func viewDidLoad() {
		
		self.title = NSLocalizedString("search_projection", comment: "")
		
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		self.view.backgroundColor = theme.backgroundColor
		
//		
		searchTableView.didMove(toParent: self)
		addChild(searchTableView)
		self.searchTableView.tableView.isScrollEnabled = false
		let searchView = searchTableView.view!
		searchView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(searchView)
		searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		latestSearchConstraint = searchView.heightAnchor.constraint(equalToConstant: searchTableView.tableView.rowHeight * 5 + searchTableView.tableView.sectionHeaderHeight)
		
		latestSearchConstraint.isActive = true
		
		searchConstraint = searchView.heightAnchor.constraint(equalToConstant: searchTableView.tableView.rowHeight * 6 + searchTableView.tableView.sectionHeaderHeight)
		
		searchController = UISearchController(searchResultsController: nil)
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = NSLocalizedString("search_location", comment: "")
		navigationItem.searchController = searchController
		searchController.searchBar.keyboardAppearance = .dark
		
		navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true
		
		
		
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		searchController.searchBar.text = ""
		searchController.dismiss(animated: true) {}
		
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func updateSearchResults(for searchController: UISearchController) {
		if searchController.searchBar.text!.count > 0 {
			searchTableView.inSearch(value: true)
			latestSearchConstraint.isActive = false
			searchConstraint.isActive = true
			
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
						string.enumerateAttribute(NSAttributedString.Key(rawValue: kGMSAutocompleteMatchAttribute), in: NSMakeRange(0, string.length), options: 	NSAttributedString.EnumerationOptions(rawValue: 0), using: { (value, range, stop) in
							let font = value == nil ? regularFont : boldFont
							let color = value == nil ? theme.contrastTextColor : theme.textColor
							string.addAttributes([NSAttributedString.Key.font : font], range: range)
							string.addAttributes([NSAttributedString.Key.foregroundColor : color], range: range)
						})
				
						places.append(PlaceSearchItem(string: string, placeID: placeID))
					}
					
					self.searchTableView.searchedPlaces = places
					print("Count", places.count)
					self.searchTableView.tableView.reloadData()
					
				}
				
			})
		}else {
			self.searchTableView.inSearch(value: false)
			searchConstraint.isActive = false
			latestSearchConstraint.isActive = true
			self.searchTableView.searchedPlaces.removeAll()
			self.searchTableView.tableView.reloadData()
		}
	}
}
