//
//  ImageBuilder.swift
//  LoadingBar
//
//  Created by Ihar Katkavets on 28/07/2023.
//

import Foundation

final class TemplateImageBuilder {
    var size: CGSize?
    var shapeColor: UIColor = .red
    var backgroundColor: UIColor = .blue
    var scale: CGFloat = 1
    
    public func withSize(_ size: CGSize) -> TemplateImageBuilder {
        self.size = size
        return self
    }
    
    public func withShapeColor(_ color: UIColor) -> TemplateImageBuilder {
        shapeColor = color
        return self
    }
    
    public func withBackgroundColor(_ color: UIColor) -> TemplateImageBuilder {
        backgroundColor = color
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
        bitmap.setFillColor(backgroundColor.cgColor)
        bitmap.fill(rect)
    }
    
    private func drawTemplate(_ bitmap: CGContext, _ rect: CGRect) {
        bitmap.beginPath()
        bitmap.addRect(rect)
        bitmap.closePath()
        bitmap.setFillColor(backgroundColor.cgColor)
        bitmap.fill(rect)
        
        bitmap.beginPath()
        let x = rect.origin.x
        let y = rect.origin.y
        let width = rect.size.width/2
        let height = rect.size.height
        bitmap.setFillColor(shapeColor.cgColor)
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
