//
//  GoogleTableViewCell.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-08-02.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class GoogleTableViewCell: UITableViewCell {
	
	var googleImageView: UIImageView!
	let onBlack = #imageLiteral(resourceName: "powered_by_google_on_non_white")
	let onWhite = #imageLiteral(resourceName: "powered_by_google_on_white")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func setUp(){
		
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		backgroundColor = theme.backgroundColor
		let isBlack = theme.backgroundColor == .black
		googleImageView = isBlack ? UIImageView(image: onBlack) : UIImageView(image: onWhite)
		googleImageView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(googleImageView)
		googleImageView.contentMode = .center
		
		googleImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
		googleImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
		googleImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
		googleImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
