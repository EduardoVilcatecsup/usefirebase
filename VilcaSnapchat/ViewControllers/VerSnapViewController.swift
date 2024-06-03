//
//  VerSnapViewController.swift
//  VilcaSnapchat
//
//  Created by Eduardo Vilca on 3/06/24.
//

import UIKit

class VerSnapViewController: UIViewController {

    @IBOutlet weak var lblMensaje: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMensaje.text = "Mensaje: " + snap.descrip
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
