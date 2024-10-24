// Modelo

import Foundation
import SwiftData

@Model
class Planta: Identifiable {
    var id: Int
    var nombre: String
    var imagen: String
    var descripción: String
    var uso: String
    
    init(id: Int, nombre: String, imagen: String, descripción: String, uso: String) {
        self.id = id
        self.nombre = nombre
        self.imagen = imagen
        self.descripción = descripción
        self.uso = uso
    }
}
