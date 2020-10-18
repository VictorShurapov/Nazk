//
//  DeclarationTableViewCell.swift
//  Nazk
//
//  Created by Viktor Shurapov on 10/17/20.
//

import UIKit

class DeclarationTableViewCell: CellWithoutBackground {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var placeOfWork: UILabel!
    @IBOutlet weak var position: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
