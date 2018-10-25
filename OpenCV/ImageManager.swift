//
//  ImageManager.swift
//  OpenCV
//
//  Created by BinaryBoy on 10/25/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import UIKit

class ImageManager {
    
   static func getEdgeImage(orginImage:UIImage) -> UIImage {
    return OpenCVWrapper.cannyEdgeImage(orginImage)
    }
    
    static func image(image1: UIImage, isEqualTo image2: UIImage) -> Bool {
        let data1: Data = UIImagePNGRepresentation(image1)!
        let data2: Data = UIImagePNGRepresentation(image2)!
        return data1.elementsEqual(data2)
    }
}
