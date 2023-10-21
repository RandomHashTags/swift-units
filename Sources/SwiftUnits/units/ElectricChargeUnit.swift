//
//  ElectricChargeUnit.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation
import HugeNumbers

public struct ElectricChargeUnit : Unit {
    public typealias TargetUnitType = ElectricChargeUnitType
    
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
            
        case .coulomb:
            switch unit {
            case .coulomb: return value
            }
            
        }
    }
}
