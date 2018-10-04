//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-08-04.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

	let cityLabel : UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 18)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUpView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setUpView(){
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		backgroundColor = theme.backgroundColor
		addSubview(cityLabel)
		cityLabel.textColor = theme.textColor
		cityLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
		cityLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
		cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		cityLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true

	}
	

}
