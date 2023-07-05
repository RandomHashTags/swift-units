//
//  AccelerationUnit.swift
//  
//
//  Created by Evan Anderson on 4/25/23.
//

import Foundation
import HugeNumbers

public struct AccelerationUnit : Unit {    
    public typealias TargetUnitType = AccelerationUnitType
    
    public var prefix:UnitPrefix
    public var type:TargetUnitType
    public var value:HugeFloat
    
    public init(prefix: UnitPrefix, type: TargetUnitType, value: HugeFloat) {
        self.prefix = prefix
        self.type = type
        self.value = value
    }
    
    public func convert_value_to_unit(_ unit: AccelerationUnitType) -> HugeFloat {
        switch type {
            
        case .metres_per_second_per_second:
            switch unit {
            case .metres_per_second_per_second: return value
            }
            
        }
    }
}
