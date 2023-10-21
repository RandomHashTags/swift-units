//
//  ElectricResistanceUnit.swift
//
//
//  Created by Evan Anderson on 10/21/23.
//

import Foundation
import HugeNumbers

public struct ElectricResistanceUnit : Unit {
    public typealias TargetUnitType = ElectricResistanceUnitType
    
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
            
        case .ohm:
            switch unit {
            case .ohm: return value
            }
            
        }
    }
}
