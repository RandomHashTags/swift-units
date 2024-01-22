//
//  LuminousIntensityUnitType.swift
//
//
//  Created by Evan Anderson on 1/21/24.
//

import Foundation

public enum LuminousIntensityUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.luminous_intensity
    
    case candela
    
    public var symbol : String {
        switch self {
        case .candela: return "cd"
        }
    }
}
