//
//  ViewController.swift
//  ShoppingList2
//
//  Created by Tuba Nur YAŞA on 30.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(clickedAddButton))
    }

    @objc func clickedAddButton() {
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }

}

