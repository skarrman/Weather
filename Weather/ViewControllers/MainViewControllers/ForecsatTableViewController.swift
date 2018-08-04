//
//  ForecsatTableViewController.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-03-18.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class ForecsatTableViewController: UITableViewController {
	
	var forecasts: [[Forecast]] = [[Forecast]]()
	
		var activityIndicatorView: UIActivityIndicatorView = {
			let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
			view.translatesAutoresizingMaskIntoConstraints = false
			view.hidesWhenStopped = true
			return view
		}()
	
	var loadingView: UIView = {
		let loadingView = UIView()
		loadingView.translatesAutoresizingMaskIntoConstraints = false
		loadingView.backgroundColor = .gray
		loadingView.backgroundColor?.withAlphaComponent(0.5)
		loadingView.clipsToBounds = true
		loadingView.layer.cornerRadius = 10
		return loadingView
	}()
	


    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "cellId")

		tableView.sectionHeaderHeight = 0
		tableView.rowHeight = 70
		
		tableView.estimatedRowHeight = 70
		tableView.estimatedSectionHeaderHeight = 0
		

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	func applyTheme(){
		self.view.backgroundColor = ThemeHandler.getInstance().getCurrentTheme().backgroundColor
		self.tableView.reloadData()
	}
	
	func startRefreshing() {
		view.addSubview(loadingView)
		loadingView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
		loadingView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
		loadingView.widthAnchor.constraint(equalToConstant: 80).isActive = true
		loadingView.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
		tableView.addSubview(activityIndicatorView)
		activityIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
		activityIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
		
		tableView.separatorStyle = .none
		activityIndicatorView.startAnimating()
		
//		var container: UIView = UIView()
//		container.frame = uiView.frame
//		container.center = uiView.center
//		container.backgroundColor = UIColorFromHex(0xffffff, alpha: 0.3)
//
//		var loadingView: UIView = UIView()
//		loadingView.frame = CGRectMake(0, 0, 80, 80)
//		loadingView.center = uiView.center
//		loadingView.backgroundColor = UIColorFromHex(0x444444, alpha: 0.7)
//		loadingView.clipsToBounds = true
//		loadingView.layer.cornerRadius = 10
//
//		var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
//		actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
//		actInd.activityIndicatorViewStyle =
//			UIActivityIndicatorViewStyle.WhiteLarge
//		actInd.center = CGPointMake(loadingView.frame.size.width / 2,
//									loadingView.frame.size.height / 2);
//		loadingView.addSubview(actInd)
//		container.addSubview(loadingView)
//		uiView.addSubview(container)
//		actInd.startAnimating()

	}
	
	
	func updateWithForecast(forecasts: [Forecast]) {
		
		self.forecasts.removeAll()
		var index = 0
		while index < forecasts.count {
			var fList = [Forecast]()
			let currentDay = forecasts[index].date.day!
			while forecasts[index].date.day! == currentDay {
				fList.append(forecasts[index])
				index += 1
				
				if index >= forecasts.count {
					break
				}
			}
			self.forecasts.append(fList)
		}
		
		DispatchQueue.main.async {
			self.activityIndicatorView.stopAnimating()
			self.loadingView.removeFromSuperview()
			self.activityIndicatorView.removeFromSuperview()
			self.tableView.separatorStyle = .singleLine
			self.tableView.reloadData()
			self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
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
//		print(numberOfRows)
		return forecasts.count < 1 ? 0 : (forecasts.first!.count > 6 ? 5 + forecasts.count - 1 : forecasts.first!.count + forecasts.count - 2)
		//return forecasts.count
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return tableView.bounds.height * 0.2
		}else{
			return 70
		}
	}
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	
		if indexPath.row == 0 {
			let todayCell = TodayView()
			todayCell.updateWith(forecast: forecasts.first!.first!)
			todayCell.setUpViews()
			return todayCell
			
		}else {
			
			let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ForecastTableViewCell
			if indexPath.row < ((forecasts.first!.count > 6) ? 5 : forecasts.first!.count) {
				var f = [Forecast]()
				f.append(forecasts[0][indexPath.row])
				cell.setUpCell(forecast: f)
			}else {
//				print(indexPath.row, indexPath.row - forecasts.first!.count - 1)
				cell.setUpCell(forecast: forecasts[indexPath.row - ((forecasts.first!.count > 6) ? 4 : forecasts.first!.count - 1)])
			}
			return cell
        // Configure the cell...
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let destination = DetailedViewController()
		var index = 0
		if indexPath.row > ((forecasts.first!.count > 6) ? 4 : forecasts.first!.count - 1) {
			index = indexPath.row - ((forecasts.first!.count > 6) ? 4 : forecasts.first!.count - 1)
			print(forecasts[index].first!.date.day!)
		}
		destination.detailedTableViewController.updateWith(forecasts: forecasts, dayToScrollTo: forecasts[index].first!.date.day!)
		navigationController?.pushViewController(destination, animated: true)
	}
	
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
