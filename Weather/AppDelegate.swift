//
//  AppDelegate.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-02-11.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var mainViewController: MainViewController!


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		GMSPlacesClient.provideAPIKey(GoogleApi.key)
		
		let themeHandler = ThemeHandler.getInstance()
		
		let theme = themeHandler.getCurrentTheme()
		
		// Override point for customization after application launch.
		window = UIWindow(frame: UIScreen.main.bounds)

		mainViewController = MainViewController()
		let navigationController = UINavigationController(rootViewController: mainViewController)
		navigationController.navigationBar.barStyle = theme.navigationBarStyle
		navigationController.pushViewController(mainViewController, animated: true)
		navigationController.navigationBar.prefersLargeTitles = true
		navigationController.navigationBar.tintColor = theme.textColor
		navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : theme.textColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)]
		navigationController.navigationItem.largeTitleDisplayMode = .always
		navigationController.navigationBar.isTranslucent = false

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		
		//navigationController.pushViewController(mainViewController, animated: false)
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		
		mainViewController.refreshForecast()
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

