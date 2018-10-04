//
//  DetailedViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-31.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
	
	let detailedTableViewController: DetailedTableViewController = {
		let tableViewController = DetailedTableViewController()
		tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableViewController
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
	
	
		navigationItem.largeTitleDisplayMode = .always
		
		
		
		
		let tableView = detailedTableViewController.tableView!
		view.addSubview(tableView)
		tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		
		navigationItem.title = NSLocalizedString("10_day_projection", comment: "")

		applyTheme()
        // Do any additional setup after loading the view.
    }
	
	func applyTheme(){
		view.backgroundColor = ThemeHandler.getInstance().getCurrentTheme().backgroundColor
		detailedTableViewController.tableView.reloadData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
