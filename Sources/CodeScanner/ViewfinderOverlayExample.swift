//
//  ViewfinderOverlayExample.swift
//  CodeScanner
//
//  Example demonstrating how to use custom overlay colors and opacity
//

#if os(iOS)
import SwiftUI

@available(macCatalyst 14.0, *)
struct ViewfinderOverlayExample: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Viewfinder Overlay Examples")
                .font(.title)
                .padding()
            
            // Example 1: Default black overlay with 50% opacity
            Button("Default (Black, 50% opacity)") {
                isPresentingScanner = true
            }
            
            // Example 2: Dark blue overlay with 70% opacity
            Button("Dark Blue (70% opacity)") {
                // Use viewfinderOverlayColor and viewfinderOverlayOpacity
            }
            
            // Example 3: Red overlay with 30% opacity
            Button("Red (30% opacity)") {
                // Use viewfinderOverlayColor and viewfinderOverlayOpacity
            }
            
            if let code = scannedCode {
                Text("Scanned: \(code)")
                    .padding()
            }
        }
        .sheet(isPresented: $isPresentingScanner) {
            // Example 1: Default black with 50% opacity
            CodeScannerView(
                codeTypes: [.qr],
                showViewfinder: true,
                viewfinderOverlayColor: .black,
                viewfinderOverlayOpacity: 0.5
            ) { result in
                switch result {
                case .success(let scanResult):
                    scannedCode = scanResult.string
                    isPresentingScanner = false
                case .failure(let error):
                    print("Scanning failed: \(error)")
                }
            }
        }
    }
}

@available(macCatalyst 14.0, *)
struct DarkBlueOverlayExample: View {
    @State private var scannedCode: String?
    
    var body: some View {
        // Example with dark blue overlay at 70% opacity
        CodeScannerView(
            codeTypes: [.qr, .ean13],
            showViewfinder: true,
            viewfinderOverlayColor: UIColor(red: 0.0, green: 0.0, blue: 0.3, alpha: 1.0),
            viewfinderOverlayOpacity: 0.7
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
struct RedOverlayExample: View {
    @State private var scannedCode: String?
    
    var body: some View {
        // Example with red overlay at 30% opacity (lighter effect)
        CodeScannerView(
            codeTypes: [.qr],
            showViewfinder: true,
            viewfinderOverlayColor: .red,
            viewfinderOverlayOpacity: 0.3
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
struct WhiteOverlayExample: View {
    @State private var scannedCode: String?
    
    var body: some View {
        // Example with white overlay at 80% opacity (good for bright environments)
        CodeScannerView(
            codeTypes: [.qr],
            showViewfinder: true,
            viewfinderOverlayColor: .white,
            viewfinderOverlayOpacity: 0.8
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
