//
//  SettingsViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-08-04.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit
import RxSwift

class SettingsViewController: UIViewController {
	
	let disposeBag  = DisposeBag()

	let themeTable: ThemeTableViewController = {
		let table = ThemeTableViewController()
		table.tableView.translatesAutoresizingMaskIntoConstraints = false
		return table
	}()
	
	let themeListLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.text = NSLocalizedString("choose_theme", comment: "")
		label.font = UIFont.systemFont(ofSize: 18)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = NSLocalizedString("settings", comment: "")
		
		self.view.addSubview(themeListLabel)
		themeListLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
		themeListLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
		themeListLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
		
		addChild(themeTable)
		themeTable.didMove(toParent: self)
		let tableView = themeTable.tableView!
		self.view.addSubview(tableView)
		tableView.topAnchor.constraint(equalTo: themeListLabel.bottomAnchor, constant: 0).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		tableView.heightAnchor.constraint(equalToConstant: tableView.rowHeight * 2 + tableView.sectionHeaderHeight).isActive = true
		//tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		tableView.sizeToFit()
		// Do any additional setup after loading the view.
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
		apply(ThemeHandler.getInstance().getCurrentTheme())
		
		
		themeTable.themeSubject
			.subscribeOn(CurrentThreadScheduler.instance)
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { theme in
				self.apply(theme)
			}).disposed(by: disposeBag)
	}
	
	@objc func done(){
		self.dismiss(animated: true, completion: nil)
	}
	
	private func apply(_ theme: Theme){
		self.view.backgroundColor = theme.backgroundColor
		self.themeListLabel.textColor = theme.textColor
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	


}
