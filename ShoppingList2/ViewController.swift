//
//  ViewController.swift
//  ShoppingList2
//
//  Created by Tuba Nur YAŞA on 30.03.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var nameArray = [String]()
    var idArray = [UUID]()
    var chosenName = ""
    var chosenUUID : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(clickedAddButton))
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "dataEntered"), object: nil)
    }
    
    @objc func getData(){
        
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shopping")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    nameArray.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID{
                    idArray.append(id)
                }
            }
            
            tableView.reloadData()
        }catch{
            print("error")
        }
    }

    @objc func clickedAddButton() {
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.chosenProductName = chosenName
            destinationVC.chosenProductID = chosenUUID
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenName = nameArray[indexPath.row]
        chosenUUID = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
}

