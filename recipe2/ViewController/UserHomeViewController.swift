//
//  UserHomeViewController.swift
//  recipe2
//
//  Created by LIM MEI TING on 28/04/2021.
//

import UIKit
import CoreData

class UserHomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var btn_AddRecipe: UIButton!
    @IBOutlet weak var recipeListCollectionView: UICollectionView!
    var recipesList : [RecipeModel] = []
    var ingList : [Ingredient] = []
    var stepList : [Step] = []
    var isEdit : Bool!
    var index : Int!
    
    var recipeDB: [NSManagedObject] = []
    var recipe: RecipeModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeListCollectionView.dataSource = self
        recipeListCollectionView.delegate = self
        registerNib()
        
        btn_AddRecipe.addTarget(self, action: #selector(addRecipe), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Recipe")
        
        let fetchRequestIng =
            NSFetchRequest<NSManagedObject>(entityName: "RecipeIngredient")
        
        let fetchRequestStep =
            NSFetchRequest<NSManagedObject>(entityName: "RecipeStep")
        
        do {
            recipeDB = try managedContext.fetch(fetchRequest)
            
            recipesList.removeAll()
            for item in recipeDB{
                let recipe = RecipeModel()
                recipe.name = item.value(forKeyPath: "name") as? String
                recipe.id = item.value(forKey: "id") as? String
                recipe.category = item.value(forKey: "category") as? String
                
                let ingredientDB = try managedContext.fetch(fetchRequestIng)
                ingList.removeAll()
                for item in ingredientDB{
                    let ing = Ingredient()
                    ing.id = item.value(forKey: "id") as? String
                    ing.name = item.value(forKey: "name") as? String
                    ingList.append(ing)
                }
                
                let stepDB = try managedContext.fetch(fetchRequestStep)
                stepList.removeAll()
                for item in stepDB{
                    let step = Step()
                    step.id = item.value(forKey: "id") as? String
                    step.desc = item.value(forKey: "desc") as? String
                    stepList.append(step)
                }
                
                recipe.ingredient = ingList
                recipe.step = stepList
                recipesList.append(recipe)
                
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        recipeListCollectionView.reloadData()
        
    }
    
    @objc func addRecipe(sender:UIButton!) {
        self.isEdit = false
        self.index = recipesList.count
        self.performSegue(withIdentifier: "toAddRecipeSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toAddRecipeSegue"){
            
            let vc = segue.destination as! EditRecipeViewController
            
            vc.isEdit = self.isEdit
            vc.index = self.index
            if(self.isEdit == true){
                let indexPath : NSIndexPath = sender as! NSIndexPath
                vc.recipe = recipesList[indexPath.row]
            }
        }
    }
    
    func registerNib(){
        let nib = UINib(nibName: TopPicksCollectionViewCell.nibName, bundle: nil)
        recipeListCollectionView?.register(nib, forCellWithReuseIdentifier: TopPicksCollectionViewCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.isEdit = true
        self.performSegue(withIdentifier: "toAddRecipeSegue", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeDB.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopPicksCollectionViewCell.reuseIdentifier, for: indexPath) as? TopPicksCollectionViewCell
        
        cell?.setupCell(recipe: recipesList[indexPath.row])
        
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (recipeListCollectionView.frame.size.width - space) / 3.5
        return CGSize(width: size, height: (size + 40.0))
    }
}
