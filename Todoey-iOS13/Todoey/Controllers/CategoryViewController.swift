//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Teja Narra on 10/24/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories:[Category] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
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
                    let newCategory = Category(context: context)
                    newCategory.categoryName = text
                    self.categories.append(newCategory)
                    
                    saveToPlist()
                    loadData()
                    
                    self.tableView.reloadData()
                }
            }
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
        
    }
    
    //MARK: - Save and Retrieving Data to Plist
    
    func saveToPlist() {
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            categories = try context.fetch(request)
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    
    
    //MARK: - Table View Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.categoryName
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems"{
            let destinationVC = segue.destination as! ToDoListController
            
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.selectedCategory = categories[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Fetch the category to be deleted
            let categoryToDelete = categories[indexPath.row]

            // Create a fetch request for related items
            let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "parentCategory == %@", categoryToDelete)

            do {
                // Fetch related items
                let itemsToDelete = try context.fetch(fetchRequest)
                // Delete each related item
                for item in itemsToDelete {
                    context.delete(item)
                }
                // Delete the category
                context.delete(categoryToDelete)

                // Remove from local array and update UI
                categories.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

                // Save context
                saveToPlist()
            } catch {
                print("Error fetching items: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75 //or whatever you need
    }

    
}
