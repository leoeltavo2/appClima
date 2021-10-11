//
//  ViewController.swift
//  Clima
//
//  Created by marco rodriguez on 07/10/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var condicionImageIV: UIImageView!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    
    //Crear el obj climaManager
    let climaManager = ClimaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buscarTextField.delegate = self
    }

    @IBAction func buscarAccionBtn(_ sender: UIButton) {
        print(buscarTextField.text)
        buscarTextField.text = ""
        ciudadLabel.text = buscarTextField.text
        
    }
    
   // Activa el boton de buscar del teclado virtual
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Ocultar el teclado virtual cuando el usuario presiona el boton
        buscarTextField.endEditing(true)
        
        print(buscarTextField.text)
        ciudadLabel.text = buscarTextField.text
        buscarTextField.text = ""
        return true
    }
    
    //Notifica al VC cuando el usuario dejo de editar
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Realizar la busqueda en la API
        if let ciudad = buscarTextField.text {
            climaManager.buscarClima(nombreCiudad: ciudad)
        }
    }
    
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //Validar que el campo de texto no este vacio
        if buscarTextField.text != "" {
            return true
        } else {
            buscarTextField.placeholder = "Escribe algo"
            return false
        }
    }
    
    
}

