//
//  ImageExt.swift
//  SceneDepthPointCloud
//
//  Created by Thomas Wang on 7/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import VideoToolbox

public extension UIImage {
    convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)

        guard let cgImageReal = cgImage else {
            return nil
        }

        self.init(cgImage: cgImageReal)
    }
}
