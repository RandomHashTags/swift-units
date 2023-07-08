//
//  ElectricChargeUnitType.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation

public enum ElectricChargeUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.electric_charge
    
    case coulomb
    
    public var symbol : String {
        switch self {
        case .coulomb: return "C"
        }
    }
}
