//
//  NazkTableView.swift
//  Nazk
//
//  Created by Viktor Shurapov on 10/17/20.
//

import UIKit

extension UITableView {
    
    func registerCell<Cell: UITableViewCell>(_ `class`: Cell.Type, bundle: Bundle = .main) {
        let identifier = "\(`class`.self)"
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
        func dequeueCell<Cell: UITableViewCell>(_ `class`: Cell.Type, for indexPath: IndexPath) -> Cell {
            let identifier = "\(`class`.self)"
            let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            return cell as! Cell
        }
    
    //    func dequeueHeaderFooterView<View: UITableViewHeaderFooterView>(_ `class`: View.Type) -> View {
    //        let identifier = "\(`class`.self)"
    //        let view = dequeueReusableHeaderFooterView(withIdentifier: identifier)
    //        return view as! View
    //    }
    
    //    func registerCell<Cell: UITableViewCell>(_ `class`: Cell.Type, bundle: Bundle = .main) {
    //        let identifier = "\(`class`.self)"
    //        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    //    }
    
    //    func registerHeaderFooterView<View: UITableViewHeaderFooterView>(_ `class`: View.Type, bundle: Bundle = .main) {
    //        let identifier = "\(`class`.self)"
    //        register(UINib(nibName: identifier, bundle: bundle), forHeaderFooterViewReuseIdentifier: identifier)
    //    }
}
