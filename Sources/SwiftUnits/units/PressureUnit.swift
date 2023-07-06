//
//  PressureUnit.swift
//  
//
//  Created by Evan Anderson on 4/21/23.
//

import Foundation
import HugeNumbers

public struct PressureUnit : Unit {
    public typealias TargetUnitType = PressureUnitType
    
    public var prefix:UnitPrefix
    public var type:TargetUnitType
    public var value:HugeFloat
    
    public init(prefix: UnitPrefix, type: TargetUnitType, value: HugeFloat) {
        self.prefix = prefix
        self.type = type
        self.value = value
    }
    
    public func convert_value_to_unit(_ unit: PressureUnitType) -> HugeFloat {
        switch type {
            
        case .pascal:
            switch unit {
            case .pascal: return value
            case .pound_per_square_inch: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1290320000", divisor: "8896443230521"))
            case .standard_atmosphere: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "101325"))
            }
            
        case .pound_per_square_inch:
            switch unit {
            case .pascal: return value * HugeFloat(integer: HugeInt("6894"), remainder: HugeRemainder(dividend: "977150521", divisor: "1290320000"))
            case .pound_per_square_inch: return value
            case .standard_atmosphere: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1270920461503", divisor: "18677382000000"))
            }
            
        case .standard_atmosphere:
            switch unit {
            case .pascal: return value * HugeFloat("101325")
            case .pound_per_square_inch: return value * HugeFloat(integer: HugeInt("14"), remainder: HugeRemainder(dividend: "884495538958", divisor: "1270920461503"))
            case .standard_atmosphere: return value
            }
        }
    }
}
