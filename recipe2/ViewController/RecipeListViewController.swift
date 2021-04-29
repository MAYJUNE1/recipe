//
//  RecipeListViewController.swift
//  recipe2
//
//  Created by LIM MEI TING on 27/04/2021.
//

import UIKit

class RecipeListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var recipeListCollectionView: UICollectionView!
    var recipeList : [RecipeModel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        recipeListCollectionView.dataSource = self
        recipeListCollectionView.delegate = self
        registerNib()
    }
    
    func registerNib(){
        let nib = UINib(nibName: RecipeCollectionViewCell.nibName, bundle: nil)
        recipeListCollectionView?.register(nib, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toRecipeDetailsSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toRecipeDetailsSegue")
        {
            let indexPath : NSIndexPath = sender as! NSIndexPath
            let vc = segue.destination as! RecipeDetailsViewController
            
            vc.recipe = recipeList?[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reuseIdentifier, for: indexPath) as? RecipeCollectionViewCell
        
        cell?.setupCell(recipe: recipeList[indexPath.row])
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (recipeListCollectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: 220)
    }
    
}
