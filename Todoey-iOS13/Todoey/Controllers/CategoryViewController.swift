//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Teja Narra on 10/24/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import CoolColourLibrary

class CategoryViewController: UITableViewController {
    
    var categories:Results<Category>?
    
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData() // Reload data every time the view appears
    }
    
    //MARK: - AddItems
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFieldLocal = UITextField()
        let alert = UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Category"
            textFieldLocal = textField
        }
        let action = UIAlertAction(title: "Add", style: .default) { [self] (action) in
            if let text = textFieldLocal.text {
                if !text.isEmpty {
                    let newCategory = Category()
                    newCategory.categoryName = text
                    save(category: newCategory)
                    loadData()
                    
                    self.tableView.reloadData()
                }
            }
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
        
    }
    
    //MARK: - Save and Retrieving Data to Plist
    
    func save(category: Category) {
        do{
            try realm.write{
                realm.add(category)
            }
            
        }catch{
            print(error)
        }
    }
    
    func loadData(){
        
        categories = realm.objects(Category.self).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    //MARK: - Table View Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CustomCategoryCell
        let category = categories?[indexPath.row]
        let count = category?.items.count ?? 0
        //        cell.textLabel?.text = "\(category?.categoryName ?? "No Category") (\(count))"
        cell.name.text = category?.categoryName ?? "No Category"
        cell.count.text = "\(count)"
        cell.backgroundColor = UIColor(hexString: category?.categoryColor ?? "#3498db")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems"{
            let destinationVC = segue.destination as! ToDoListController
            
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.selectedCategory = categories?[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if let categoryToDelete = categories?[indexPath.row]{
            do {
                try realm.write {
                    realm.delete(categoryToDelete.items)
                    realm.delete(categoryToDelete)
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            } catch {
                print("Error fetching items: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75
    }
    
    
}
