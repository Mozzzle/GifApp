//
//  ZGIFImage.swift
//  Gifs App
//
//  Created by Slava Kuzmitsky on 02.03.2021.
//  Copyright © 2021 Slava Kuzmitsky. All rights reserved.
//
//

import UIKit
import ImageIO

class ZGIFImage {

    class func image(url: URL) -> UIImage? {
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        let image = ZGIFImage.image(data: imageData)
        return image
    }

    class func image(data: Data) -> UIImage? {
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        let totalCount = CGImageSourceGetCount(imageSource)
        var image: UIImage?
        if totalCount == 1 {
            image = UIImage(data: data)
        } else {
            image = ZGIFImage.gif(data: data)
        }
        return image
    }
    
    class func gif(data: Data) -> UIImage? {
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        return gifImageWithSource(imageSource)
    }
    
    class func gifImageWithSource(_ source: CGImageSource) -> UIImage? {
        let totalCount = CGImageSourceGetCount(source)
        var images = [UIImage]()
        var gifDuration = 0.0
        for number in 0 ..< totalCount {
            if let cfImage = CGImageSourceCreateImageAtIndex(source, number, nil),
                let properties = CGImageSourceCopyPropertiesAtIndex(source, number, nil),
                let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
                let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) {
                gifDuration += frameDuration.doubleValue
                let image = UIImage(cgImage: cfImage)
                images.append(image)
            }
        }
        let animation = UIImage.animatedImage(with: images, duration: gifDuration)
        return animation
    }
}
