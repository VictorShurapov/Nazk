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
}

struct MetaData: Codable {
    let batchSize: Int
    let totalItems: String
    let currentPage: Int
}
