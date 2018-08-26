//
//  LoadingView.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-08-04.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class LoadingView: UIView {
	
	var activityIndicatorView: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var loadingView: UIView = {
		let loadingView = UIView()
		loadingView.translatesAutoresizingMaskIntoConstraints = false
		var color: UIColor = .gray
		color = color.withAlphaComponent(0.9)
		loadingView.backgroundColor = color
		loadingView.clipsToBounds = true
		loadingView.layer.cornerRadius = 10
		return loadingView
	}()
	
	
	func startRefreshing() {
		DispatchQueue.main.async {
			self.addSubview(self.loadingView)
			self.loadingView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
			self.loadingView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
			self.loadingView.widthAnchor.constraint(equalToConstant: 80).isActive = true
			self.loadingView.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
			self	.addSubview(self.activityIndicatorView)
			self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
			self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
		
			self.activityIndicatorView.startAnimating()
		}
	}
	
	func stopRefreshing(){
		DispatchQueue.main.async {
			self.activityIndicatorView.stopAnimating()
			self.loadingView.removeFromSuperview()
			self.activityIndicatorView.removeFromSuperview()
		}
	}

}
