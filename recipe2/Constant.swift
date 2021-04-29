//
//  Constant.swift
//  recipe2
//
//  Created by LIM MEI TING on 28/04/2021.
//

import Foundation
import XMLMapper

struct Constant {
    static let categoryList = XMLMapper<CategoryModelElement>().map(XMLfile: "category.xml")
    static let recipesList = XMLMapper<RecipeModelElement>().map(XMLfile: "recipes.xml")
}
