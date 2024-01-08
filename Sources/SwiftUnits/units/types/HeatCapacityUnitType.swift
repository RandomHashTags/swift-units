//
//  HeatCapacityUnitType.swift
//
//
//  Created by Evan Anderson on 1/8/24.
//

import Foundation

public enum HeatCapacityUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.heat_capacity
    
    case joule_per_kelvin
    //case kilogram_meter_squared_per_second_squared_per_kelvin
    
    public var symbol : String {
        switch self {
        case .joule_per_kelvin: return "J/K"
        //case .kilogram_meter_squared_per_second_squared_per_kelvin: return "kg⋅m" + 2.as_superscript + "⋅s" + -2.as_superscript + "⋅K" + -1.as_superscript
        }
    }
}
