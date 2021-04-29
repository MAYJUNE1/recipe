//
//  ViewController.swift
//  recipe2
//
//  Created by LIM MEI TING on 26/04/2021.
//

import UIKit
import XMLMapper

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    
    @IBOutlet weak var toppickCollectionnView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var toppickHeightConstraint: NSLayoutConstraint!
    var names = ["Anders", "Kristian", "Sofia", "John", "Jenny", "Lina", "Annie", "Katie", "Johanna"]
    let reuseIdentifier = "CategoryCollectionViewCellReuseIdentifier"
    let recipesList = Constant.recipesList
    let categoryList = Constant.categoryList
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        toppickCollectionnView.dataSource = self
        toppickCollectionnView.delegate = self
        
        registerNib()
        
        let size:CGFloat = (toppickCollectionnView.frame.size.width - 40.0) / 2.0
        toppickHeightConstraint.constant = size + 40.0
    }
    
    func registerNib() {
        let nib = UINib(nibName: CategoryCollectionViewCell.nibName, bundle: nil)
        categoryCollectionView?.register(nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        let nibtop = UINib(nibName: TopPicksCollectionViewCell.nibName, bundle: nil)
        toppickCollectionnView?.register(nibtop, forCellWithReuseIdentifier: TopPicksCollectionViewCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == self.categoryCollectionView){
            return categoryList?.testElement.count ?? 0
        }else{
            return recipesList?.testElement.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == self.categoryCollectionView){
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier,
                                                             for: indexPath) as? CategoryCollectionViewCell {
                //                let name = catego[indexPath.row]
                cell.setupCell(name: categoryList!.testElement[indexPath.row].name!)
                return cell
            }
        }else{
            if let cellb = collectionView.dequeueReusableCell(withReuseIdentifier: TopPicksCollectionViewCell.reuseIdentifier,
                                                              for: indexPath) as? TopPicksCollectionViewCell {
                
                cellb.setupCell(recipe: recipesList!.testElement[indexPath.row])
                return cellb
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == self.categoryCollectionView){
            self.performSegue(withIdentifier: "toRecipeListSegue", sender: indexPath)
        }else{
            self.performSegue(withIdentifier: "toRecipeDetailsSegue", sender: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toRecipeDetailsSegue")
        {
            let indexPath : NSIndexPath = sender as! NSIndexPath
            let vc = segue.destination as! RecipeDetailsViewController
            
            vc.recipe = recipesList?.testElement[indexPath.row]
        } else if(segue.identifier == "toRecipeListSegue"){
            
            let indexPath : NSIndexPath = sender as! NSIndexPath
            let vc = segue.destination as! RecipeListViewController
            
            let arr = recipesList?.testElement.filter {
                $0.category == categoryList?.testElement[indexPath.row].id
            }
            
            vc.recipeList = arr
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == self.categoryCollectionView){
            return CGSize(width: 100, height: 100)
        }else{
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (toppickCollectionnView.frame.size.width - space) / 2.0
            return CGSize(width: size, height: (size + 40.0))
        }
    }
}
