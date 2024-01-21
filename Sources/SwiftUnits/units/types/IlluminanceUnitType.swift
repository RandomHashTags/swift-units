//
//  IlluminanceUnitType.swift
//
//
//  Created by Evan Anderson on 1/20/24.
//

import Foundation

public enum IlluminanceUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.illuminance
    
    case lux
    case phot
    case foot_candle
    
    public var symbol : String {
        switch self {
        case .lux: return "lx"
        case .phot: return "ph"
        case .foot_candle: return "fc"
        }
    }
}
