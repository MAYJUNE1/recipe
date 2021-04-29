//
//  RecipeDetailsViewController.swift
//  recipe2
//
//  Created by LIM MEI TING on 27/04/2021.
//

import UIKit
import XMLMapper

class RecipeDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var ingStepTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var ingStepTableView: UITableView!
    var recipe :RecipeModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = recipe.name
        
        ingStepTableView.dataSource = self
        ingStepTableView.delegate = self
        registerNib()
        
        ingStepTableView.estimatedRowHeight = 300
        ingStepTableView.rowHeight = UITableView.automaticDimension
        
        if(recipe.imageName != nil){
            self.imageRecipe.image = UIImage(named: recipe.imageName!)
            
        }else{
            self.imageRecipe.image = UIImage(named: "lamb")
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        ingStepTableHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        ingStepTableView.reloadData()
        ingStepTableView.layoutIfNeeded()
        ingStepTableHeightConstraint.constant = self.ingStepTableView.contentSize.height
        
    }
    
    func registerNib() {
        let nib = UINib(nibName: IngredientTableViewCell.nibName, bundle: nil)
        ingStepTableView.register(nib, forCellReuseIdentifier: IngredientTableViewCell.reuseIdentifier)
        
        let nib2 = UINib(nibName: StepTableViewCell.nibName, bundle: nil)
        ingStepTableView.register(nib2, forCellReuseIdentifier: StepTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40))
        headerView.backgroundColor = UIColor.clear
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 5, y: 20, width: tableView.contentSize.width, height: 20)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 19)
        
        if(section == 0){
            headerLabel.text =  "Ingredient"
        }else{
            headerLabel.text = "Steps"
        }
        headerView.addSubview(headerLabel)
        
        
        
        return headerView
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return recipe.ingredient.count
        }else{
            return recipe.step.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.reuseIdentifier, for: indexPath) as? IngredientTableViewCell
            
            let name = recipe.ingredient[indexPath.row]
            
            cell?.setupCell(ingredient: name)
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: StepTableViewCell.reuseIdentifier, for: indexPath) as? StepTableViewCell
            
            let name = recipe.step[indexPath.row]
            
            cell?.setupCell(step: name)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
