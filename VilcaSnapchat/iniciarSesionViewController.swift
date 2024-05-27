//
//  ViewController.swift
//  VilcaSnapchat
//
//  Created by Eduardo Vilca on 20/05/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
class iniciarSesionViewController: UIViewController {

    
    @IBAction func googlexdxd(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

          // ...
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in print ("Intenado crear un usuario")
                    if error != nil {
                    print("Se presento el siguiente error al crear el usuario : \(error)")
                    
                }else{
                    print("El usuario fue creado exitosamente ")
                    self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                }
                })
            }else{
                print("Inicio de sesion exitoso :D")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    



}

