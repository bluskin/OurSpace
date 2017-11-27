//
//  GroceryTableViewCell.swift
//  ourSpace1.2
//
//  Created by Claire Komyati on 11/13/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import UIKit

class GroceryTableViewCell: UITableViewCell {

    
    //Properties: 
    
    
    @IBOutlet weak var groceryItem: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
