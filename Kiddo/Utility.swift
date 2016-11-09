//
//  Utility.swift
//  Kiddo
//
//  Created by Filiz Kurban on 11/9/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

extension UIImage {
     func cropImageForTimelineView() -> UIImage {
        //image can be nil here!!!
        //check if the image is at lest 20 X 20 here.
        let contextImage: UIImage = UIImage(cgImage: self.cgImage!)

        let cgwidth: CGFloat = CGFloat(340.0)
        let cgheight: CGFloat = CGFloat(200.0)

        let posX: CGFloat = (self.size.width / 2.0) - cgwidth / 2
        let posY: CGFloat = (self.size.height / 2.0) - cgheight / 2

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        let image: UIImage = UIImage(cgImage: imageRef, scale: 2.0, orientation: self.imageOrientation)
        
        return image
    }

    func cropImageForTimelineViewWithRespectToInitialSize() -> UIImage {
        //image can be nil here!!!
        //check if the image is at lest 20 X 20 here.
        let contextImage: UIImage = UIImage(cgImage: self.cgImage!)

        let cgwidth: CGFloat = CGFloat(480)
        let cgheight: CGFloat = CGFloat(240)

        let posX: CGFloat = (self.size.width / 2.0) - cgwidth / 2
        let posY: CGFloat = (self.size.height / 2.0) - cgheight / 2

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        let image: UIImage = UIImage(cgImage: imageRef, scale: 2.0, orientation: self.imageOrientation)

        return image
    }

    func imageWithGradient() -> UIImage {

        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()

        self.draw(at: CGPoint(x: 0, y: 0))

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.0, 1.0]

        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor

        let colors = [top, bottom] as CFArray

        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)

        let startPoint = CGPoint(x: self.size.width/3, y: 0)
        let endPoint = CGPoint(x: self.size.width/10, y: self.size.height)

        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))

        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()

        return image!
    }

}
