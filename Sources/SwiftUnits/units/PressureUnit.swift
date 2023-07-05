//
//  PressureUnit.swift
//  
//
//  Created by Evan Anderson on 4/21/23.
//

import Foundation
import HugeNumbers

public struct PressureUnit : Unit {
    public typealias TargetUnitType = PressureUnitType
    
    public var prefix:UnitPrefix
    public var type:TargetUnitType
    public var value:HugeFloat
    
    public init(prefix: UnitPrefix, type: TargetUnitType, value: HugeFloat) {
        self.prefix = prefix
        self.type = type
        self.value = value
    }
    
    public func convert_value_to_unit(_ unit: PressureUnitType) -> HugeFloat {
        switch type {
            
        case .pascal:
            switch unit {
            case .pascal: return value
            case .pound_per_square_inch: return value * HugeFloat("0.000145037737730")
            case .standard_atmosphere: return value * HugeFloat("0.00000986923")
            }
            
        case .pound_per_square_inch:
            switch unit {
            case .pascal: return value * HugeFloat("6894.757293168")
            case .pound_per_square_inch: return value
            case .standard_atmosphere: return value * HugeFloat("0.068045963779916")
            }
            
        case .standard_atmosphere:
            switch unit {
            case .pascal: return value * HugeFloat("101325")
            case .pound_per_square_inch: return value * HugeFloat("14.6959487755142")
            case .standard_atmosphere: return value
            }
        }
    }
}
