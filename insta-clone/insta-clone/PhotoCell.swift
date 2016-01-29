//
//  PhotoCell.swift
//  insta-clone
//
//  Created by Focus on 1/28/16.
//  Copyright © 2016 Danyal Rizvi. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    
    
    
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
