//
//  ViewController.swift
//  LogInLogOut(CoreData)
//
//  Created by Сергей Голенко on 28.12.2020.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
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
    }
    
    
    
    @IBAction func logOut(_ sender: UIButton) {
    }
    
    
    
    
    
    
    
    
    
    
}

