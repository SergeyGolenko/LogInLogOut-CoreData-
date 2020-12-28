//
//  ViewController.swift
//  LogInLogOut(CoreData)
//
//  Created by Сергей Голенко on 28.12.2020.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    var isLoggedIn = false
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    
    func accesToVieContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let context = accesToVieContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                if let username = result.value(forKey: "name") as? String {
                    logInButton.setTitle("Update username", for: [])
                    logOutButton.alpha = 1
                    label.alpha = 1
                    label.text = "Hi there " + username + "!"
                }
            }
        } catch {
            print("Request failed")
        }
    }


    @IBAction func logIn(_ sender: UIButton) {
        let context = accesToVieContext()
        if isLoggedIn {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            do {
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        result.setValue(textField.text, forKey: "name")
                        do {
                            try context.save()
                        } catch {
                            print("Update username save failed")
                        }
                    }
                 label.text = "Hi there " + textField.text! + "!"
                }
            } catch {
            print("Update username failed")
            }
        } else {
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            newValue.setValue(textField.text, forKey: "name")
            do {
                try context.save()
                logInButton.setTitle("Update username", for: [])
                label.alpha = 1
                label.text = "Hi there " + textField.text! + "!"
                isLoggedIn = true
                logOutButton.alpha = 1
            } catch {
                print("Failed to save")
            }
        }
    }
    
    
    @IBAction func logOut(_ sender: UIButton) {
        let context = accesToVieContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                    do {
                        try context.save()
                    } catch {
                    print("Individual delete failed")
                    }
                }
                label.alpha = 0
                logOutButton.alpha = 0
                logInButton.setTitle("Login", for: [])
                isLoggedIn = false
                textField.alpha = 1
            }
        } catch {
            print("Delete failed")
        }
    }
    
}


