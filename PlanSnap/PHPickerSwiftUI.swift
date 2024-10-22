//
//  PHPickerSwiftUI.swift
//  TestC24Sep
//
//  Created by Cristina Gonzalez Cordova on 24/09/24.
//  Referencia:
//  https://mobileappsacademy.medium.com/phpicker-in-swiftui-a56639dcf8f5
//  Ajustado y modificado por: Cristina Gonzalez
//
import SwiftUI
import PhotosUI

struct PHPickerSwiftUI: UIViewControllerRepresentable {
   
    @Binding var selectedImage: UIImage?
    
    @Environment(\.presentationMode) var isPresented
    private var config: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 20
        config.preferredAssetRepresentationMode = .current
        return config
    }
        
    func makeUIViewController(context: Context) ->  PHPickerViewController {
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // No se modifica nada en esta vista
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: PHPickerSwiftUI
        
        init(parent: PHPickerSwiftUI) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                
            if let result = results.first{
                result .itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    if let uiImage = object as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.selectedImage = uiImage
                        }
                    }
                }
            }
                
            self.parent.isPresented.wrappedValue.dismiss()
        }
    }
    
}
