//
//  FrequencyUnitType.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation

public enum FrequencyUnitType : String, UnitType {
    public static let category:UnitCategory = UnitCategory.frequency
    
    case wavelength_in_metres
    
    case hertz
        
    public var symbol : String {
        switch self {
        case .wavelength_in_metres: return "m"
            
        case .hertz: return "Hz"
        }
    }
}
