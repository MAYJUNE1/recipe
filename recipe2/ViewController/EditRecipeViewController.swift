//
//  EditRecipeViewController.swift
//  recipe2
//
//  Created by LIM MEI TING on 28/04/2021.
//

import UIKit
import XMLMapper
import CoreData

class EditRecipeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btn_AddStep: UIButton!
    @IBOutlet weak var btn_AddIngredient: UIButton!
    @IBOutlet weak var stepTableView: UITableView!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var textField_Category: UITextField!
    @IBOutlet weak var textField_Ingredient: UITextField!
    @IBOutlet weak var textField_Step: UITextField!
    @IBOutlet weak var textField_Title: UITextField!
    @IBOutlet weak var ingredientTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stepTableHeightConstraint: NSLayoutConstraint!
    
    var isEdit: Bool!
    var recipe : RecipeModel!
    let categoryList = Constant.categoryList
    var pickerView = UIPickerView()
    var ingredientList : [Ingredient] = []
    var stepList : [Step] = []
    var index :Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField_Title.delegate = self
        
        pickerView.dataSource = self
        pickerView.delegate = self
        textField_Category.inputView = pickerView
        
        ingredientTableView.dataSource = self
        stepTableView.dataSource = self
        registerNib()
        
        btn_AddIngredient.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        btn_AddStep.addTarget(self, action: #selector(addStep), for: .touchUpInside)
        
        let btn_Save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveRecipe))
        let btn_Delete = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteRecipe))
        
        if(isEdit == true){
            navigationItem.rightBarButtonItems = [btn_Delete, btn_Save]
        }else{
            navigationItem.rightBarButtonItems = [btn_Save]
        }
        
        
        if(isEdit == true){
            loadData()
            print("edit")
        }else{
            print("add")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        ingredientTableHeightConstraint.constant = self.ingredientTableView.contentSize.height
        stepTableHeightConstraint.constant = self.stepTableView.contentSize.height
    }
    
    func loadData(){
        textField_Title.text = recipe.name
        textField_Category.text = recipe.category
        ingredientList = recipe.ingredient 
        stepList = recipe.step 
    }
    
    func validateInput() -> Bool{
        if(textField_Title.text!.isEmpty || textField_Category.text!.isEmpty || ingredientList.count == 0 || stepList.count == 0 ){
            return false
        }else{
            return true
        }
    }
    
    @objc func saveRecipe(sender:UIButton!) {
        if(validateInput() == false){
            let alert = UIAlertController(title: "Warning", message: "Please key in all the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in }))
            self.present(alert, animated: true, completion: nil)
        }else{
            recipe = RecipeModel()
            recipe.id = String(index)
            recipe.name = textField_Title.text
            recipe.category = textField_Category.text
            recipe.ingredient = ingredientList
            recipe.step = stepList
            
            self.saveRecipeDB(recipe: recipe)
            print("save")
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @objc func deleteRecipe(sender:UIButton!) {
            self.deleteRecipeDB(recipe: recipe)
            print("save")
            self.navigationController?.popViewController(animated: false)
        
    }
    
    @objc func addIngredient(sender:UIButton!) {
        let index = ingredientList.count
        
        let tempIngredient = Ingredient()
        
        tempIngredient.id = String(index)
        tempIngredient.name = textField_Ingredient.text
        
        ingredientList.append(tempIngredient)
        ingredientTableView.reloadData();
        ingredientTableHeightConstraint.constant = self.ingredientTableView.contentSize.height
        
        textField_Ingredient.text = ""
        
    }
    
    @objc func addStep(sender:UIButton!) {
        let index = stepList.count
        
        let tempStep = Step()
        
        tempStep.id = String(index)
        tempStep.desc = textField_Step.text
        
        stepList.append(tempStep)
        stepTableView.reloadData();
        stepTableHeightConstraint.constant = self.ingredientTableView.contentSize.height
        
        textField_Step.text = ""
    }
    
    func saveRecipeDB(recipe: RecipeModel) {
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Recipe",
                                       in: managedContext)!
        
        let recipes = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        
        
        let ingredientArr: NSMutableArray = []
        for n in 0...(recipe.ingredient.count-1) {
            let ingredientOn = RecipeIngredient(context: managedContext)
            ingredientOn.id = recipe.ingredient[n].id
            ingredientOn.name = recipe.ingredient[n].name
            ingredientArr.add(ingredientOn)
        }
        
        let ingredientSet = NSSet(array: ingredientArr as NSArray as! [NSObject])
        recipes.setValue(ingredientSet, forKey: "ingredient")
        
        let stepArr: NSMutableArray = []
        for n in 0...(recipe.step.count-1) {
            let stepOn = RecipeStep(context: managedContext)
            stepOn.id = recipe.step[n].id
            stepOn.desc = recipe.step[n].desc
            stepArr.add(stepOn)
        }
        
        let steptSet = NSSet(array: stepArr as NSArray as! [NSObject])
        recipes.setValue(steptSet, forKey: "step")
        recipes.setValue(recipe.name, forKeyPath: "name")
        recipes.setValue(recipe.id, forKeyPath: "id")
        recipes.setValue(recipe.category, forKeyPath: "category")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteRecipeDB(recipe: RecipeModel) {
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Recipe")
        fetchRequest.predicate = NSPredicate.init(format: "id==\(recipe.id!)")
        if let result = try? managedContext.fetch(fetchRequest) {

            if result.count > 0 {
                managedContext.delete(result[0])
            }

        } else {
            // ... fetch failed, report error
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        // move the root view up by the distance of keyboard height
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
    func registerNib() {
        let nib = UINib(nibName: IngredientTableViewCell.nibName, bundle: nil)
        ingredientTableView.register(nib, forCellReuseIdentifier: IngredientTableViewCell.reuseIdentifier)
        
        let nib2 = UINib(nibName: StepTableViewCell.nibName, bundle: nil)
        stepTableView.register(nib2, forCellReuseIdentifier: StepTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == ingredientTableView){
            return ingredientList.count
        }
        else{
            return stepList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == ingredientTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.reuseIdentifier, for: indexPath) as? IngredientTableViewCell
            
            let name = ingredientList[indexPath.row]
            
            cell?.setupCell(ingredient: name)
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: StepTableViewCell.reuseIdentifier, for: indexPath) as? StepTableViewCell
            
            let name = stepList[indexPath.row]
            
            cell?.setupCell(step: name)
            return cell!
        }
    }
    
    //    pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList?.testElement.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList?.testElement[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField_Category.text = categoryList?.testElement[row].name
        textField_Category.resignFirstResponder()
    }
}

extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

