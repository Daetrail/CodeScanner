# Viewfinder Overlay and Blur Customization Guide

This guide explains how to customize the appearance of the area outside the viewfinder when using CodeScanner with `showViewfinder: true`.

## Features

The CodeScanner package supports three ways to customize the area outside the viewfinder:

1. **Colored Overlay** - Apply a semi-transparent colored layer
2. **Blur Effect** - Apply a native iOS blur effect
3. **Combined Effect** - Use both blur and colored overlay together

## Parameters

### Color Overlay Parameters

- **`viewfinderOverlayColor: UIColor`** (default: `.black`)
  - The color to use for the overlay
  - Can be any UIColor, including system colors and custom colors
  
- **`viewfinderOverlayOpacity: CGFloat`** (default: `0.5`)
  - The opacity of the colored overlay (0.0 to 1.0)
  - 0.0 = fully transparent (invisible)
  - 1.0 = fully opaque
  - Set to 0.0 if you only want blur without color

### Blur Parameters

- **`viewfinderBlurStyle: UIBlurEffect.Style?`** (default: `nil`)
  - The blur style to apply. Options include:
    - `.regular` - Standard blur
    - `.light` - Light blur (good for bright environments)
    - `.dark` - Dark blur (good for dark environments)
    - `.extraLight` - Extra light blur
    - `.prominent` - Prominent blur
    - `.systemMaterial` - System material blur
    - And more iOS system blur styles
  - Set to `nil` to disable blur (default behavior)

- **`viewfinderBlurIntensity: CGFloat`** (default: `1.0`)
  - Controls the blur intensity via alpha (0.0 to 1.0)
  - 1.0 = full blur intensity
  - 0.5 = 50% blur intensity (more subtle)
  - Only applies when `viewfinderBlurStyle` is not nil

## Usage Examples

### Example 1: Default Colored Overlay (Backward Compatible)

```swift
CodeScannerView(
    codeTypes: [.qr],
    showViewfinder: true,
    completion: { result in
        // Handle result
    }
)
```

This uses the default black overlay at 50% opacity. This is the same behavior as before the blur feature was added.

### Example 2: Custom Color Overlay

```swift
// Dark blue overlay at 70% opacity
CodeScannerView(
    codeTypes: [.qr],
    showViewfinder: true,
    viewfinderOverlayColor: UIColor(red: 0.0, green: 0.0, blue: 0.3, alpha: 1.0),
    viewfinderOverlayOpacity: 0.7,
    completion: { result in
        // Handle result
    }
)

// Red overlay at 30% opacity (lighter effect)
CodeScannerView(
    codeTypes: [.qr],
    showViewfinder: true,
    viewfinderOverlayColor: .red,
    viewfinderOverlayOpacity: 0.3,
    completion: { result in
        // Handle result
    }
)
```

### Example 3: Blur Only (No Color Overlay)

```swift
// Dark blur effect
CodeScannerView(
    codeTypes: [.qr],
    showViewfinder: true,
    viewfinderOverlayColor: .clear,
    viewfinderOverlayOpacity: 0.0,
    viewfinderBlurStyle: .dark,
    viewfinderBlurIntensity: 1.0,
    completion: { result in
        // Handle result
    }
)

// Light blur effect (good for bright environments)
CodeScannerView(
    codeTypes: [.qr],
    showViewfinder: true,
    viewfinderOverlayColor: .clear,
    viewfinderOverlayOpacity: 0.0,
    viewfinderBlurStyle: .light,
    viewfinderBlurIntensity: 1.0,
    completion: { result in
        // Handle result
    }
)
```

### Example 4: Combining Blur and Color Overlay

```swift
// Dark blur with blue tint - sophisticated layered effect
CodeScannerView(
    codeTypes: [.qr],
    showViewfinder: true,
    viewfinderOverlayColor: .systemBlue,
    viewfinderOverlayOpacity: 0.3,
    viewfinderBlurStyle: .dark,
    viewfinderBlurIntensity: 0.8,
    completion: { result in
        // Handle result
    }
)

// Regular blur with subtle dark overlay
CodeScannerView(
    codeTypes: [.qr],
    showViewfinder: true,
    viewfinderOverlayColor: .black,
    viewfinderOverlayOpacity: 0.2,
    viewfinderBlurStyle: .regular,
    viewfinderBlurIntensity: 0.6,
    completion: { result in
        // Handle result
    }
)
```

