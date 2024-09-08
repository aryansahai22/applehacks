import SwiftUI
import UIKit
import AVFoundation

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
            }

            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera

        // Calculate aspect ratio
        let screenSize = UIScreen.main.bounds.size

        // Adjust the camera preview transform to cover the screen
        let scaleFactor = max(screenSize.height / picker.view.bounds.height, screenSize.width / picker.view.bounds.width)
        picker.cameraViewTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)

        picker.showsCameraControls = true  // Keep the default camera controls

        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // Update the UI if needed
    }
}
