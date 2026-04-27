# 🔍 ATOCR (AyanTech OCR)

**ATOCR** is a Swift Package designed for **image preprocessing and OCR-ready workflows**.
It helps you **optimize images (compression, resizing, formatting)** before sending them to OCR engines or backend services.

Built for **iOS (UIKit & SwiftUI)** with a focus on simplicity, performance, and scalability.

---

## ✨ Features

* 🖼 Image compression (size-based)
* 📦 Convert images to Base64 (OCR-ready)
* ⚙️ Configurable compression settings
* 📱 UIKit & SwiftUI support
* 🧱 Modular architecture (SPM)
* 🔌 Ready to integrate with OCR APIs

---

## 📥 Installation

### Swift Package Manager

Add via Xcode:

```
File → Add Packages…
```

Or manually:

```swift
.package(url: "https://github.com/...", from: "1.0.0")
```

---

## 🚀 Usage

### Basic Compression

```swift
let compressor = ATOCRImageCompressor()
let data = compressor.compress(image)
```

---

### Convert to Base64 (Recommended for OCR APIs)

```swift
let base64 = compressor.compressBase64(image)
```

---

### Custom Configuration

```swift
let config = ATOCRImageCompressor.Config(
    maxSizeMB: 1.0,
    minQuality: 0.2,
    resizeStep: 0.7
)

let compressor = ATOCRImageCompressor(config: config)
let data = compressor.compress(image)
```

---

## 📱 UIKit Example

```swift
let compressor = ATOCRImageCompressor()

camera.openCamera(from: self) { image in
    guard let image else { return }
    let base64 = compressor.compressBase64(image)
}
```

---


## ⚙️ Configuration

| Parameter    | Description                      | Default |
| ------------ | -------------------------------- | ------- |
| `maxSizeMB`  | Maximum output size              | 6.0 MB  |
| `minQuality` | Minimum JPEG compression quality | 0.1     |
| `resizeStep` | Resize scale per iteration       | 0.8     |

---

## 🧠 Why ATOCR?

OCR systems work best with:

* optimized image size
* reduced noise
* consistent formats

👉 ATOCR prepares images before sending them to OCR services, improving:

* speed ⚡
* accuracy 🎯
* bandwidth usage 📉

---

## 🔒 Requirements

* iOS 13+
