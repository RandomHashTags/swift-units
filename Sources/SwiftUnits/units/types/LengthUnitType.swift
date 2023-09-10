//
//  LengthUnitType.swift
//
//
//  Created by Evan Anderson on 7/6/23.
//

import Foundation

public enum LengthUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.length
    
    case angstrom
    
    case inch
    case foot
    case yard
    case furlong
    case mile
    case nautical_mile
    
    case metre
    
    
    public var symbol : String {
        switch self {
        case .angstrom: return "Å"
        case .metre: return "m"
            
        case .nautical_mile: return "nmi"
        case .mile: return "mi"
        case .furlong: return "fur"
        case .yard: return "yd"
        case .foot: return "′"
        case .inch: return "″"
        }
    }
}
