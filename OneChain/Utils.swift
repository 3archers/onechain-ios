//
//  Utils.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/4/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import Foundation
import Parse

class Utils {

    class func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        let resizedImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizedImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizedImageView.image = image

        UIGraphicsBeginImageContext(resizedImageView.frame.size)
        resizedImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
