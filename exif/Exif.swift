//
//  Exif.swift
//  exif
//
//  Created by Matisse Enzer on 2/3/24.
//

import Foundation
import ArgumentParser
import ImageIO

@main
struct Exif : ParsableCommand {

    @Argument(help: "Path to an image file")
    var path: String

    mutating func run() throws {
        let fullPath = URL(filePath: path).standardized
        print("Path is:\(fullPath.path())")
        
        let options = [kCGImageSourceShouldCache : false]
        guard let imageData = CGImageSourceCreateWithURL(fullPath as CFURL, options as CFDictionary) else {
            throw "failed to read file \(fullPath.path())"
        }

        guard let metadata = CGImageSourceCopyMetadataAtIndex(imageData, 0, nil) else {
            throw "Could not copy metadata from \(fullPath.path())"
        }

        print("Metadata: \(metadata)")
    }
}

extension String : Error {
    
}
