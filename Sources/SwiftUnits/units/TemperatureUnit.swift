//
//  TemperatureUnit.swift
//  
//
//  Created by Evan Anderson on 4/21/23.
//

import Foundation
import HugeNumbers

public struct TemperatureUnit : Unit {
    public typealias TargetUnitType = TemperatureUnitType
    
    public var prefix:UnitPrefix
    public var type:TargetUnitType
    public var value:HugeFloat
    
    public init(prefix: UnitPrefix, type: TargetUnitType, value: HugeFloat) {
        self.prefix = prefix
        self.type = type
        self.value = value
    }
    
    public func convert_value_to_unit(_ unit: TemperatureUnitType) -> HugeFloat {
        switch type {
            
        case .celsius:
            switch unit {
            case .celsius: return value
            case .fahrenheit: return (value * HugeFloat(integer: HugeInt("1"), remainder: HugeRemainder(dividend: "4", divisor: "5"))) + HugeFloat("32")
            case .kelvin: return value + HugeFloat(integer: HugeInt("273"), remainder: HugeRemainder(dividend: "15", divisor: "100"))
            case .rankine: return (value + HugeFloat(integer: HugeInt("273"), remainder: HugeRemainder(dividend: "15", divisor: "100"))) * HugeFloat(integer: HugeInt("1"), remainder: HugeRemainder(dividend: "4", divisor: "5"))
            }
            
        case .fahrenheit:
            switch unit {
            case .celsius: return (value - HugeFloat("32")) * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "5", divisor: "9"))
            case .fahrenheit: return value
            case .kelvin: return (value + HugeFloat(integer: HugeInt("459"), remainder: HugeRemainder(dividend: "67", divisor: "100"))) * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "5", divisor: "9"))
            case .rankine: return value + HugeFloat(integer: HugeInt("459"), remainder: HugeRemainder(dividend: "67", divisor: "100"))
            }
            
        case .kelvin:
            switch unit {
            case .celsius: return value - HugeFloat(integer: HugeInt("273"), remainder: HugeRemainder(dividend: "15", divisor: "100"))
            case .fahrenheit: return (HugeFloat(integer: HugeInt("1"), remainder: HugeRemainder(dividend: "8", divisor: "10")) * value) - HugeFloat(integer: HugeInt("459"), remainder: HugeRemainder(dividend: "67", divisor: "100"))
            case .kelvin: return value
            case .rankine: return HugeFloat(integer: HugeInt("1"), remainder: HugeRemainder(dividend: "8", divisor: "10")) * value
            }
            
        case .rankine:
            switch unit {
            case .celsius: return (value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "5", divisor: "9"))) - HugeFloat(integer: HugeInt("273"), remainder: HugeRemainder(dividend: "15", divisor: "100"))
            case .fahrenheit: return value - HugeFloat(integer: HugeInt("459"), remainder: HugeRemainder(dividend: "67", divisor: "100"))
            case .kelvin: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "5", divisor: "9"))
            case .rankine: return value
            }
        }
    }
}
