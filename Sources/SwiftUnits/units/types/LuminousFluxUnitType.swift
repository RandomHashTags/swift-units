//
//  LuminousFluxUnitType.swift
//
//
//  Created by Evan Anderson on 1/21/24.
//

import Foundation

public enum LuminousFluxUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.luminous_flux
    
    case lumen
    
    public var symbol : String {
        switch self {
        case .lumen: return "lm"
        }
    }
}
