//
//  DensityUnit.swift
//  
//
//  Created by Evan Anderson on 4/26/23.
//

import Foundation
import HugeNumbers

public struct DensityUnit : Unit {
    public typealias TargetUnitType = DensityUnitType
    
    public var prefix:UnitPrefix
    public var type:TargetUnitType
    public var value:HugeFloat
    
    public init(prefix: UnitPrefix, type: TargetUnitType, value: HugeFloat) {
        self.prefix = prefix
        self.type = type
        self.value = value
    }
    
    public func convert_value_to_unit(_ unit: TargetUnitType) -> HugeFloat {
        switch type {
            
        case .kilogram_per_cubic_metre:
            switch unit {
            case .kilogram_per_cubic_metre: return value
            case .gram_per_cubic_centimetre: return value.move_decimal(-3)
            }
            
        case .gram_per_cubic_centimetre:
            switch unit {
            case .kilogram_per_cubic_metre: return value.move_decimal(3)
            case .gram_per_cubic_centimetre: return value
            }
            
        }
    }
}
