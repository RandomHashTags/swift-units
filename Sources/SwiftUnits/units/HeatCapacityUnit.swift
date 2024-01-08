//
//  HeatCapacityUnit.swift
//
//
//  Created by Evan Anderson on 1/8/24.
//

import Foundation
import HugeNumbers

public struct HeatCapacityUnit : Unit {
    public typealias TargetUnitType = HeatCapacityUnitType
    
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
            
        case .joule_per_kelvin:
            switch unit {
            case .joule_per_kelvin: return value
            }
            
        }
    }
}
