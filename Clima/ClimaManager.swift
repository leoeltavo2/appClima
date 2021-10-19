//
//  climaManager.swift
//  Clima
//
//  Created by marco rodriguez on 08/10/21.
//

import Foundation
import CoreLocation


//PROTOCOLO
protocol climaManagerDelegate{
    func actualizarClima(clima: ClimaModelo)
    func huboError(cualErro: Error)
}

struct ClimaManager{
    
    var delegado: climaManagerDelegate?
    
    let urlClima = "https://api.openweathermap.org/data/2.5/weather?appid=43c02b88939bc65afefdef7ff3b31822&lang=es&units=metric&q="
    
    func buscarClima(nombreCiudad: String){
        let urlString = "\(urlClima)\(nombreCiudad)"
        //print("URL String: \(urlString)")
        realizarSolicitud(urlString: urlString)
    }
    
   //BUSCAR POR GPS
    func buscarGPS(lat: CLLocationDegrees, lang: CLLocationDegrees){
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lang)&appid=43c02b88939bc65afefdef7ff3b31822&lang=es&units=metric&q="
        realizarSolicitud(urlString: urlString)
    }
    
    
    func realizarSolicitud(urlString: String) {
        //1.- Crear URL
        if let url = URL(string: urlString) {
            //2.- Crear una sesion URL
            let sesion = URLSession(configuration: .default)
            //3.- Asignarle una tarea a la sesion para recuperar el contenido
            //let tarea = sesion.dataTask(with: url, completionHandler: handle(datos:respuesta:error:))
            let tarea = sesion.dataTask(with: url) { datos, respuesta, error in
                if error != nil {
                    print("Error al procesar LA API \(error?.localizedDescription)")
                    return
                }
                
                //Si no hubo errores
                if let datosSeguros = datos  {
                    // Crear mi Obj Personalizado
                    if let objClima = parseJSON(climaData: datosSeguros) {
                        delegado?.actualizarClima(clima: objClima)
                    }
                }
            }
            //4.- Iniciar
            tarea.resume()
        }
    }// :realizarSolicitud
    
    func parseJSON(climaData: Data) -> ClimaModelo? {
        let decoder = JSONDecoder()
        do{
            let datosDecodificados = try decoder.decode(ClimaData.self, from: climaData)
            
       
            print(datosDecodificados.weather[0].id)
            print(datosDecodificados.name)
            print(datosDecodificados.weather[0].description)
            print(datosDecodificados.main.temp)
            
            
            //Crear el objeto con los parametros
            let objClimaJson = ClimaModelo(condicionID: datosDecodificados.weather[0].id, nombreCiudad: datosDecodificados.name, temperaturaCelcius: datosDecodificados.main.temp, descripcionClima: datosDecodificados.weather[0].description)
            
            return objClimaJson
            
        } catch {
//            print("Error: \(error.localizedDescription)")
            delegado?.huboError(cualErro: error)
            return nil
        }
    }
    
    
    
//    //Crear esa funcion que necesito para
//    func handle(datos: Data?, respuesta: URLResponse?, error: Error?){
//        if error != nil {
//            print("Error al procesar LA API \(error?.localizedDescription)")
//            return
//        }
//
//        //Si no hubo errores
//        if let datosSeguros = datos  {
//            let datosString = String(data: datosSeguros, encoding: .utf8)
//            print("Datos Seguros: \(datosString)")
//        }
//    }
//    
}
