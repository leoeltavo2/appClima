//
//  ViewController.swift
//  Clima
//
//  Created by marco rodriguez on 07/10/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var condicionImageIV: UIImageView!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var descripcionClima: UILabel!
    @IBOutlet weak var imgFondo: UIImageView!
    
    //obj locationManager
    var locationManager = CLLocationManager()
    
    //Crear el obj climaManager
    var climaManager = ClimaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        //solicitar permisos de GPS
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
      
        
        buscarTextField.delegate = self
        climaManager.delegado = self
    }

    @IBAction func buscarAccionBtn(_ sender: UIButton) {
        print(buscarTextField.text)
        buscarTextField.text = ""
//        ciudadLabel.text = buscarTextField.text

    }
    
    @IBAction func btnGPS(_ sender: UIButton) {
        
        locationManager.startUpdatingLocation()
    }
}

//BUSQUEFA POR GPS
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("localización obtenida")
        if let ubicacion = locations.last{
            let latitud = ubicacion.coordinate.latitude
            let longitud = ubicacion.coordinate.longitude
            climaManager.buscarGPS(lat: latitud, lang: longitud)
            
            print("Latitud: \(latitud) Longitud: \(longitud)")
            
        }
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener ubicación")
    }
    
    
}



//BUSQUEDA CLIMA
extension ViewController: climaManagerDelegate{
    func actualizarClima(clima: ClimaModelo) {
        DispatchQueue.main.async {
            self.temperaturaLabel.text = "\(clima.temperaturaCelcius)"
            self.ciudadLabel.text = clima.nombreCiudad
            self.descripcionClima.text = clima.descripcionClima
            self.condicionImageIV.image = UIImage(systemName: "\(clima.obtenerCondicionClima)")
            self.imgFondo.image = UIImage(named: "\(clima.obtenerImagenClima)")
        }

    }
    
    func huboError(cualErro: Error) {
        DispatchQueue.main.async {
            self.temperaturaLabel.text = "\(cualErro.localizedDescription)"
        }
    }
    
    
}


// TEXFIELDDELAGATE
extension ViewController: UITextFieldDelegate{
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
