//
//  DetailedTableViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-30.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class DetailedTableViewController: UITableViewController {
	
	var forecasts: [[Forecast]] = [[Forecast]]()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.estimatedRowHeight = 70
		tableView.estimatedSectionHeaderHeight = 35
		tableView.rowHeight = 70
		tableView.sectionHeaderHeight = 35
		
		tableView.register(DetailedTableViewCell.self, forCellReuseIdentifier: "cellID")

		
		tableView.backgroundColor = .black
		

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	func updateWith(forecasts: [[Forecast]], dayToScrollTo: Int){
		self.forecasts = forecasts
		
		tableView.beginUpdates()
		tableView.reloadData()
		tableView.endUpdates()
		
		scrollTo(day: dayToScrollTo)
	}
	
	func scrollTo(day: Int){
		for (i,f) in forecasts.enumerated() {
			if f.first!.date.day! == day {
				self.tableView.scrollToRow(at: IndexPath(row: NSNotFound, section: i), at: .top, animated: false)
				return
			}
		}
		
		print("NotFound")
		
	}
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
		return forecasts.count - 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return forecasts[section].count
    }
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = TableViewHeader()
		header.bounds = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.sectionHeaderHeight)
		header.setUpViews()
		header.setDayText(components: forecasts[section].first!.date)
		return header
	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! DetailedTableViewCell
		
		cell.selectionStyle = .none
		
		let days = indexPath.section == 0 ? 24 : forecasts[indexPath.section].count


		cell.setUpCell(forecast: forecasts[indexPath.section][indexPath.row], daysInForecast: days)

        return cell
    }

}
