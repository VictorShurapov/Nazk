//
//  CellWithoutBackground.swift
//  Nazk
//
//  Created by Viktor Shurapov on 10/17/20.
//

import UIKit

class CellWithoutBackground: UITableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: animated)
    }
}
