# ATOCR

A lightweight OCR toolkit for iOS built with UIKit.

ATOCR provides reusable tools for document scanning workflows, including camera capture, image compression, and a simple `OCRUseCase` for processing OCR requests and retrieving results.

## Features

* 📷 Camera capture manager
* 🖼 Image compression before upload
* 🔄 Automatic OCR result polling
* ⚡ Combine-based OCR workflow
* 🎯 UIKit-first design
* 📱 iOS 13+ support

---

## Requirements

* iOS 13+
* Swift 5.9+
* UIKit
* Combine

---

## Installation

### Swift Package Manager

Add the package dependency:

```swift
dependencies: [
    .package(
        url: "https://github.com/AyanTech/ATOCR-iOS",
        from: "1.0.0"
    )
]
```

Or in Xcode:

**File → Add Packages**

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

## OCRUseCase

`OCRUseCase` is the main interface for executing the OCR workflow.

It handles OCR result processing and automatically polls the OCR service while the result is in a `pending` state.

The polling logic is handled internally, so consumers do not need to implement timers or recursive requests.

### Execute OCR

```swift
let cancellable = useCase.execute(
    url: url,
    token: token,
    input: input
)
.sink(
    receiveCompletion: { completion in

        switch completion {

        case .finished:
            break

        case .failure(let error):
            print(error)
        }
    },
    receiveValue: { result in

        print(result)
    }
)
```

### Result Type

The OCR result is returned as:

```swift
AnyPublisher<OCRResultModel, ATErrorV2>
```

Handle the result using Combine:

```swift
cancellable = useCase.execute(
    url: url,
    token: token,
    input: input
)
.receive(on: DispatchQueue.main)
.sink(
    receiveCompletion: { completion in

        if case .failure(let error) = completion {
            print("OCR Error:", error)
        }
    },
    receiveValue: { result in

        print("OCR Result:", result)
    }
)
```

---

## OCR Result Polling

When the OCR service returns a `pending` status, `OCRUseCase` automatically waits for the specified `NextCallInterval` and requests the result again.

```text
Execute OCR Request
        ↓
Receive OCR Response
        ↓
    Is Pending?
      /     \
    Yes      No
     ↓        ↓
 Wait        Return Result
     ↓
 Request Again
     ↓
    Repeat
```

The consumer does not need to manage polling, delays, or repeated network requests.

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
Execute OCRUseCase
      ↓
Wait for OCR Result
      ↓
Poll While Pending
      ↓
Receive OCRResultModel
```

---

## Camera Permission

Add the following key to your `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required for OCR scanning.</string>
```

---

## Dependencies

* AyanTechNetworkingLibrary
* Combine

---

## License

MIT

```
