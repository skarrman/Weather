//
//  ThemeTableViewCell.swift
//  Weather
//
//  Created by Simon Kärrman on 2018-08-04.
//  Copyright © 2018 Simon Kärrman. All rights reserved.
//

import UIKit

class ThemeTableViewCell: UITableViewCell {

	let nameLabel : UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 18)
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.1
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let checkIcon: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "CheckIcon").withRenderingMode(.alwaysTemplate))
		imageView.image?.withRenderingMode(.alwaysTemplate)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	var checkVisible: NSLayoutConstraint?
	var checkNotVisible: NSLayoutConstraint?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUpViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setUpViews(){
		addSubview(nameLabel)
		nameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
		nameLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
		nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		nameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
		addSubview(checkIcon)
		checkIcon.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
		checkIcon.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
		checkIcon.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
		
		checkVisible = checkIcon.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20)
		checkNotVisible = checkIcon.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 100)
		applyTheme()
		
	}
	
	func applyTheme(){
		let theme = ThemeHandler.getInstance().getCurrentTheme()
		backgroundColor = theme.backgroundColor
		nameLabel.textColor = theme.textColor
		checkIcon.tintColor = theme.iconColor
	}
	
	func setCheckIcon(visible: Bool){
		if(visible){
			checkNotVisible?.isActive = false
			checkVisible?.isActive = true
		}else{
			checkVisible?.isActive = false
			checkNotVisible?.isActive = true
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}


}
