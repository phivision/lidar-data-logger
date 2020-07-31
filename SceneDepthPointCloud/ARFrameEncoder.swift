/*
 * Phi Vision, Inc.
 * __________________
 *
 *  [2020] Phi Vision, Inc.
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Phi Vision, Inc. and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Adobe Systems Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Phi Vision, Inc.

THOMAS: Extension of ARFrame for encoding
*/

import Foundation
import UIKit
import ARKit


extension ARFrame: Encodable {
    
    enum CodingKeys: CodingKey {
        case featurePoints, depthMapData, confidenceMapData, capturedImageData
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //try container.encode(rawFeaturePoints!.points, forKey: .featurePoints)
        if let rawFeaturePoints = rawFeaturePoints {
            try container.encode(rawFeaturePoints.points, forKey: .featurePoints)
        } else {
            try container.encode([vector_float3](), forKey: .featurePoints)
        }
        
        if sceneDepth != nil {
            sceneDepth?.depthMap.normalize()
            let depthMapCIImage = CIImage(cvPixelBuffer: sceneDepth!.depthMap)
            let depthMapUIImage = UIImage(ciImage: depthMapCIImage)
            let depthMapData = depthMapUIImage.pngData()!
            try container.encode(depthMapData, forKey: .depthMapData)
            
            let confidenceMapCIImage = CIImage(cvImageBuffer: sceneDepth!.confidenceMap!)
            let confidenceMapUIImage = UIImage(ciImage: confidenceMapCIImage)
            let confidenceMapData = confidenceMapUIImage.pngData()!
            try container.encode(confidenceMapData, forKey: .confidenceMapData)
        }
        
        let capturedImageCIImage = CIImage(cvImageBuffer: capturedImage)
        let capturedImageUIImage = UIImage(ciImage: capturedImageCIImage)
        let capturedImageData = capturedImageUIImage.pngData()!
        try container.encode(capturedImageData, forKey: .capturedImageData)
    }
}
