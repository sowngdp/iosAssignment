//
//  UserTableViewCell.swift
//  iosAssigment
//
//  Created by Macbook on 04/06/2024.
//


import UIKit
 



class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var htmlURLLabel: UILabel!
    
    
    override func awakeFromNib() {        
        super.awakeFromNib()        
        // Initialization code
    }
}
