//
//  categoryModel.swift
//  recipe2
//
//  Created by LIM MEI TING on 28/04/2021.
//

import Foundation
import XMLMapper

class CategoryModelElement: XMLMappable {
    
    var nodeName: String!
    
    var testElement: [CategoryModel]!
    
    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        testElement <- map["category"]
    }
}

class CategoryModel: XMLMappable {
    var nodeName: String!
    
    var id: String?
    var name: String?
    required init?(map: XMLMap) { }
    
    func mapping(map: XMLMap) {
        id <- map["id"]
        name <- map["name"]
    }
}
