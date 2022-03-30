//
//  DetailsViewController.swift
//  ShoppingList2
//
//  Created by Tuba Nur YAŞA on 30.03.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var sizeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyword))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func closeKeyword(){
        view.endEditing(true)
    }
    
    @IBAction func clickedSaveButton(_ sender: Any) {
    }
    
}
