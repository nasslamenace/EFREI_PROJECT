//
//  CompanyCell.swift
//  EFREI_PROJECT_
//
//  Created by Nassim Guettat on 05/04/2021.
//

import UIKit

class CompanyCell: UICollectionViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
