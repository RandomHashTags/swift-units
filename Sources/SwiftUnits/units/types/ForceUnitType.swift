//
//  ForceUnitType.swift
//  
//
//  Created by Evan Anderson on 4/25/23.
//

import Foundation

public enum ForceUnitType : String, UnitType {
    case newton
    
    public var symbol : String {
        switch self {
        case .newton: return "N"
        }
    }
}
