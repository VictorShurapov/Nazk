//
//  DeclaraionsModel.swift
//  Nazk
//
//  Created by Viktor Shurapov on 10/16/20.
//

import Foundation

struct DeclaraionsModel: Codable {
    let items: [InfoOfficial]
    let page: MetaData
}

struct InfoOfficial: Codable {
    let position: String?
    let id: String
    let lastname: String?
    let placeOfWork: String?
    let firstname: String?
    var linkPDF: String? = "https://public.nazk.gov.ua/storage/documents/pdf/b/f/f/8/bff8fc4d-6a0e-46c7-b82a-e4fe72c6e833.pdf"
}

struct MetaData: Codable {
    let batchSize: Int
    let totalItems: String
    let currentPage: Int
}
