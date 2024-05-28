//
//  ImageViewController.swift
//  VilcaSnapchat
//
//  Created by Eduardo Vilca on 27/05/24.
//

import UIKit
import FirebaseStorage

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        self.elegirContactoBoton.isEnabled = false
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        guard let imagenData = imageView.image?.jpegData(compressionQuality: 0.50) else {
            self.mostrarAlerta(titulo: "Error", mensaje: "No se pudo obtener la imagen.", accion: "Aceptar")
            self.elegirContactoBoton.isEnabled = true
            return
        }
        let cargarImagen = imagenesFolder.child("\(NSUUID().uuidString).jpg").putData(imagenData, metadata: nil) { (metadata, error) in
            if let error = error {
                self.mostrarAlerta(titulo: "Error", mensaje: "Se produjo un error al subir la imagen. Verifique su conexión a Internet y vuelva a intentarlo.", accion: "Aceptar")
                self.elegirContactoBoton.isEnabled = true
                print("Ocurrió un error al subir imagen: \(error)")
            } else {
                self.performSegue(withIdentifier: "SeleccionarContactoSegue", sender: nil)
            }
        }
        
        let alertaCarga = UIAlertController(title: "Cargando Imagen...", message: "0%", preferredStyle: .alert)
        let progresoCarga = UIProgressView(progressViewStyle: .default)
        progresoCarga.frame = CGRect(x: 10, y: 70, width: 250, height: 0)
        
        cargarImagen.observe(.progress) { (snapshot) in
            guard let progress = snapshot.progress else { return }
            let porcentaje = Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
            print(porcentaje)
            progresoCarga.setProgress(Float(porcentaje), animated: true)
            alertaCarga.message = String(format: "%.0f%%", porcentaje * 100)
            if porcentaje >= 1.0 {
                alertaCarga.dismiss(animated: true, completion: nil)
            }
        }
        
        let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertaCarga.addAction(btnOK)
        alertaCarga.view.addSubview(progresoCarga)
        present(alertaCarga, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        elegirContactoBoton.isEnabled = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            imageView.backgroundColor = UIColor.clear
            elegirContactoBoton.isEnabled = true
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Código que necesitas para preparar el segue
    }
    
    func mostrarAlerta(titulo: String, mensaje: String, accion: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnCANELOK = UIAlertAction(title: accion, style: .default, handler: nil)
        alerta.addAction(btnCANELOK)
        present(alerta, animated: true, completion: nil)
    }
}
