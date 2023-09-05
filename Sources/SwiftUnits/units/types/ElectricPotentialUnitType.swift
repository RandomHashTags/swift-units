//
//  ElectricPotentialUnitType.swift
//
//
//  Created by Evan Anderson on 9/4/23.
//

import Foundation

public enum ElectricPotentialUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.electric_potential
    
    case abvolt
    case volt
    case statvolt
    
    public var symbol : String {
        switch self {
        case .abvolt: return "abV"
        case .volt: return "V"
        case .statvolt: return "statV"
        }
    }
}
