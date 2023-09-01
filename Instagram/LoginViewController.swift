//
//  LoginViewController.swift
//  Instagram
//
//  Created by WEBSYSTEM-MAC39 on 2023/08/23.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleLoginButton(_ sender: Any) {
        if let address = mailAddressTextField.text,
           let password = passwordTextField.text {
            
            if address.isEmpty || password.isEmpty {
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                return
            }
            
            // HUDで処理中を表示
            SVProgressHUD.show()
            
            Auth.auth().signIn(withEmail: address, password: password) { AuthDataResult, error in
                if let error = error {
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "サインインに失敗しました")
                    return
                }
                print("DEBUG_PRINT: ログインに成功")
                
                // HUDを消す
                SVProgressHUD.dismiss()
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        if let address = mailAddressTextField.text,
           let password = passwordTextField.text,
           let dispalyName = displayNameTextField.text {
            
            if address.isEmpty || password.isEmpty || dispalyName.isEmpty {
                print("DEBUG_PRINT: 何れかが入力されてない")
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                return
            }
            
            SVProgressHUD.show()
            
            Auth.auth().createUser(withEmail: address, password: password) { authResult, error in
                if let error = error {
                    print("DEBUG_PRINT: error: \(error.localizedDescription)")
                    SVProgressHUD.showError(withStatus: "ユーザー作成に失敗しました")
                    return
                }
                print("DEBUG_PRINT: アカウント作成成功")
                
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = dispalyName
                    changeRequest.commitChanges { error in
                        if let error = error {
                            print("DEBUG_PRINT: error: \(error.localizedDescription)")
                            SVProgressHUD.showError(withStatus: "表示名の設定に失敗しました")
                            return
                        }
                    }
                    print("DEBUG_PRINT: \(dispalyName)の設定に成功")
                    
                    SVProgressHUD.dismiss()
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
