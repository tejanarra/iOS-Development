import UIKit
import RealmSwift

class ToDoListController: UITableViewController{
    
    let realm = try! Realm()
    
    var items:Results<Item>?
    
    var selectedCategory:Category? {
        didSet{
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Save and Retrieving Data to Plist
    
    func save(item:Item) {
        do{
            try realm.write{
                realm.add(item)
            }
        }catch{
            print(error)
        }
    }
    
    func loadData(){
        items = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = items?[indexPath.row]
        cell.textLabel?.text = item?.itemName ?? "No Items Added Yet"
        cell.accessoryType = (item?.isCompleted == true) ? .checkmark : .none
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var textFieldLocal = UITextField()
        let alert = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = self.items?[indexPath.row].itemName
            textFieldLocal = textField
        }
        let action = UIAlertAction(title: "Edit", style: .default) { [self] (action) in
            if let text = textFieldLocal.text {
                if !text.isEmpty{
                    
                    if let itemToEdit = self.items?[indexPath.row] {
                        do {
                            try self.realm.write {
                                itemToEdit.itemName = text
                            }
                            self.tableView.reloadData()
                        } catch {
                            print("Error updating item: \(error)")
                        }
                    }
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
            if let itemToDelete = items?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(itemToDelete)
                    }
                    tableView.deleteRows(at: [indexPath], with: .fade)
                } catch {
                    print("Error deleting item: \(error)")
                    
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let title = (items?[indexPath.row].isCompleted == true) ? "Mark Incomplete" : "Mark Completed"
        
        let closeAction = UIContextualAction(style: .normal, title:  title, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            if let itemToEdit = self.items?[indexPath.row] {
                do {
                    try self.realm.write {
                        itemToEdit.isCompleted.toggle()
                    }
                    self.tableView.reloadData()
                } catch {
                    print("Error updating item: \(error)")
                }
            }
            
            success(true)
        })
        closeAction.backgroundColor = (items?[indexPath.row].isCompleted == true) ? .systemGray : .systemBlue
        tableView.deselectRow(at: indexPath, animated: true)
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
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
                    let newItem = Item()
                    newItem.itemName = text
                    newItem.isCompleted = false
                    if let selectedCategory = self.selectedCategory {
                        do {
                            try self.realm.write {
                                selectedCategory.items.append(newItem)
                            }
                        } catch {
                            print("Error saving item: \(error)")
                        }
                    }
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
        items = items?.filter("itemName CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadData()
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
            
        }else{
            
            items = items?.filter("itemName CONTAINS[cd] %@", searchBar.text!)
                .sorted(byKeyPath: "dateCreated", ascending: true)
            tableView.reloadData()
        }
    }
}



