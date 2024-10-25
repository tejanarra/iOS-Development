import UIKit
import CoreData

class ToDoListController: UITableViewController{
    
    var items:[Item] = []
    
    var selectedCategory:Category? {
        didSet{
            loadData()
        }
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //    let userDefaults = UserDefaults.standard
    
    //    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let itemsArray = userDefaults.array(forKey: "AllItems") as? [Items] {
        //            items = itemsArray
        //        }
        
        //        if let itemsArray = try PropertyListDecoder().decode([Items, from: <#T##Data#>) {
        //            items = itemsArray
        //        }
        
        
    }
    
    //MARK: - Save and Retrieving Data to Plist
    
    func saveToPlist() {
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func loadData(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.categoryName MATCHES %@", selectedCategory!.categoryName!)
        if let searchPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,searchPredicate])
            
        }else{
            
            request.predicate = categoryPredicate
        }
        do{
            items = try context.fetch(request)
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    //    func saveToPlist() {
    //        let encoder = PropertyListEncoder()
    //
    //        do{
    //            let data = try encoder.encode(items)
    //            if let path = dataFilePath {
    //                try data.write(to: path)
    //            }
    //        }catch{
    //            print(error)
    //        }
    //    }
    
    //    func loadData(){
    //        let data = try? Data(contentsOf: dataFilePath!)
    //        let decoder = PropertyListDecoder()
    //        if data != nil {
    //            do{
    //                items = try decoder.decode([Items].self, from: data!)
    //            }catch {
    //                print(error)
    //            }
    //        }
    //    }
    
    
    
    
    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.itemName
        cell.accessoryType = item.isCompleted ? .checkmark : .none
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var textFieldLocal = UITextField()
        let alert = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = self.items[indexPath.row].itemName
            textFieldLocal = textField
        }
        let action = UIAlertAction(title: "Edit", style: .default) { [self] (action) in
            if let text = textFieldLocal.text {
                if !text.isEmpty {
                    
                    self.items[indexPath.row].itemName = text
                    
                    saveToPlist()
                    loadData()
                    
                    self.tableView.reloadData()
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(items[indexPath.row])
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveToPlist()
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let title = items[indexPath.row].isCompleted ? "Mark Incomplete" : "Mark Completed"
        
        let closeAction = UIContextualAction(style: .normal, title:  title, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            self.items[indexPath.row].isCompleted.toggle()
            
            //        self.userDefaults.set(self.items, forKey: "AllItems")
            self.saveToPlist()
            self.loadData()
            
            success(true)
        })
        //        closeAction.image = UIImage(named: "tick")
        closeAction.backgroundColor = items[indexPath.row].isCompleted ? .systemGray : .systemBlue
        tableView.deselectRow(at: indexPath, animated: true)
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50 //or whatever you need
    }
    
    
    //MARK: - AddItems
    
    @IBAction func addItems(_ sender: UIBarButtonItem) {
        
        var textFieldLocal = UITextField()
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Item"
            textFieldLocal = textField
        }
        let action = UIAlertAction(title: "Add", style: .default) { [self] (action) in
            if let text = textFieldLocal.text {
                if !text.isEmpty {
                    let newItem = Item(context: context)
                    newItem.itemName = text
                    newItem.isCompleted = false
                    newItem.parentCategory = self.selectedCategory
                    self.items.append(newItem)
                    //                    self.userDefaults.set(self.items, forKey: "AllItems")
                    
                    saveToPlist()
                    loadData()
                    
                    self.tableView.reloadData()
                }
            }
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
    
    
    
}

//MARK: - Search Bar Delegate Methods
extension ToDoListController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate: NSPredicate = NSPredicate(format: "itemName CONTAINS[cd] %@", searchBar.text!)
        
        let sortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "itemName", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        loadData(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadData()
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
            
        }else{
            
            let request : NSFetchRequest<Item> = Item.fetchRequest()
            
            let predicate = NSPredicate(format: "itemName BEGINSWITH[cd] %@", searchBar.text!)
            
            request.sortDescriptors = [NSSortDescriptor(key: "itemName", ascending: true)]
            
            loadData(with: request, predicate: predicate)
        }
    }
}



