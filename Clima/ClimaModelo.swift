//
//  ClimaModelo.swift
//  Clima
//
//  Created by marco rodriguez on 11/10/21.
//

import Foundation

struct ClimaModelo {
    let condicionID: Int
    let nombreCiudad: String
    let temperaturaCelcius: Double
    let descripcionClima: String


var obtenerCondicionClima: String{
    switch condicionID {
    case 800:
        return "sunrise.fill"
    case 801...804:
        return "cloud.fill"
    case 600...622:
        return "snow"
    case 500...531:
        return "cloud.rain"
    case 300...321:
        return "cloud.drizzle"
    case 200...232:
        return "cloud.heavyrain"
    default:
        return "cloud"
        }
    }
    
    var obtenerImagenClima: String{
        switch condicionID{
        case 800:
            return "despejado"
        case 801...804:
            return "nuebes"
        case 600...622:
            return "nevando"
        case 500...531:
            return "llovizna"
        case 300...321:
            return "llovizna"
        case 200...232:
            return "tormenta"
        default:
            return "soleado"
        }
    }
}
