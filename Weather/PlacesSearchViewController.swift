//
//  PlacesSearchViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-05-06.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit
import GooglePlaces

class PlacesSearchViewController: UIViewController, UISearchDisplayDelegate {
	
	var resultsViewController: GMSAutocompleteResultsViewController?
	var searchController: UISearchController?
	var resultView: UITextView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		resultsViewController = GMSAutocompleteResultsViewController()
		resultsViewController?.delegate = self
		
		searchController = UISearchController(searchResultsController: resultsViewController)
		searchController?.searchResultsUpdater = resultsViewController
		
		// Put the search bar in the navigation bar.
		navigationItem.searchController = searchController!
		
		// When UISearchController presents the results view, present it in
		// this view controller, not one further up the chain.
		definesPresentationContext = true
		
		// Prevent the navigation bar from being hidden when searching.
		searchController?.hidesNavigationBarDuringPresentation = false
	}

	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// Handle the user's selection.
extension PlacesSearchViewController: GMSAutocompleteResultsViewControllerDelegate {
	func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
						   didAutocompleteWith place: GMSPlace) {
		searchController?.isActive = false
		// Do something with the selected place.
		print("Place name: \(place.name)")
		print("Place address: \(place.formattedAddress)")
		print("Place attributions: \(place.attributions)")
	}
	
	func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
						   didFailAutocompleteWithError error: Error){
		// TODO: handle the error.
		print("Error: ", error.localizedDescription)
	}
	
	// Turn the network activity indicator on and off again.
	func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}
	
	func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = false
	}
}
