//
//  NazkApi.swift
//  Nazk
//
//  Created by Viktor Shurapov on 10/16/20.
//

import Foundation
import Moya

// MARK: - Provider setup

let declarationsProvider = MoyaProvider<NazkAPI>()

// MARK: - Provider support

enum NazkAPI {
    case getDeclarations(keyword: String)
}

extension NazkAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://public-api.nazk.gov.ua/v1")!
    }
    
    var path: String {
        switch self {
        case .getDeclarations:
            return "declaration"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDeclarations:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getDeclarations(let keyword):
            return .requestParameters(parameters: ["q": keyword], encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        switch self {
        case .getDeclarations:
            return ["Content-type": "application/json"]
        }
    }
}
