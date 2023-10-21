//
//  ElectricPowerUnit.swift
//
//
//  Created by Evan Anderson on 10/21/23.
//

import Foundation
import HugeNumbers

public struct ElectricPowerUnit : Unit {
    public typealias TargetUnitType = ElectricPowerUnitType
    
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
            
        case .watt:
            switch unit {
            case .watt: return value
            }
            
        }
    }
    
    /// Converts this ``ElectricPowerUnit`` to an ``ActionUnit``. Default is the joule-second.
    public func to_action() -> ActionUnit {
        let value:HugeFloat = convert_value_to_unit(prefix: UnitPrefix.normal, ElectricPowerUnitType.watt)
        return ActionUnit(type: ActionUnitType.joule_second, value: value)
    }
}
