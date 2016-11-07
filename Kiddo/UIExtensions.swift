//
//  UIExtensions.swift
//  Kiddo
//
//  Created by John Shaff on 11/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

extension UIResponder {
    class func identifier() -> String {
        return String(describing: self)
    }
}

