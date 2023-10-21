//
//  ForceUnit.swift
//  
//
//  Created by Evan Anderson on 4/25/23.
//

import Foundation
import HugeNumbers

public struct ForceUnit : Unit {
    public typealias TargetUnitType = ForceUnitType
    
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
            
        case .newton:
            switch unit {
            case .newton: return value
            }
            
        }
    }
}
