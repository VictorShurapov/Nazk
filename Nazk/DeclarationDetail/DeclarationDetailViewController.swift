//
//  DeclarationDetailViewController.swift
//  Nazk
//
//  Created by Viktor Shurapov on 10/18/20.
//

import UIKit
import PDFKit

class DeclarationDetailViewController: UIViewController {

    @IBOutlet var pdfView: PDFView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfViewSetup()
    }
    
    func pdfViewSetup() {
        if let path = Bundle.main.path(forResource: "sample", ofType: "pdf") {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
            }
        }
    }
}
