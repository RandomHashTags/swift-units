//
//  LuminousIntensityUnit.swift
//
//
//  Created by Evan Anderson on 1/22/24.
//

import Foundation
import HugeNumbers

public struct LuminousIntensityUnit : Unit {
    public typealias TargetUnitType = LuminousIntensityUnitType
    
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
            
        case .candela:
            switch unit {
            case .candela: return value
            }
            
        }
    }
}
