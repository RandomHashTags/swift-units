//
//  ActionUnit.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation
import HugeNumbers

public struct ActionUnit : Unit {
    public typealias TargetUnitType = ActionUnitType
    
    public var prefix:UnitPrefix
    public var type:TargetUnitType
    public var value:HugeFloat
    
    public init(prefix: UnitPrefix, type: TargetUnitType, value: HugeFloat) {
        self.prefix = prefix
        self.type = type
        self.value = value
    }
    
    public func convert_value_to_unit(_ unit: ActionUnitType) -> HugeFloat {
        switch type {
            
        case .joule_second:
            switch unit {
            case .joule_second: return value
            }
            
        }
    }
}
