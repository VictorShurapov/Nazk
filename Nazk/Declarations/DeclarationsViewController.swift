//
//  DeclarationsViewController.swift
//  Nazk
//
//  Created by Viktor Shurapov on 10/16/20.
//

import UIKit

class DeclarationsViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableViewBottom: NSLayoutConstraint!
    
    var declarations = [InfoOfficial]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchKeyword = "" {
        didSet {
            print("searchKeyword: \(searchKeyword)")
        }
    }
    
    var isSearchBarEmpty: Bool {
        return searchKeyword.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addObservers()
    }
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - View building
private extension DeclarationsViewController {
    
    func setupView() {
        setupNavBar()
        setupTableView()
        setupSearchBar()
    }
    
    func setupNavBar() {
        title = "Єдиний державний реєстр деĸларацій"
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 103
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(DeclarationTableViewCell.self)
        tableView.registerCell(EmptyTableViewCell.self)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension DeclarationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return declarations.isEmpty ? 1 : declarations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let declarationInfo = declarations[safe: indexPath.row] else {
            let cell = tableView.dequeueCell(EmptyTableViewCell.self, for: indexPath)
            cell.emptyCellDescription.text = "По вашому запиту нічого не знайдено. Cпробуйте ще! :)"
            return cell
        }
        
        let cell = tableView.dequeueCell(DeclarationTableViewCell.self, for: indexPath)
        var fullName = (declarationInfo.lastname ?? "") + " " + (declarationInfo.firstname ?? "")
        if fullName.trimmingCharacters(in: .whitespaces).isEmpty {
            fullName = "Інформація відсутня"
        }
        cell.fullName.text = fullName.uppercased()
        
        cell.placeOfWork.text = declarationInfo.placeOfWork ?? ""
        
        let position = declarationInfo.position ?? ""
        cell.position.isHidden = position == "" || position == "ні"
        cell.position.text = position
        
        return cell
    }
}

// MARK: - Networking
extension DeclarationsViewController {
    
    func getDeclarations(forKeyword keyword: String) {
        declarationsProvider.request(.getDeclarations(keyword: keyword)) { result in
            do {
                let response = try result.get()
                let decodedResponse = try JSONDecoder().decode(DeclaraionsModel.self, from: response.data)
                DispatchQueue.main.async {
                    self.declarations = decodedResponse.items
                }
            } catch DecodingError.keyNotFound {
                // KeyNotFound decoding error in our case means that
                // nothing was found for our query
                // so we just show tableView with "empty" cell
                DispatchQueue.main.async {
                    self.declarations.removeAll()
                }
            } catch {
                //let printableError = error as CustomStringConvertible
                let responseString = try? result.get().mapString()
                print("ERROR: \(responseString ?? "")")
                self.showAlert("Отримання декларацій", message: "Щось пішло не так, спробуйте ще! :)")
            }
        }
    }
    
    //    func loadPdf(withURL path: String) {
    //        declarationsProvider.request(.loadPDF(url: path)) { result in
    //            do {
    //                let response = try result.get()
    //                print("YOBAR: \(response.data)")
    //                let decodedResponse = try JSONDecoder().decode(DeclaraionsModel.self, from: response.data)
    //                DispatchQueue.main.async {
    //                    self.declarations = decodedResponse.items
    //                }
    //            } catch DecodingError.keyNotFound {
    //                // KeyNotFound decoding error in our case means that
    //                // nothing was found for our query
    //                // so we just show tableView with "empty" cell
    //                DispatchQueue.main.async {
    //                    self.declarations.removeAll()
    //                }
    //            } catch {
    //                //let printableError = error as CustomStringConvertible
    //                let responseString = try? result.get().mapString()
    //                print("ERROR: \(responseString ?? "")")
    //                self.showAlert("Отримання декларацій", message: "Щось пішло не так, спробуйте ще! :)")
    //            }
    //        }
    //    }
}


// MARK: - UITableViewDelegate
extension DeclarationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let selectedDeclaration = declarations[safe: indexPath.row]
        //        let testValue = "https://public.nazk.gov.ua/storage/documents/pdf/1/7/d/2/17d26dd6-bca7-4eb4-943c-fbf063a46ffc.pdf"
        //        loadPdf(withURL: testValue)
        
        let declarationDetailStoryboard = UIStoryboard(name: "DeclarationDetail", bundle: Bundle.main)
        if let viewController = declarationDetailStoryboard.instantiateViewController(identifier: "DeclarationDetailViewController") as? DeclarationDetailViewController {
            //viewController.pdfURLPath = pdfURLPath
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension DeclarationsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard !isSearchBarEmpty else { return }
        getDeclarations(forKeyword: searchKeyword)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchKeyword = searchText
        isSearchBarEmpty ? declarations.removeAll() : ()
    }
}

// MARK: Keyboard obserbers
extension DeclarationsViewController {
    
    fileprivate func addObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            tableViewBottom.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            let bottom = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
            tableViewBottom.constant = bottom
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

