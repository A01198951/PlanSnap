//  Camara

import UIKit
import SwiftUI

struct CameraPickerView: UIViewControllerRepresentable{
    
    @Binding var selectedImage: UIImage?
    
    @Environment(\.presentationMode) var isPresented
           
    func makeUIViewController(context: Context) -> UIImagePickerController {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = context.coordinator
            return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
    
    func makeCoordinator() -> CoordinatorCamera {
           return CoordinatorCamera(picker: self)
    }
}

    class CoordinatorCamera: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var picker: CameraPickerView
        
        init(picker: CameraPickerView) {
            self.picker = picker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else { return }
            self.picker.selectedImage = selectedImage
            self.picker.isPresented.wrappedValue.dismiss()
        }
    }

