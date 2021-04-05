//
//  ActivityCell.swift
//  EFREI_PROJECT_
//
//  Created by Nassim Guettat on 05/04/2021.
//

import UIKit

class ActivityCell: UITableViewCell {
    

    @IBOutlet weak var dateView: UIView!
    
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var startLbl: UILabel!
    @IBOutlet weak var endLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
