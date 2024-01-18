//
//  SubstanceUnitType.swift
//
//
//  Created by Evan Anderson on 1/18/24.
//

import Foundation

public enum SubstanceUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.substance
    
    case elementary_entities
    case mole
    
    public var symbol : String {
        switch self {
        case .elementary_entities: return "N"
        case .mole: return "mol"
        }
    }
}
