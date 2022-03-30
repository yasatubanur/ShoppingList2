//
//  DetailsViewController.swift
//  ShoppingList2
//
//  Created by Tuba Nur YAŞA on 30.03.2022.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var sizeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyword))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeKeyword(){
        view.endEditing(true)
    }
    
    @IBAction func clickedSaveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let shopping = NSEntityDescription.insertNewObject(forEntityName: "Shopping", into: context)
        
        shopping.setValue(nameTextField.text, forKey: "name")
        shopping.setValue(sizeTextField.text, forKey: "size")
        
        if let price = Int(priceTextField.text!){
            shopping.setValue(price, forKey: "price")
        }
        
        //universal unique id
        shopping.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        shopping.setValue(data, forKey: "image")
        
        
        do{
            try context.save()
            print("saved")
        }catch{
            print("err0r")
        }
    }
    
}
