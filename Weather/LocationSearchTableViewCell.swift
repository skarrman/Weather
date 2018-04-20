//
//  LocationSearchTableViewCell.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-04-03.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class LocationSearchTableViewCell: UITableViewCell {
	
	let cityLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 18)
		label.textColor = .white
		return label
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUpViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setUpViews() {
		backgroundColor = .black
		addSubview(cityLabel)
		cityLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
		cityLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
		cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		cityLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
		
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	

}
