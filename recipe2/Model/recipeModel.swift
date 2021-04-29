//
//  recipeModel.swift
//  recipe2
//
//  Created by LIM MEI TING on 27/04/2021.
//

import Foundation
import XMLMapper

class RecipeModelElement: XMLMappable {
    
    var nodeName: String!
    
    var testElement: [RecipeModel]!
    
    init(){}
    
    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        testElement <- map["recipe"]
    }
}



class RecipeModel: XMLMappable {
    var nodeName: String!

    var id: String?
    var name: String?
    var category: String?
    var ingredient: [Ingredient] = []
    var step: [Step] = []
    
    var imageName: String?
    //var image = UIImage(imageName)
    
    init() {}

    required init?(map: XMLMap) { }

    func mapping(map: XMLMap) {
        id <- map["id"]
        name <- map["name"]
        category <- map["category"]
        ingredient <- map["ingredient"]
        step <- map["step"]
        imageName <- map["imageName"]
    }

}

class Ingredient: XMLMappable {
    var nodeName: String!

    var id: String?
    var name: String?
    
    init(){}

    required init?(map: XMLMap) { }

    func mapping(map: XMLMap) {
        id <- map["id"]
        name <- map["name"]
    }

}

class Step: XMLMappable {
    var nodeName: String!

    var id: String?
    var desc: String?

    init(){}
    
    required init?(map: XMLMap) { }

    func mapping(map: XMLMap) {
        id <- map["id"]
        desc <- map["desc"]
    }

}

//
//class RecipeModel :  XMLMapper{
//    var id : String = ""
//    var name: String = ""
//    var category: String = ""
//    var desc: String = ""
//    var rating: Double = 0.0
//    var comments : String = ""
//    var prepTime: String = ""
//    var ingredient: [Ingredients] = []
//    var step: [Steps] = []
//    var image: String = ""
////    private var imageName: String
////    var image: Image {
////        Image(imageName)
////    }
//
//}
//
//class Ingredients{
//    var id : String = ""
//    var name : String = ""
//}
//
//class Steps {
//    var id : String = ""
//    var desc : String = ""
//}
