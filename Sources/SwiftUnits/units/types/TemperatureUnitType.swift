//
//  TemperatureUnitType.swift
//
//  Created by Evan Anderson on 4/5/23.
//

import Foundation
import HugeNumbers

public enum TemperatureUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.temperature
    
    case fahrenheit
    case celsius
    case kelvin
    case rankine
    
    public var symbol : String {
        switch self {
        case .celsius: return "C"
        case .fahrenheit: return "F"
        case .kelvin: return "K"
        case .rankine: return "R"
        }
    }
    
    public var absolute_zero : HugeFloat {
        switch self {
        case .celsius: return HugeFloat("-273.15")
        case .fahrenheit: return HugeFloat("-459.67")
        case .kelvin: return HugeFloat.zero
        case .rankine: return HugeFloat.zero
        }
    }
}
