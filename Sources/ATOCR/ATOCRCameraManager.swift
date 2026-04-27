//
//  ATOCRCameraManager.swift
//  ATOCR
//
//  Created by Amir on 4/27/26.
//
import UIKit

public final class ATOCRCameraManager: NSObject {

    private var completion: ((UIImage?) -> Void)?

    public override init() {}

    @MainActor public func openCamera(from viewController: UIViewController,
                                      completion: @escaping (UIImage?) -> Void) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            completion(nil)
            return
        }

        self.completion = completion
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        viewController.present(picker, animated: true)
    }
}

// MARK: - Delegate
extension ATOCRCameraManager: UIImagePickerControllerDelegate,
                              UINavigationControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true)
        completion?(image)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        completion?(nil)
    }
}
