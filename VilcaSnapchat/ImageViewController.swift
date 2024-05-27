//
//  ImageViewController.swift
//  VilcaSnapchat
//
//  Created by Eduardo Vilca on 27/05/24.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera  //Si no funka ponerle .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descripcionTextField: UITextField!
    
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        elegirContactoBoton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    

    
}
