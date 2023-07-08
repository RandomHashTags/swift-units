//
//  SpeedUnitType.swift
//
//  Created by Evan Anderson on 4/5/23.
//

import Foundation

public enum SpeedUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.speed
    
    case metre_per_second
    case kilometre_per_hour
    case mile_per_hour
    case knot
    case foot_per_second
    
    public var symbol : String {
        switch self {
        case .metre_per_second: return "m/s"
        case .kilometre_per_hour: return "km/h"
        case .mile_per_hour: return "mph"
        case .knot: return "knot"
        case .foot_per_second: return "ft/s"
        }
    }
}
