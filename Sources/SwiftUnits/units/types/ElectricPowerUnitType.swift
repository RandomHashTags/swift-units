//
//  ElectricPowerUnitType.swift
//
//
//  Created by Evan Anderson on 10/21/23.
//

import Foundation

public enum ElectricPowerUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.electric_power
    
    case watt
    
    public var symbol : String {
        switch self {
        case .watt: return "W"
        }
    }
}