### Example 5: Subtle Blur Effect

```swift
// Reduced blur intensity for a more subtle effect
CodeScannerView(
    codeTypes: [.qr],
    showViewfinder: true,
    viewfinderOverlayColor: .clear,
    viewfinderOverlayOpacity: 0.0,
    viewfinderBlurStyle: .regular,
    viewfinderBlurIntensity: 0.5,  // 50% intensity
    completion: { result in
        // Handle result
    }
)
```

## Design Recommendations

### For Dark Environments
- Use `.dark` blur style with 0.8-1.0 intensity
- Or use dark overlay colors (black, dark gray) at 0.4-0.6 opacity

### For Bright Environments
- Use `.light` or `.extraLight` blur styles
- Or use lighter overlay colors at reduced opacity

### For Modern, Clean Look
- Use blur without color overlay
- Or combine subtle blur with a branded color overlay (low opacity)

### For Maximum Focus on Viewfinder
- Use higher opacity overlays (0.6-0.8)
- Or combine medium blur with darker overlay colors

## Technical Details

### How It Works

1. **Blur View Layer** - A `UIVisualEffectView` is added first (if blur is enabled)
2. **Colored Overlay Layer** - A `UIView` with shaped layer is added on top
3. **Viewfinder Cutout** - Both layers use a mask with a rounded rectangle cutout
4. **Auto-Updates** - The mask automatically updates on rotation and layout changes

### Corner Radius

The viewfinder cutout has a fixed corner radius of 20 points. This creates smooth, rounded corners that match modern iOS design patterns.

### Performance

Both blur and colored overlays are lightweight and shouldn't impact scanning performance. The blur uses native `UIBlurEffect` which is GPU-accelerated.

### Backward Compatibility

All new parameters have default values:
- `viewfinderOverlayColor: .black`
- `viewfinderOverlayOpacity: 0.5`
- `viewfinderBlurStyle: nil` (no blur)
- `viewfinderBlurIntensity: 1.0`

Existing code will continue to work without changes, showing the default black overlay at 50% opacity.

## Complete Parameter Reference

```swift
CodeScannerView(
    codeTypes: [AVMetadataObject.ObjectType],
    scanMode: ScanMode = .once,
    manualSelect: Bool = false,
    scanInterval: Double = 2.0,
    zoomFactor: CGFloat? = nil,
    showViewfinder: Bool = false,
    useViewfinderAsRectOfInterest: Bool = false,
    viewfinderOverlayColor: UIColor = .black,           // NEW
    viewfinderOverlayOpacity: CGFloat = 0.5,            // NEW
    viewfinderBlurStyle: UIBlurEffect.Style? = nil,     // NEW
    viewfinderBlurIntensity: CGFloat = 1.0,             // NEW
    requiresPhotoOutput: Bool = true,
    simulatedData: String = "",
    shouldVibrateOnSuccess: Bool = true,
    isTorchOn: Bool = false,
    isPaused: Bool = false,
    isGalleryPresented: Binding<Bool> = .constant(false),
    videoCaptureDevice: AVCaptureDevice? = AVCaptureDevice.bestForVideo,
    completion: @escaping (Result<ScanResult, ScanError>) -> Void
)
```

## Tips

1. **Preview in Real Environment** - Blur and overlay effects look different in different lighting conditions
2. **Brand Consistency** - Use your app's accent color for the overlay to maintain visual consistency
3. **Accessibility** - Higher opacity overlays provide better focus but may reduce visibility of surroundings
4. **Experiment** - Try combining different blur styles with colored overlays to find the best look for your app

## See Also

- `ViewfinderOverlayExample.swift` - Interactive examples of all configurations
- `ScannerViewfinderStyle` - For customizing the viewfinder itself
