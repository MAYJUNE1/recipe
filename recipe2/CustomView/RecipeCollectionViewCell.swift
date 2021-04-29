//
//  RecipeCollectionViewCell.swift
//  recipe2
//
//  Created by LIM MEI TING on 28/04/2021.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(recipe: RecipeModel) {
        self.recipeNameLabel.sizeToFit();
        self.recipeNameLabel.numberOfLines = 0;
        self.recipeNameLabel.text = recipe.name
        self.recipeImage.image = UIImage(named: recipe.imageName!)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    class var reuseIdentifier: String {
        return "RecipeCollectionViewCellReuseIdentifier"
    }
    
    class var nibName: String {
        return "RecipeCollectionViewCell"
    }
}
