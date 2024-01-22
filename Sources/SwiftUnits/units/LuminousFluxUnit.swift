//
//  LuminousFluxUnit.swift
//
//
//  Created by Evan Anderson on 1/22/24.
//

import Foundation
import HugeNumbers

public struct LuminousFluxUnit : Unit {
    public typealias TargetUnitType = LuminousFluxUnitType
    
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
            
        case .lumen:
            switch unit {
            case .lumen: return value
            }
            
        }
    }
}
