//
//  DataManager.swift
//  PlanSnap
//
//  Created by Oscar Zhao Xu on 21/10/24.
//

import Foundation
import SwiftData


struct DataManager {
    static func addData(to context: ModelContext) {
        // Eliminar posibles datos existentes
        let existingPlantas = try? context.fetch(FetchDescriptor<Planta>())
        existingPlantas?.forEach { context.delete($0) }
        
        let plantas = [
            Planta(id: 1, nombre: "aloe vera", imagen: "", descripción: "Aloe vera es una planta medicinal popular conocida por sus propiedades curativas para la piel y quemaduras.", uso: "Se usa comúnmente en productos para el cuidado de la piel y como tratamiento para quemaduras menores."),
            Planta(id: 2, nombre: "banana", imagen: "", descripción: "La banana es una fruta tropical rica en potasio y fibra.", uso: "Consumida fresca, en postres, batidos, o como snack."),
            Planta(id: 3, nombre: "bilimbi", imagen: "", descripción: "El bilimbi es una fruta ácida de forma cilíndrica que se encuentra en regiones tropicales.", uso: "Se utiliza en la cocina para aderezar platos o hacer encurtidos."),
            Planta(id: 4, nombre: "cantaloupe", imagen: "", descripción: "El cantaloupe es un tipo de melón dulce con un alto contenido de agua.", uso: "Comido fresco como fruta, en ensaladas o batidos."),
            Planta(id: 5, nombre: "cassava", imagen: "", descripción: "La yuca (cassava) es una raíz rica en carbohidratos, común en dietas de países tropicales.", uso: "Usada para hacer harina de tapioca, sémola y platos tradicionales."),
            Planta(id: 6, nombre: "coconut", imagen: "", descripción: "El coco es una fruta tropical con un interior comestible y agua de coco refrescante.", uso: "Utilizado en la cocina, para extraer aceite y en bebidas."),
            Planta(id: 7, nombre: "corn", imagen: "", descripción: "El maíz es un cereal ampliamente cultivado con múltiples usos en la alimentación humana y animal.", uso: "Se consume hervido, asado, en tortillas y como harina."),
            Planta(id: 8, nombre: "cucumber", imagen: "", descripción: "El pepino es una hortaliza refrescante con alto contenido de agua.", uso: "Comido en ensaladas o como snack, y usado en productos de belleza."),
            Planta(id: 9, nombre: "curcuma", imagen: "", descripción: "La cúrcuma es una raíz utilizada como especia y en medicina tradicional.", uso: "Usada en la cocina para dar color y sabor, y en la medicina como antiinflamatorio."),
            Planta(id: 10, nombre: "eggplant", imagen: "", descripción: "La berenjena es una verdura con piel morada y un interior esponjoso.", uso: "Utilizada en guisos, asados o frita en diversos platillos."),
            Planta(id: 11, nombre: "galangal", imagen: "", descripción: "El galangal es una raíz similar al jengibre, pero con un sabor más picante.", uso: "Se usa en la cocina asiática como especia en sopas y curry."),
            Planta(id: 12, nombre: "ginger", imagen: "", descripción: "El jengibre es una raíz conocida por su sabor picante y sus propiedades medicinales.", uso: "Usado en la cocina y para tratar problemas digestivos."),
            Planta(id: 13, nombre: "guava", imagen: "", descripción: "La guayaba es una fruta tropical dulce con pulpa rosada o blanca.", uso: "Se come fresca, en jugos, mermeladas o dulces."),
            Planta(id: 14, nombre: "kale", imagen: "", descripción: "La col rizada (kale) es un vegetal de hoja verde rico en nutrientes.", uso: "Se consume en ensaladas, batidos o salteado."),
            Planta(id: 15, nombre: "long beans", imagen: "", descripción: "Los frijoles largos son una variedad de frijoles verdes con vainas largas y delgadas.", uso: "Utilizados en la cocina asiática en salteados y ensaladas."),
            Planta(id: 16, nombre: "mango", imagen: "", descripción: "El mango es una fruta tropical dulce y jugosa, rica en vitaminas.", uso: "Se come fresco, en batidos, postres o como salsa."),
            Planta(id: 17, nombre: "melon", imagen: "", descripción: "El melón es una fruta dulce con un alto contenido de agua.", uso: "Consumido como fruta fresca o en jugos."),
            Planta(id: 18, nombre: "orange", imagen: "", descripción: "La naranja es una fruta cítrica popular por su jugo y contenido de vitamina C.", uso: "Consumida fresca, en jugos o en la cocina."),
            Planta(id: 19, nombre: "paddy", imagen: "", descripción: "El arroz (paddy) es un grano básico cultivado en regiones húmedas.", uso: "Usado como alimento básico en muchas culturas."),
            Planta(id: 20, nombre: "papaya", imagen: "", descripción: "La papaya es una fruta tropical con pulpa anaranjada y dulce.", uso: "Se come fresca, en ensaladas o jugos."),
            Planta(id: 21, nombre: "peper chili", imagen: "", descripción: "El chile picante es una fruta utilizada para dar sabor picante a los alimentos.", uso: "Usado en la cocina para salsas, encurtidos o como especia."),
            Planta(id: 22, nombre: "pineapple", imagen: "", descripción: "La piña es una fruta tropical con sabor agridulce.", uso: "Consumida fresca, en jugos, postres o platos salados."),
            Planta(id: 23, nombre: "pomelo", imagen: "", descripción: "El pomelo es una fruta cítrica grande con un sabor amargo-dulce.", uso: "Se consume fresco o en jugos."),
            Planta(id: 24, nombre: "shallot", imagen: "", descripción: "El chalote es una variedad de cebolla con un sabor más suave.", uso: "Usado en la cocina para salsas, aderezos y guisos."),
            Planta(id: 25, nombre: "soybeans", imagen: "", descripción: "La soya es una legumbre rica en proteínas.", uso: "Utilizada para hacer tofu, leche de soya y otros productos alimenticios."),
            Planta(id: 26, nombre: "spinach", imagen: "", descripción: "La espinaca es una verdura de hoja verde rica en nutrientes.", uso: "Se consume en ensaladas, batidos o cocinada."),
            Planta(id: 27, nombre: "sweet potatoes", imagen: "", descripción: "El camote (sweet potatoes) es una raíz dulce y rica en nutrientes.", uso: "Usado en postres, guisos o como puré."),
            Planta(id: 28, nombre: "tobacco", imagen: "", descripción: "El tabaco es una planta cultivada principalmente para producir productos de fumar.", uso: "Usado en la producción de cigarrillos y otros productos de tabaco."),
            Planta(id: 29, nombre: "waterapple", imagen: "", descripción: "El waterapple es una fruta tropical con alto contenido de agua y un sabor ligeramente dulce.", uso: "Se consume fresca o en ensaladas."),
            Planta(id: 30, nombre: "watermelon", imagen: "", descripción: "La sandía es una fruta grande y jugosa con alto contenido de agua.", uso: "Consumida fresca, en jugos o ensaladas.")
        ]

        // Agregar nuevos datos
        for planta in plantas {
            context.insert(planta)
        }
    }
}
