//
//  ElectricCurrentUnitType.swift
//
//
//  Created by Evan Anderson on 10/21/23.
//

import Foundation

public enum ElectricCurrentUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.electric_current
    
    /// AKA an `amp`
    case ampere
    
    public var symbol : String {
        switch self {
        case .ampere: return "A"
        }
    }
}
