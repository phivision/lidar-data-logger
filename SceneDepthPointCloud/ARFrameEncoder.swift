//
//  ARFrameEncoder.swift
//  SceneDepthPointCloud
//
//  Created by Thomas Wang on 7/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//


import Foundation
import UIKit
import ARKit

//THOMAS: Extension of ARFrame for encoding
extension ARFrame: Encodable {
    
    enum CodingKeys: CodingKey {
        case pointCloud, depthMapData, confidenceMapData, capturedImageData
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //try container.encode(rawFeaturePoints!.points, forKey: .pointCloud)
        if let rawFeaturePoints = rawFeaturePoints {
            try container.encode(rawFeaturePoints.points, forKey: .pointCloud)
        } else {
            try container.encode([vector_float3](), forKey: .pointCloud)
        }
        
        let depthMapCIImage = CIImage(cvPixelBuffer: sceneDepth!.depthMap)
        let depthMapUIImage = UIImage(ciImage: depthMapCIImage)
        let depthMapData = depthMapUIImage.pngData()!
        try container.encode(depthMapData, forKey: .depthMapData)
        
        let confidenceMapCIImage = CIImage(cvImageBuffer: sceneDepth!.confidenceMap!)
        let confidenceMapUIImage = UIImage(ciImage: confidenceMapCIImage)
        let confidenceMapData = confidenceMapUIImage.pngData()!
        try container.encode(confidenceMapData, forKey: .confidenceMapData)
        
        let capturedImageCIImage = CIImage(cvImageBuffer: capturedImage)
        let capturedImageUIImage = UIImage(ciImage: capturedImageCIImage)
        let capturedImageData = capturedImageUIImage.pngData()!
        try container.encode(capturedImageData, forKey: .capturedImageData)
    }
}
