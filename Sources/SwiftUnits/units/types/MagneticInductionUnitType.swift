//
//  MagneticInductionUnitType.swift
//
//
//  Created by Evan Anderson on 9/6/23.
//

import Foundation

public enum MagneticInductionUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.magnetic_induction
    
    case gauss
    case tesla
    
    public var symbol : String {
        switch self {
        case .gauss: return "G"
        case .tesla: return "T"
        }
    }
}
