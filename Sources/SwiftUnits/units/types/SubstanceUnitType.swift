//
//  ChemicalSubstanceUnitType.swift
//
//
//  Created by Evan Anderson on 1/18/24.
//

import Foundation

public enum ChemicalSubstanceUnitType : String, UnitType {
    public static let category:UnitCategory
    
    case mole
    
    public var symbol : String {
        switch self {
        case .mole: return "mol"
        }
    }
}
