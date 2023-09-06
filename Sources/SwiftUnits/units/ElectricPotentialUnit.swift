//
//  ElectricPotentialUnit.swift
//
//
//  Created by Evan Anderson on 9/4/23.
//

import Foundation
import HugeNumbers

public struct ElectricPotentialUnit : Unit {
    public typealias TargetUnitType = ElectricPotentialUnitType
    
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
            
        case .abvolt:
            switch unit {
            case .abvolt: return value
            case .volt: return value.move_decimal(-8)
            case .statvolt: return value * HugeFloat("0.000000000033356409519815")
            }
        case .volt:
            switch unit {
            case .abvolt: return value.move_decimal(8)
            case .volt: return value
            case .statvolt: return value * HugeFloat("0.0033356409519815")
            }
            
        case .statvolt:
            switch unit {
            case .abvolt: return value * HugeFloat("29979245800") // TODO: fix (not exact conversion)
            case .volt: return value * HugeFloat("299.792458")
            case .statvolt: return value
            }
            
        }
    }
}
