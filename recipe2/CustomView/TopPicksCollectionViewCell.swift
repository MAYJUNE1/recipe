//
//  TopPicksCollectionViewCell.swift
//  recipe2
//
//  Created by LIM MEI TING on 27/04/2021.
//

import UIKit

class TopPicksCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.recipeNameLabel.sizeToFit()
    }
    
    func setupCell(recipe: RecipeModel) {
        
        if(recipe.imageName != nil){
            self.recipeImage.image = UIImage(named: recipe.imageName!)
            
        }else{
            self.recipeImage.image = UIImage(named: "lamb")
        }
        
        self.recipeNameLabel.text = recipe.name
        self.recipeImage.layer.cornerRadius = 10
        self.recipeImage.layer.masksToBounds = true
    }

    class var reuseIdentifier: String {
        return "TopPicksCollectionViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "TopPicksCollectionViewCell"
    }
}
