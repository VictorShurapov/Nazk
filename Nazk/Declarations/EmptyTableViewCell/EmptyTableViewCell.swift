//
//  EmptyTableViewCell.swift
//  Nazk
//
//  Created by Viktor Shurapov on 10/18/20.
//

import UIKit

class EmptyTableViewCell: CellWithoutBackground {

    @IBOutlet weak var emptyCellDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
