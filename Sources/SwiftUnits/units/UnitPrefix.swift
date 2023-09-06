//
//  UnitPrefix.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation
import HugeNumbers

/// as defined at https://en.wikipedia.org/wiki/Metric_prefix
/// `rawValue` == base ten multiplier (10^x)
public enum UnitPrefix : Int, CaseIterable {
    case quecto = -30
    case ronto = -27
    case yocto = -24
    case zepto = -21
    case atto = -18
    case femto = -15
    case pico = -12
    case nano = -9
    case micro = -6
    case milli = -3
    case centi = -2
    case deci = -1
    
    case normal = 0
    
    case deca = 1
    case hecto = 2
    case kilo = 3
    case mega = 6
    case giga = 9
    case tera = 12
    case peta = 15
    case exa = 18
    case zetta = 21
    case yotta = 24
    case ronna = 27
    case quetta = 30
    
    public var symbol : String {
        switch self {
        case .quecto: return "q"
        case .ronto: return "r"
        case .yocto: return "y"
        case .zepto: return "z"
        case .atto: return "a"
        case .femto: return "f"
        case .pico: return "p"
        case .nano: return "n"
        case .micro: return "μ"
        case .milli: return "m"
        case .centi: return "c"
        case .deci: return "d"
            
        case .normal: return ""
            
        case .deca: return "da"
        case .hecto: return "h"
        case .kilo: return "k"
        case .mega: return "M"
        case .giga: return "G"
        case .tera: return "T"
        case .peta: return "P"
        case .exa: return "E"
        case .zetta: return "Z"
        case .yotta: return "Y"
        case .ronna: return "R"
        case .quetta: return "Q"
        }
    }
    
    public func convert_to(_ prefix: UnitPrefix, value: HugeFloat) -> HugeFloat {
        guard self != prefix else { return value }
        return value.move_decimal(rawValue - prefix.rawValue)
    }
}
