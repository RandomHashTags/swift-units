//
//  SubstanceUnit.swift
//
//
//  Created by Evan Anderson on 1/18/24.
//

import Foundation
import HugeNumbers

public struct SubstanceUnit : Unit {
    public typealias TargetUnitType = SubstanceUnitType
    
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
        case .elementary_entities:
            switch unit {
            case .elementary_entities: return value
            case .mole: return value / HugeFloat("602214076000000000000000")
            }
            
        case .mole:
            switch unit {
            case .elementary_entities: return value * HugeInt("602214076000000000000000")
            case .mole: return value
            }
        }
    }
}
