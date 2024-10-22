//
//  CameraPickerView.swift
//  TestC24Sep
//
//  Created by Cristina Gonzalez Cordova on 24/09/24.
//  https://medium.com/swlh/how-to-open-the-camera-and-photo-library-in-swiftui-9693f9d4586b
//  Ajustado y modificado por: Cristina Gonzalez (2024)

import UIKit
import SwiftUI

//UIViewControllerRepresentable nos ayuda a usar el protocolo de UIKit en SwiftUI el cual requiere implementar 2 funciones: makeUIViewController y updateUIViewControlller
struct CameraPickerView: UIViewControllerRepresentable{
    
    @Binding var selectedImage: UIImage?
    
    @Environment(\.presentationMode) var isPresented
    // Especificar que la fuente es la Camara
   // private var sourceType: UIImagePickerController.SourceType = .camera
           
    // Regresa un UIImagePickerController (func requierida por el protocolo)
    func makeUIViewController(context: Context) -> UIImagePickerController {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = context.coordinator //confirma el delegado
            return imagePicker
    }
    
    // Se utiliza para configurar la vista y responde a cualquier cambio. (func requierida por el protocolo)
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
    
    // Conecta la clase Coordinator (delegado) con la estructura
    func makeCoordinator() -> CoordinatorCamera {
           return CoordinatorCamera(picker: self)
    }
}

    // Esta clase se utiliza para obtener los datos de imagen capturados desde la camara o biblioteca de fotos. Actua como un puente entre UIKit y SwiftUI.
    class CoordinatorCamera: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // Esta es la una instancia estructura que creamos arriba
        var picker: CameraPickerView
        
        init(picker: CameraPickerView) {
            self.picker = picker
        }
        
        // func para cumplir con el protocolo UIImagePickerControllerDelegate de la clase
        // Se activará cuando el usuario capture una foto usando la camara o seleccione una imagen de la biblioteca de fotos.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else { return }
            self.picker.selectedImage = selectedImage
            self.picker.isPresented.wrappedValue.dismiss()
        }
    }

