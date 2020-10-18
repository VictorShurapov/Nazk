//
//  NazkCollection.swift
//  Nazk
//
//  Created by Viktor Shurapov on 10/17/20.
//

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
