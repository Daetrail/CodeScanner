//
//  ViewfinderOverlayExample.swift
//  CodeScanner
//
//  Example demonstrating how to use custom overlay colors, opacity, and blur
//

#if os(iOS)
import SwiftUI

@available(macCatalyst 14.0, *)
struct ViewfinderOverlayExample: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var selectedExample: ExampleType = .defaultOverlay
    
    enum ExampleType: String, CaseIterable {
        case defaultOverlay = "Default (Black, 50%)"
        case darkBlue = "Dark Blue (70%)"
        case redLight = "Red (30%)"
        case blurDark = "Dark Blur"
        case blurLight = "Light Blur"
        case blurExtraLight = "Extra Light Blur"
        case blurAndColor = "Blur + Color Overlay"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Viewfinder Overlay Examples")
                .font(.title)
                .padding()
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(ExampleType.allCases, id: \.self) { example in
                        if #available(iOS 15.0, macCatalyst 15.0, *) {
                            Button(example.rawValue) {
                                selectedExample = example
                                isPresentingScanner = true
                            }
                            .buttonStyle(.bordered)
                        } else {
                            Button(example.rawValue) {
                                selectedExample = example
                                isPresentingScanner = true
                            }
                            .buttonStyle(.automatic)
                        }
                    }
                }
                .padding()
            }
            
            if let code = scannedCode {
                Text("Scanned: \(code)")
                    .padding()
            }
        }
        .sheet(isPresented: $isPresentingScanner) {
            scannerView(for: selectedExample)
        }
    }
    
    @ViewBuilder
    func scannerView(for example: ExampleType) -> some View {
        switch example {
        case .defaultOverlay:
            CodeScannerView(
                codeTypes: [.qr],
                showViewfinder: true,
                viewfinderOverlayColor: .black,
                viewfinderOverlayOpacity: 0.5
            ) { handleResult($0) }
            
        case .darkBlue:
            CodeScannerView(
                codeTypes: [.qr],
                showViewfinder: true,
                viewfinderOverlayColor: UIColor(red: 0.0, green: 0.0, blue: 0.3, alpha: 1.0),
                viewfinderOverlayOpacity: 0.7
            ) { handleResult($0) }
            
        case .redLight:
            CodeScannerView(
                codeTypes: [.qr],
                showViewfinder: true,
                viewfinderOverlayColor: .red,
                viewfinderOverlayOpacity: 0.3
            ) { handleResult($0) }
            
        case .blurDark:
            CodeScannerView(
                codeTypes: [.qr],
                showViewfinder: true,
                viewfinderOverlayColor: .clear,
                viewfinderOverlayOpacity: 0.0,
                viewfinderBlurStyle: .dark,
                viewfinderBlurIntensity: 1.0
            ) { handleResult($0) }
            
        case .blurLight:
            CodeScannerView(
                codeTypes: [.qr],
                showViewfinder: true,
                viewfinderOverlayColor: .clear,
                viewfinderOverlayOpacity: 0.0,
                viewfinderBlurStyle: .light,
                viewfinderBlurIntensity: 1.0
            ) { handleResult($0) }
            
        case .blurExtraLight:
            CodeScannerView(
                codeTypes: [.qr],
                showViewfinder: true,
                viewfinderOverlayColor: .clear,
                viewfinderOverlayOpacity: 0.0,
                viewfinderBlurStyle: .extraLight,
                viewfinderBlurIntensity: 1.0
            ) { handleResult($0) }
            
        case .blurAndColor:
            CodeScannerView(
                codeTypes: [.qr],
                showViewfinder: true,
                viewfinderOverlayColor: .systemBlue,
                viewfinderOverlayOpacity: 0.3,
                viewfinderBlurStyle: .dark,
                viewfinderBlurIntensity: 0.8
            ) { handleResult($0) }
        }
    }
    
    func handleResult(_ result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let scanResult):
            scannedCode = scanResult.string
            isPresentingScanner = false
        case .failure(let error):
            print("Scanning failed: \(error)")
        }
    }
}

// MARK: - Individual Examples

@available(macCatalyst 14.0, *)
struct DarkBlurExample: View {
    @State private var scannedCode: String?
    
    var body: some View {
        // Example with dark blur effect
        CodeScannerView(
            codeTypes: [.qr, .ean13],
            showViewfinder: true,
            viewfinderOverlayColor: .clear,
            viewfinderOverlayOpacity: 0.0,
            viewfinderBlurStyle: .dark,
            viewfinderBlurIntensity: 1.0
        ) { result in
            switch result {
            case .success(let scanResult):
                scannedCode = scanResult.string
            case .failure(let error):
                print("Scanning failed: \(error)")
            }
        }
    }
}

@available(macCatalyst 14.0, *)
struct LightBlurExample: View {
    @State private var scannedCode: String?
    
    var body: some View {
        // Example with light blur effect (good for bright environments)
        CodeScannerView(
            codeTypes: [.qr],
            showViewfinder: true,
            viewfinderOverlayColor: .clear,
            viewfinderOverlayOpacity: 0.0,
            viewfinderBlurStyle: .light,
            viewfinderBlurIntensity: 1.0
        ) { result in
            switch result {
            case .success(let scanResult):
                scannedCode = scanResult.string
            case .failure(let error):
                print("Scanning failed: \(error)")
            }
        }
    }
}

@available(macCatalyst 14.0, *)
struct ExtraLightBlurExample: View {
    @State private var scannedCode: String?
    
    var body: some View {
        // Example with extra light blur effect
        CodeScannerView(
            codeTypes: [.qr],
            showViewfinder: true,
            viewfinderOverlayColor: .clear,
            viewfinderOverlayOpacity: 0.0,
            viewfinderBlurStyle: .extraLight,
            viewfinderBlurIntensity: 1.0
        ) { result in
            switch result {
            case .success(let scanResult):
                scannedCode = scanResult.string
            case .failure(let error):
                print("Scanning failed: \(error)")
            }
        }
    }
}

@available(macCatalyst 14.0, *)
struct BlurWithColorOverlayExample: View {
    @State private var scannedCode: String?
    
    var body: some View {
        // Example combining blur with a colored overlay
        // This creates a sophisticated, layered effect
        CodeScannerView(
            codeTypes: [.qr],
            showViewfinder: true,
            viewfinderOverlayColor: .systemBlue,
            viewfinderOverlayOpacity: 0.3,
            viewfinderBlurStyle: .dark,
            viewfinderBlurIntensity: 0.8
        ) { result in
            switch result {
            case .success(let scanResult):
                scannedCode = scanResult.string
            case .failure(let error):
                print("Scanning failed: \(error)")
            }
        }
    }
}

@available(macCatalyst 14.0, *)
struct SubtleBlurExample: View {
    @State private var scannedCode: String?
    
    var body: some View {
        // Example with reduced blur intensity for a subtle effect
        CodeScannerView(
            codeTypes: [.qr],
            showViewfinder: true,
            viewfinderOverlayColor: .clear,
            viewfinderOverlayOpacity: 0.0,
            viewfinderBlurStyle: .regular,
            viewfinderBlurIntensity: 0.5  // 50% blur intensity
        ) { result in
            switch result {
            case .success(let scanResult):
                scannedCode = scanResult.string
            case .failure(let error):
                print("Scanning failed: \(error)")
            }
        }
    }
}

#if DEBUG
@available(macCatalyst 14.0, *)
struct ViewfinderOverlayExample_Previews: PreviewProvider {
    static var previews: some View {
        ViewfinderOverlayExample()
    }
}
#endif

#endif

