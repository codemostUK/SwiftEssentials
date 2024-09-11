//
//  SEAnimatedImageView+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 21.02.2023.
//

import UIKit

final public class SEAnimatedImageView: UIImageView {
    public var imageName: String?
    public var frameCount: Int = 0
    public var duration: TimeInterval = 2
    public var imageTintColor: UIColor?

    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.contentMode = .scaleAspectFit
    }
    
    // MARK: - Animation
    
    /// Starts the animation by loading images with the specified name and count.
    public func startAnimation() {
        guard let imageName = imageName, frameCount != 0 else { return }
        
        var images: [UIImage] = []
        
        for i in 1...frameCount {
            let imageName = "\(imageName)-\(i)"
            if let image = UIImage(named: imageName) {
                if let imageTintColor = imageTintColor, let tintedImage = image.imageWithColor(imageTintColor) {
                    images.append(tintedImage)
                } else {
                    images.append(image)
                }
            }
        }
        
        if images.isEmpty { return }
        
        self.animationRepeatCount = 0
        self.animationDuration = duration
        self.animationImages = images
        self.startAnimating()
    }
}
