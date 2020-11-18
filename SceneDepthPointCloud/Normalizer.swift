//
//  Normalizer.swift
//  SceneDepthPointCloud
//
//  Created by Thomas Wang on 7/31/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import CoreVideo

extension CVPixelBuffer {
    func normalize() {
                        
      let width = CVPixelBufferGetWidth(self)
      let height = CVPixelBufferGetHeight(self)

      CVPixelBufferLockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
      let floatBuffer = unsafeBitCast(CVPixelBufferGetBaseAddress(self), to: UnsafeMutablePointer<Float>.self)

      var minPixel: Float = Float.greatestFiniteMagnitude
      var maxPixel: Float = -minPixel

      for y in 0 ..< height {
         for x in 0 ..< width {
        let pixel = floatBuffer[y * width + x]
             minPixel = min(pixel, minPixel)
              maxPixel = max(pixel, maxPixel)
         }
      }
      let range = maxPixel - minPixel

       for y in 0 ..< height {
             for x in 0 ..< width {
            let pixel = floatBuffer[y * width + x]
                floatBuffer[y * width + x] = (pixel - minPixel) / range
       }
       }
      CVPixelBufferUnlockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
    }
}
