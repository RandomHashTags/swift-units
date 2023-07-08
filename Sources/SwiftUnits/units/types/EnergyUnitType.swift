//
//  EnergyUnitType.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation

public enum EnergyUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.energy
    
    case electronvolt
    case joule
    
    public var symbol : String {
        switch self {
        case .joule: return "J"
        case .electronvolt: return "eV"
        }
    }
}
