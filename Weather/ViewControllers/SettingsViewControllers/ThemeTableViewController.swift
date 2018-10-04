//
//  ThemeTableViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-08-04.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class ThemeTableViewController: UITableViewController {
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return ThemeHandler.getInstance().getCurrentTheme().statusBarStyle
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		applyTheme()
		
		tableView.register(ThemeTableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.rowHeight = 50
		tableView.sectionHeaderHeight = 0.5
		
		tableView.isScrollEnabled = false
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	}
	
	func applyTheme(){
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		self.tableView.backgroundColor = theme.backgroundColor
		self.tableView.reloadData()
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
		return 2
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let feedBackGenerator = UIImpactFeedbackGenerator()
		if(indexPath.row == 0 && view.backgroundColor != .black){
			changeTheme(to: .black)
			feedBackGenerator.impactOccurred()
		}else if(indexPath.row == 1 && view.backgroundColor != .white){
			changeTheme(to: .white)
			feedBackGenerator.impactOccurred()
		}
		tableView.deselectRow(at: indexPath, animated: true)
		NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "ThemeChanged")))
		
	}
	
	func changeTheme(to: ThemeName.Identifier){
		let handler = ThemeHandler.getInstance()
		handler.changeTheme(to: to)
		
		let theme = handler.getCurrentTheme()
		navigationController?.navigationBar.barStyle = theme.navigationBarStyle
		navigationController?.navigationBar.tintColor = theme.textColor
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : theme.textColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)]
		applyTheme()
		setNeedsStatusBarAppearanceUpdate()
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ThemeTableViewCell
		cell.applyTheme()
		
		if(indexPath.row == 0){
			if(view.backgroundColor == .black){
				cell.setCheckIcon(visible: true)
			}else{
				cell.setCheckIcon(visible: false)
			}
			cell.nameLabel.text = NSLocalizedString("black", comment: "")
		}else{
			if(view.backgroundColor == .white){
				cell.setCheckIcon(visible: true)
			}else{
				cell.setCheckIcon(visible: false)
			}
			cell.nameLabel.text = NSLocalizedString("white", comment: "")
		}
		
		
		// Configure the cell...
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = TableViewHeader()
		header.setUpViews()
		header.backgroundColor = ThemeHandler.getInstance().getCurrentTheme().contrastTextColor
		
		return header
	}

}
