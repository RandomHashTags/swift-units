//
//  ElectricResistanceUnitType.swift
//  
//
//  Created by Evan Anderson on 10/21/23.
//

import Foundation

public enum ElectricResistanceUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.electric_resistance
    
    case ohm
    
    public var symbol : String {
        switch self {
        case .ohm: return "Ω"
        }
    }
}
