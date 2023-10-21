//
//  ElectricCurrentUnit.swift
//
//
//  Created by Evan Anderson on 10/21/23.
//

import Foundation
import HugeNumbers

public struct ElectricCurrentUnit : Unit {
    public typealias TargetUnitType = ElectricCurrentUnitType
    
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
            
        case .ampere:
            switch unit {
            case .ampere: return value
            }
            
        }
    }
    
    /// Converts this ``ElectricCurrentUnit`` to an ``ElectricChargeUnit``. Default is the coulomb.
    public func to_electric_charge() -> ElectricChargeUnit {
        let value:HugeFloat = convert_value_to_unit(prefix: UnitPrefix.normal, ElectricCurrentUnitType.ampere)
        return ElectricChargeUnit(type: ElectricChargeUnitType.coulomb, value: value)
    }
}
