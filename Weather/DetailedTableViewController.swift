//
//  DetailedTableViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-30.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class DetailedTableViewController: UITableViewController {
	
	var forecasts: [Forecast] = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationController?.setNavigationBarHidden(false, animated: false)
		
		tableView.rowHeight = 70
		
		tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "cellID")
		
		view.backgroundColor = .black
		view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
	}
	
	func updateWith(forecasts: [Forecast]){
		self.forecasts = forecasts
		
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return forecasts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! ForecastTableViewCell

		var f = [Forecast]()
		f.append(forecasts[indexPath.row])
		cell.setUpCell(forecast: f)

        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
	}

}
