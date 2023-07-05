//
//  AccelerationUnitType.swift
//  
//
//  Created by Evan Anderson on 4/25/23.
//

import Foundation

public enum AccelerationUnitType : String, UnitType {
    case metres_per_second_per_second
    
    public var symbol : String {
        switch self {
        case .metres_per_second_per_second: return "m/s2"
        }
    }
}
