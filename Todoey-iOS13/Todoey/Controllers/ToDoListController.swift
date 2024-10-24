import UIKit

class ToDoListController: UITableViewController {
    
    var items2 = ["teja","narra","puskoori","swathi"]
    
    var items:[Items] = []
    
    let userDefaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //        if let itemsArray = userDefaults.array(forKey: "AllItems") as? [Items] {
        //            items = itemsArray
        //        }
        
        //        if let itemsArray = try PropertyListDecoder().decode([Items, from: <#T##Data#>) {
        //            items = itemsArray
        //        }
        loadData()
        
    }
    
    //MARK: - Save and Retrieving Data to Plist
    
    func saveToPlist() {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(items)
            if let path = dataFilePath {
                try data.write(to: path)
            }
        }catch{
            print(error)
        }
    }
    
    func loadData(){
        let data = try? Data(contentsOf: dataFilePath!)
        let decoder = PropertyListDecoder()
        if data != nil {
            do{
                items = try decoder.decode([Items].self, from: data!)
            }catch {
                print(error)
            }
        }
    }
    
    
    
    
    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].itemName
        if items[indexPath.row].isCompleted {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if items[indexPath.row].isCompleted {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            items[indexPath.row].isCompleted = false
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            items[indexPath.row].isCompleted = true
        }
        //        self.userDefaults.set(self.items, forKey: "AllItems")
        saveToPlist()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveToPlist()
        }
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
                    self.items.append(Items(itemName: text, isCompleted: false))
                    //                    self.userDefaults.set(self.items, forKey: "AllItems")
                    
                    saveToPlist()
                    
                    self.tableView.reloadData()
                }
            }
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
    
    
    
}

