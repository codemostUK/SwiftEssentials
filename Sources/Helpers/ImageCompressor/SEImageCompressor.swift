//
//  SEImageCompressor.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 15.07.2023.
//

import UIKit

/// A utility struct for compressing `UIImage` instances to a target size in bytes.
/// Compression is done iteratively, reducing the image dimensions and quality until the image meets the specified size.
struct SEImageCompressor {

    /// Compresses the given image to a size as close as possible to the specified maximum byte size.
    /// The compression progress is broadcast using notifications.
    /// - Parameters:
    ///   - image: The `UIImage` to be compressed.
    ///   - maxByte: The target maximum size of the compressed image in bytes.
    /// - Returns: A compressed `UIImage` that is within the specified size limit, or `nil` if compression fails.
    static func compress(image: UIImage, maxByte: Int) async -> UIImage? {

        // Get the current image size in bytes
        guard let currentImageSize = image.jpegData(compressionQuality: 1.0)?.count else { return nil }

        var iterationImage: UIImage? = image
        var iterationImageSize = currentImageSize
        var iterationCompression: CGFloat = 1.0

        // Continue to compress until the image size is smaller than maxByte or compression reaches a minimum limit
        while iterationImageSize > maxByte && iterationCompression > 0.01 {
            let progress = CGFloat(maxByte) / CGFloat(iterationImageSize)

            // Post notification for progress update
            postNotification(.imageCompressorProgressChanged, userInfo: [.userInfoKeySEImageCompressorProgress: progress])

            // Decrease the compression percentage based on the current image size
            let percentageDecrease = getPercentageToDecreaseTo(forDataCount: iterationImageSize)

            let canvasSize = CGSize(width: image.size.width * iterationCompression,
                                    height: image.size.height * iterationCompression)
            UIGraphicsBeginImageContextWithOptions(canvasSize, false, image.scale)
            defer { UIGraphicsEndImageContext() }
            image.draw(in: CGRect(origin: .zero, size: canvasSize))
            iterationImage = UIGraphicsGetImageFromCurrentImageContext()

            // Update the image size after compression
            guard let newImageSize = iterationImage?.jpegData(compressionQuality: 1.0)?.count else {
                return nil
            }
            iterationImageSize = newImageSize
            iterationCompression -= percentageDecrease
        }

        // Final progress notification indicating 100% completion
        postNotification(.imageCompressorProgressChanged, userInfo: [.userInfoKeySEImageCompressorProgress: 1.0])
        return iterationImage
    }

    /// Determines the percentage by which the image dimensions should be reduced based on the current size.
    /// - Parameter dataCount: The current size of the image in bytes.
    /// - Returns: The percentage decrease to apply for the next iteration of compression.
    private static func getPercentageToDecreaseTo(forDataCount dataCount: Int) -> CGFloat {
        switch dataCount {
            case 0..<5000000: return 0.03
            case 5000000..<10000000: return 0.1
            default: return 0.2
        }
    }
}

// MARK: - Notification
extension NSNotification.Name {
    static let imageCompressorProgressChanged = Notification.Name("SEImageCompressor.ImageCompressorProgressChanged")
}

// MARK: - Userinfo Key
extension String {
    static let userInfoKeySEImageCompressorProgress = "userInfoKeySEImageCompressorProgress"
}
