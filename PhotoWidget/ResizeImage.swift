//
//  ResizeImage.swift
//  PhotoWidget
//
//  Created by Liyi Liu on 7/7/24.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
