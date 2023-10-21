//
//  ElectricPowerUnitType.swift
//
//
//  Created by Evan Anderson on 10/21/23.
//

import Foundation

public enum ElectricPowerUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.electric_power
    
    //case horsepower_boiler // TODO: support
    //case horsepower_electrical
    //case horsepower_hydraulic
    //case horsepower_mechanical
    //case horsepower_metric
    case watt
    
    public var symbol : String {
        switch self {
        //case .horsepower_boiler: return "hp(S)"
        //case .horsepower_hydraulic: return "hp(H)"
        //case .horsepower_electrical: return "hp(E)"
        //case .horsepower_mechanical: return "hp(I)"
        //case .horsepower_metric: return "hp(M)"
        case .watt: return "W"
        }
    }
}
