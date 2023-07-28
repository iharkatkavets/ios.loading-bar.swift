//
//  LoadingBar.swift
//  LoadingBar
//
//  Created by Ihar Katkavets on 28/07/2023.
//

import UIKit

private final class ProgressView: UIView {
    private lazy var maskLayer: CALayer = {
        let layer = CALayer()
        layer.opacity = 1
        layer.backgroundColor = UIColor.white.cgColor
        return layer
    }()
    var progress: CGFloat = 1 {
        didSet {
            clip()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.mask = maskLayer
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.mask = maskLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clip()
    }
    
    private func clip() {
        var clippedFrame = bounds
        clippedFrame.size.width = bounds.size.width*max(0, min(progress, 1))
        maskLayer.frame = clippedFrame
    }
}

public final class LoadingBar: UIView {
    private lazy var progressView: ProgressView = {
        let view  = ProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.clipsToBounds = true
        return view
    }()
    let imageBuilder: TemplateImageBuilder = TemplateImageBuilder()
    var displaylink: CADisplayLink?
    private let templateImageWidth: CGFloat = 60
    private var offset: CGFloat = 0
    private var templateImage: CGImage? = nil
    private var templateShapeColor = UIColor.systemPink {
        didSet {
            templateImage = imageBuilder.withShapeColor(templateShapeColor).build()
        }
    }
    private var templateBackgroundColor = UIColor.yellow {
        didSet {
            templateImage = imageBuilder.withShapeColor(templateShapeColor).build()
        }
    }
    let scale = UIScreen.main.scale
    public var progress: CGFloat = 1 {
        didSet {
            progressView.progress = progress
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createNestedLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        createNestedLayout()
    }
    
    private func createNestedLayout() {
       addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let size = CGSize(width: templateImageWidth,
                          height: bounds.size.height)
        templateImage = imageBuilder
            .withSize(size)
            .withScale(scale)
            .withBackgroundColor(templateBackgroundColor)
            .withShapeColor(templateShapeColor)
            .build()
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil { stopDisplayLink() }
        else { runDisplayLink() }
        super.willMove(toSuperview: newSuperview)
    }
    
    private func runDisplayLink() {
        displaylink?.invalidate()
        displaylink = CADisplayLink(target: self, selector: #selector(step))
        displaylink?.add(to: .current, forMode: .default)
    }
    
    private func stopDisplayLink() {
        displaylink?.invalidate()
        displaylink = nil
    }
         
    @objc private func step(displaylink: CADisplayLink) {
        if offset < 0 {
            offset = templateImageWidth
        }
        let rect = CGRect(x: scale*offset, y: 0, width: scale*templateImageWidth, height: scale*bounds.size.height)
        if let image = templateImage?.cropping(to: rect) {
            progressView.backgroundColor = UIColor(patternImage: UIImage(cgImage: image,scale: scale,orientation: .up))
        }
        offset -= 1
    }
}
