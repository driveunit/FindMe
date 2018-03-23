
//
//  faceExtraction.swift
//  Find_Me
//
//  Created by ramyahar on 3/22/18.
//  Copyright © 2018 ramyahar. All rights reserved.
//

import Foundation
import Vision

@available(OSX 10.13, *)

class FaceDetection {
    
    let path: String
    let facesDir: URL
    var detectAll: Bool = true
    
    init(input: String) {
        path = input
        facesDir = NSURL.fileURL(withPath: "\(input)/faces", isDirectory: true)
    }
    
    init(input: String, output: String, detectAll: Bool = true) {
        path = input
        facesDir = NSURL.fileURL(withPath: output, isDirectory: true)
        self.detectAll = detectAll
    }
    
    func detectFaces() {
        
        do {
            try FileManager.default.createDirectory(at: facesDir, withIntermediateDirectories: true, attributes: nil)
        } catch {
            consoleIO.fail(error.localizedDescription)
        }
        
        guard let files = try? FileManager.default.contentsOfDirectory(atPath: path) else {
            consoleIO.fail("Something went wrong!")
        }
        let imageFiles = files.filter { imageFile in imageFile.contains(".png") || imageFile.contains(".jpg") || imageFile.contains(".jpeg") }
        
        if imageFiles.isEmpty {
            consoleIO.fail("This directory contains no images.")
        }
        
        analyzeImages(imageFiles)
    }
    
    private func analyzeImages(_ images: [String]) {
        var fileCounter = 1
        let maxNumFiles = images.count
        
        images.forEach { imageFile in
            let imageURL = URL(string: path)!.appendingPathComponent(imageFile)
            guard let cgImage = CGImage.getCGImage(from: imageURL) else {
                consoleIO.write("Conversion to CGImage failed", to: .error)
                return
            }
            
            // Start face detection via Vision
            let facesRequest = VNDetectFaceRectanglesRequest { request, error in
                guard error == nil else {
                    consoleIO.write("oh an unexpected error has occurred: \(error!.localizedDescription)", to: .error)
                    return
                }
                self.handleFaces(request, cgImage: cgImage)
            }
            try? VNImageRequestHandler(cgImage: cgImage).perform([facesRequest])
            
            consoleIO.write("\(fileCounter)/\(maxNumFiles) -- \(imageURL.path)", to: .carriage)
            fileCounter += 1
        }
    }
    
    func handleFaces(_ request: VNRequest, cgImage: CGImage) {
        
        guard let observations = request.results as? [VNFaceObservation] else {
            return
        }
        if !detectAll && observations.count > 1 {
            consoleIO.write("Ignored image.")
            return
        }
        observations.forEach { observation in
            guard let image = cgImage.cropImageToFace(observation) else {
                consoleIO.write("Oh your face could not be cropped!!", to: .error)
                return
            }
            
            // Create image file from detected faces
            let data = NSBitmapImageRep.init(cgImage: image).representation(using: .jpeg, properties: [:])
            let faceURL = facesDir.appendingPathComponent("\(observation.uuid).jpg")
            
            try? data?.write(to: faceURL)
        }
    }
}

extension CGImage {
    
    static func getCGImage(from file: URL) -> CGImage? {
        // Extract NSImage from image file
        guard let nsImage = NSImage(contentsOfFile: file.path) else {
            consoleIO.write("Conversion to NSImage failed", to: .error)
            return nil
        }
        
        // Convert NSImage to CGImage
        var imageRect: CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: nsImage.size)
        return nsImage.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
    }
    
    @available(OSX 10.13, *)
    func cropImageToFace(_ face: VNFaceObservation) -> CGImage? {
        let percentage: CGFloat = 0.6
        
        let newWidth = face.boundingBox.width * CGFloat(width)
        let newHeight = face.boundingBox.height * CGFloat(height)
        let x = face.boundingBox.origin.x * CGFloat(width)
        let y = (1 - face.boundingBox.origin.y) * CGFloat(height) - newHeight
        let croppingRect = CGRect(x: x, y: y, width: newWidth, height: newHeight)
        
        let increasedRect = croppingRect.insetBy(dx: newWidth * -percentage, dy: newHeight * -percentage)
        return self.cropping(to: increasedRect)
    }
}

class ConsoleIO {
    
    enum OutputType {
        case error, standard, carriage
    }
    
    func write(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\(message)")
        case .carriage:
            print("\r\(message)                             ", terminator: "")
        case .error:
            fputs("Error: \(message)\n", stderr)
        }
        fflush(stdout)
    }
    
    func fail(_ message: String) -> Never {
        fputs("Failure: \(message)\n", stderr)
        exit(EXIT_FAILURE)
    }
}
