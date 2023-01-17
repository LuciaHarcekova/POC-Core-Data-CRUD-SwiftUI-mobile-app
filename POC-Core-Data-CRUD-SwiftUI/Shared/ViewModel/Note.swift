//
//  Note.swift
//  POC-Core-Data-CRUD-SwiftUI
//
//  Created by Lucia Harceková on 15/01/2023.
//

import UIKit
import Foundation

extension Note {
    
    var color: UIColor? {
        get {
            guard let hex = colorAsHex else { return nil }
            return UIColor(hex: hex)
        }
        set(newColor) {
            if let newColor = newColor {
                colorAsHex = newColor.toHex
            }
        }
    }
}
