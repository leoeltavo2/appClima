//
//  climaManager.swift
//  Clima
//
//  Created by marco rodriguez on 08/10/21.
//

import Foundation

struct ClimaManager{
    let urlClima = "https://api.openweathermap.org/data/2.5/weather?appid=43c02b88939bc65afefdef7ff3b31822&lang=es&units=metric&q="
    
    func buscarClima(nombreCiudad: String){
        let urlString = "\(urlClima)\(nombreCiudad)"
        //print("URL String: \(urlString)")
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString: String) {
        //1.- Crear URL
        if let url = URL(string: urlString) {
            //2.- Crear una sesion URL
            let sesion = URLSession(configuration: .default)
            //3.- Asignarle una tarea a la sesion para recuperar el contenido
            let tarea = sesion.dataTask(with: url, completionHandler: handle(datos:respuesta:error:))
            //4.- Iniciar
            tarea.resume()
        }
        
        
    }
    
    
    //Crear esa funcion que necesito para
    func handle(datos: Data?, respuesta: URLResponse?, error: Error?){
        if error != nil {
            print("Error al procesar LA API \(error?.localizedDescription)")
            return
        }
        
        //Si no hubo errores
        if let datosSeguros = datos  {
            let datosString = String(data: datosSeguros, encoding: .utf8)
            print("Datos Seguros: \(datosString)")
        }
    }
    
}
