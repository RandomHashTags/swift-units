//
//  ActionUnitType.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation

public enum ActionUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.action
    
    case joule_second
    
    public var symbol : String {
        switch self {
        case .joule_second: return "J*s"
        }
    }
}
