# ATOCR

A lightweight OCR toolkit for iOS built with UIKit.

ATOCR provides reusable UI components, camera handling,
image compression, and OCR request helpers to simplify
document scanning workflows.

## Features

- 📷 Camera capture manager
- 🧩 Ready-to-use OCR selection view
- 🖼 Image compression before upload
- 🔄 OCR result polling support
- ⚡ Protocol-oriented networking helpers
- 🎯 UIKit-first design

---

## Requirements

- iOS 13+
- Swift 5.9+
- UIKit

---

## Installation

### Swift Package Manager

Add the package dependency:

```swift
dependencies: [
    .package(
        url: "https://github.com/your-username/ATOCR-iOS.git",
        from: "1.0.0"
    )
]
```

Or in Xcode:

**File → Add Packages**

---

## OCRView

`OCRView` is a reusable UIKit component that displays OCR document options in a grid layout.

### Features

- Custom title
- Configurable typography
- Delegate-based selection
- Responsive collection view layout

### Example

```swift
let ocrView = OCRView()

ocrView.title = "Select Document"
ocrView.delegate = self
ocrView.setItems(items)
```

Receive selection:

```swift
extension ViewController: OCRViewDelegate {

    func ocrViewDidSelectItem(
        _ item: OCRCollectionItem
    ) {

    }
}
```

---

## Camera Manager

`ATOCRCameraManager` provides a lightweight wrapper around `UIImagePickerController`.

### Open Camera

```swift
let camera = ATOCRCameraManager()

camera.delegate = self

camera.openCamera(
    from: self,
    guid: "document-id"
)
```

Receive captured image:

```swift
extension ViewController:
    ATOCRCameraManagerDelegate {

    func cameraManager(
        _ manager: ATOCRCameraManager,
        didCapture image: UIImage?,
        guid: String?
    ) {

    }
}
```

---

## Image Compression

Compress images before upload to reduce payload size.

### Default Compression

```swift
let compressor =
    ATOCRImageCompressor()

let data =
    compressor.compress(image)
```

### Base64 Output

```swift
let base64 =
    compressor.compressBase64(image)
```

### Custom Configuration

```swift
let config =
    ATOCRImageCompressor.Config(
        maxSizeMB: 3,
        minCompression: 0.2,
        resizeStep: 0.9
    )

let compressor =
    ATOCRImageCompressor(
        config: config
    )
```

---

## OCR Upload

Implement `UploadNewCardOcrImagePO`
to upload OCR images.

```swift
final class ViewModel:
    UploadNewCardOcrImagePO {

}
```

Start upload:

```swift
uploadNewCardOcrImage(
    url: url,
    input: input,
    token: token
)
```

Handle changes:

```swift
changeHandler = { change in

    switch change {

    case .didSuccess:
        break

    case .didError(let message):
        print(message)

    default:
        break
    }
}
```

---

## OCR Result Polling

Implement `GetCardOcrResultPO`
to receive OCR results.

```swift
final class ViewModel:
    GetCardOcrResultPO {

}
```

Start request:

```swift
getCardOcrResult(
    url: url,
    input: input,
    token: token
)
```

The SDK automatically retries when
OCR status is `pending`.

---

## OCR Flow

```text
Select Document
      ↓
Open Camera
      ↓
Capture Image
      ↓
Compress Image
      ↓
Upload Image
      ↓
Wait for OCR Result
      ↓
Receive OCR Data
```

---

## Camera Permission

Add this key to `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required for OCR scanning.</string>
```

---

## Dependencies

- AyanTechNetworkingLibrary

---

## License

MIT
