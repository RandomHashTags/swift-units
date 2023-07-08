//
//  LengthUnitType.swift
//
//
//  Created by Evan Anderson on 7/6/23.
//

import Foundation

public enum LengthUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.length
    
    case metre
    
    case nautical_mile
    case mile
    case furlong
    case yard
    case foot
    case inch
    
    public var symbol : String {
        switch self {
        case .metre: return "m"
            
        case .nautical_mile: return "nmi"
        case .mile: return "mi"
        case .furlong: return "fur"
        case .yard: return "yd"
        case .foot: return "ft"
        case .inch: return "in"
        }
    }
}
