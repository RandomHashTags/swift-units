//
//  MagneticInductionUnit.swift
//
//
//  Created by Evan Anderson on 9/6/23.
//

import Foundation
import HugeNumbers

/// AKA: Magnetic Flux Density Unit
public struct MagneticInductionUnit : Unit {
    public typealias TargetUnitType = MagneticInductionUnitType
    
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
        case .gauss:
            switch unit {
            case .gauss: return value
            case .tesla: return value.move_decimal(-4)
            }
            
        case .tesla:
            switch unit {
            case .gauss: return value.move_decimal(4)
            case .tesla: return value
            }
        }
    }
}
