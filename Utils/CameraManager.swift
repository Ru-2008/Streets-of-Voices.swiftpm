import AVFoundation
import SwiftUI

@MainActor
class CameraManager: ObservableObject {
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var currentCameraPosition: AVCaptureDevice.Position = .back
    private var scanTimer: Timer?
    
    @Published var isScanning = false
    @Published var scanProgress: CGFloat = 0.0
    @Published var scanComplete = false
    @Published var showPerspectiveDetected = false
    
    func setupCamera(for view: UIView, cameraPosition: AVCaptureDevice.Position = .back) {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .medium
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition) else { return }
        guard let input = try? AVCaptureDeviceInput(device: camera) else { return }
        
        if captureSession?.canAddInput(input) == true {
            captureSession?.addInput(input)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = view.bounds
        
        view.layer.addSublayer(previewLayer!)
        captureSession?.startRunning()
        
        currentCameraPosition = cameraPosition
    }
    
    func switchCamera(for view: UIView) {
        captureSession?.stopRunning()
        
        let newPosition: AVCaptureDevice.Position = currentCameraPosition == .back ? .front : .back
        setupCamera(for: view, cameraPosition: newPosition)
    }
    
    func startScan() {
        isScanning = true
        scanProgress = 0.0
        scanComplete = false
        showPerspectiveDetected = false
        
        // Invalidate any existing timer
        scanTimer?.invalidate()
        
        // Use weak reference to avoid retain cycles
        weak var weakSelf = self
        
        scanTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            guard let strongSelf = weakSelf else { return }
            
            DispatchQueue.main.async {
                strongSelf.scanProgress += 0.01
                if strongSelf.scanProgress >= 1.0 {
                    strongSelf.scanTimer?.invalidate()
                    strongSelf.scanTimer = nil
                    strongSelf.scanComplete = true
                    strongSelf.showPerspectiveDetected = true
                    
                    // Show "Perspective detected" for 1 second, then complete
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        strongSelf.isScanning = false
                    }
                }
            }
        }
    }
    
    func stopCamera() {
        scanTimer?.invalidate()
        scanTimer = nil
        captureSession?.stopRunning()
        previewLayer?.removeFromSuperlayer()
        captureSession = nil
        previewLayer = nil
    }
}