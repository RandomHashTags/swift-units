//
//  IntegerExtensions.swift
//
//
//  Created by Evan Anderson on 7/5/23.
//

import Foundation

internal extension BinaryInteger {
    var as_superscript : String {
        let values:[Character] = String(describing: self).map({ get_superscript($0) })
        return String(values)
    }
    private func get_superscript(_ value: Character) -> Character {
        switch value {
        case "0": return "⁰"
        case "1": return "¹"
        case "2": return "²"
        case "3": return "³"
        case "4": return "⁴"
        case "5": return "⁵"
        case "6": return "⁶"
        case "7": return "⁷"
        case "8": return "⁸"
        case "9": return "⁹"
        default: return "?"
        }
    }
}
