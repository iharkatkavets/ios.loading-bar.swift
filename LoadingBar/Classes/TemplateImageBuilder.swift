//
//  ImageBuilder.swift
//  LoadingBar
//
//  Created by Ihar Katkavets on 28/07/2023.
//

import Foundation

final class TemplateImageBuilder {
    var size: CGSize?
    var stripColor0: UIColor = .red
    var stripColor1: UIColor = .blue
    var scale: CGFloat = 1
    
    public func withSize(_ size: CGSize) -> TemplateImageBuilder {
        self.size = size
        return self
    }
    
    public func withStripColor0(_ color: UIColor) -> TemplateImageBuilder {
        stripColor0 = color
        return self
    }
    
    public func withStripColor1(_ color: UIColor) -> TemplateImageBuilder {
        stripColor1 = color
        return self
    }
    
    public func withScale(_ scale: CGFloat) -> TemplateImageBuilder {
        self.scale = scale
        return self
    }
    
    public func build() -> CGImage? {
        guard let size else { return nil }
        let scaledSize = CGSize(width: scale*size.width, height: scale*size.height)
        let doubleSize = CGSize(width: 2*scaledSize.width, height: scaledSize.height)
        guard let bitmap = createContext(doubleSize) else { return nil }
        
        for i in 0..<2 {
            let x: CGFloat = CGFloat(i)*scaledSize.width
            let y: CGFloat = 0
            let width = scaledSize.width
            let height = scaledSize.height
            let rect = CGRect(x: x, y: y, width: width, height: height)
            drawTemplate(bitmap, rect)
        }
        
        let image = bitmap.makeImage()
        return image
    }
    
    private func fillBackground(_ bitmap: CGContext, _ rect: CGRect) {
        bitmap.addRect(rect)
        bitmap.setFillColor(stripColor1.cgColor)
        bitmap.fill(rect)
    }
    
    private func drawTemplate(_ bitmap: CGContext, _ rect: CGRect) {
        bitmap.beginPath()
        bitmap.addRect(rect)
        bitmap.closePath()
        bitmap.setFillColor(stripColor1.cgColor)
        bitmap.fill(rect)
        
        bitmap.beginPath()
        let x = rect.origin.x
        let y = rect.origin.y
        let width = rect.size.width/2
        let height = rect.size.height
        bitmap.setFillColor(stripColor0.cgColor)
        bitmap.move(to: CGPoint(x: x, y: y))
        bitmap.addLine(to: CGPoint(x: x+height, y: y+height))
        bitmap.addLine(to: CGPoint(x: x+width+height, y: y+height))
        bitmap.addLine(to: CGPoint(x: x+width, y: y))
        bitmap.addLine(to: CGPoint(x: x, y: y))
        bitmap.closePath()
        bitmap.fillPath()
    }
    
    private func createContext(_ size: CGSize) -> CGContext? {
        let width = Int(size.width)
        let height = Int(size.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let rawData: UnsafeMutableRawPointer? = nil
        let bitsPerComponent = 8
        let bitmap = CGContext(data: rawData,
                               width: width,
                               height: height,
                               bitsPerComponent: bitsPerComponent,
                               bytesPerRow: bytesPerRow,
                               space: colorSpace,
                               bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGImageByteOrderInfo.order32Big.rawValue)
        return bitmap
    }
    
}
