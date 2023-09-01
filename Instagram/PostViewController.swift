//
//  PostViewController.swift
//  Instagram
//
//  Created by WEBSYSTEM-MAC39 on 2023/08/28.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SVProgressHUD

class PostViewController: UIViewController {
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
    }
}
