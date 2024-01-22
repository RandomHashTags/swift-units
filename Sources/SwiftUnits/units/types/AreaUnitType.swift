//
//  AreaUnitType.swift
//
//
//  Created by Evan Anderson on 1/22/24.
//

import Foundation

public enum AreaUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.area
    
    case square_metre
    
    case square_mile
    case square_yard
    case square_foot
    case square_inch
    
    public var symbol : String {
        switch self {
        case .square_metre: return "m" + 2.as_superscript
        case .square_mile: return "mi" + 2.as_superscript
        case .square_yard: return "yd" + 2.as_superscript
        case .square_foot: return "ft" + 2.as_superscript
        case .square_inch: return "in" + 2.as_superscript
        }
    }
}
