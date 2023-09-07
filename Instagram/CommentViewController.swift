//
//  CommentViewController.swift
//  Instagram
//
//  Created by WEBSYSTEM-MAC39 on 2023/09/06.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var postData: PostData!
    
    @IBOutlet weak var comment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapSendButton(_ sender: Any) {
        if let postData = self.postData,
        let myid = Auth.auth().currentUser?.uid {
            let saveComment = comment.text ?? ""
            let commentData = [myid : saveComment]
            
            var updateValue: FieldValue
            updateValue = FieldValue.arrayUnion([commentData])
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            postRef.updateData(["comments": updateValue])
        }
    }
}
