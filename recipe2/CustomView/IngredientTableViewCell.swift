//
//  IngredientTableViewCell.swift
//  recipe2
//
//  Created by LIM MEI TING on 27/04/2021.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        let border = CALayer()
        border.backgroundColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }
    
    func setupCell(ingredient: Ingredient) {
        self.ingredientLabel.sizeToFit();
        self.ingredientLabel.numberOfLines = 0;
        self.ingredientLabel.text = ingredient.name
    }
    
    class var reuseIdentifier: String {
        return "IngredientTableViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "IngredientTableViewCell"
    }
    
}
