//
//  UIViewExtension.swift
//  HamHam
//
//  Created by Defne Çetiner on 22.04.2023.
//

import UIKit

extension UIView {
   @IBInspectable var cornerRadius: CGFloat {
       get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
