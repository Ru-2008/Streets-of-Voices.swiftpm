import SwiftUI
import AVFoundation

struct ScannerView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    @StateObject private var cameraManager = CameraManager()
    @State private var cameraView = CameraViewRepresentable()
    
    let location: Location
    
    var body: some View {
        ZStack {
            // Camera preview
            cameraView
                .onAppear {
                    cameraManager.setupCamera(for: cameraView.uiView)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        cameraManager.startScan()
                    }
                }
                .onDisappear {
                    cameraManager.stopCamera()
                }
            
            // Overlay UI
            VStack {
                Spacer()
                
                // Scan frame
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 250, height: 250)
                        .opacity(0.7)
                    
                    // Animated scan line
                    if cameraManager.isScanning {
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 2)
                                .offset(y: (geometry.size.height - 2) * cameraManager.scanProgress - geometry.size.height/2)
                                .opacity(0.8)
                        }
                    }
                }
                .frame(width: 250, height: 250)
                
                Spacer()
                
                // Status messages
                VStack(spacing: 16) {
                    if cameraManager.isScanning && !cameraManager.showPerspectiveDetected {
                        Text("Scanning surroundings...")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                    }
                    
                    if cameraManager.showPerspectiveDetected {
                        Text("Perspective detected")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(12)
                    }
                }
                
                Spacer()
                
                // Controls
                HStack {
                    Button(action: {
                        cameraManager.switchCamera(for: cameraView.uiView)
                    }) {
                        Image(systemName: "camera.rotate")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        appState.showScanner = false
                        dismiss()
                    }) {
                        Text("Cancel")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .onReceive(cameraManager.$isScanning) { isScanning in
            if !isScanning && cameraManager.scanComplete {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    appState.showScanner = false
                    appState.scannedLocationID = location.id
                    dismiss()
                }
            }
        }
    }
}

struct CameraViewRepresentable: UIViewRepresentable {
    let uiView = UIView()
    
    func makeUIView(context: Context) -> UIView {
        uiView.backgroundColor = UIColor.black
        return uiView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}