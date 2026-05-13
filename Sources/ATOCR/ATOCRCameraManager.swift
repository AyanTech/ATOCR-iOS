//
//  ATOCRCameraManager.swift
//  ATOCR
//
//  Created by Amir on 4/27/26.
//
import UIKit

// MARK: - Delegate
public protocol ATOCRCameraManagerDelegate: AnyObject {
    func cameraManager(_ manager: ATOCRCameraManager, didCapture image: UIImage?)
}

// MARK: - Manager
public final class ATOCRCameraManager: NSObject {

    public weak var delegate: ATOCRCameraManagerDelegate?

    public override init() {
        super.init()
    }

    @MainActor
    public func openCamera(from viewController: UIViewController) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            delegate?.cameraManager(self, didCapture: nil)
            return
        }

        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self

        viewController.present(picker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ATOCRCameraManager: UIImagePickerControllerDelegate,
                              UINavigationControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage

        picker.dismiss(animated: true) { [weak self] in
            guard let self else { return }
            self.delegate?.cameraManager(self, didCapture: image)
        }
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [weak self] in
            guard let self else { return }
            self.delegate?.cameraManager(self, didCapture: nil)
        }
    }
}
