//
//  IlluminanceUnit.swift
//
//
//  Created by Evan Anderson on 1/20/24.
//

import Foundation
import HugeNumbers

public struct IlluminanceUnit : Unit {
    public typealias TargetUnitType = IlluminanceUnitType
    
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
            
        case .lux:
            switch unit {
            case .lux: return value
            case .phot: return value.move_decimal(-4)
            case .foot_candle: return value * HugeFloat("0.092903040000084")
            }
            
        case .phot:
            switch unit {
            case .lux: return value.move_decimal(4)
            case .phot: return value
            case .foot_candle: return value * HugeFloat("929")
            }
            
        case .foot_candle:
            switch unit {
            case .lux: return value * HugeFloat("10.76391041669999")
            case .phot: return value * HugeFloat("0.001076")
            case .foot_candle: return value
            }
            
        }
    }
}
