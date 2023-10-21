//
//  SpeedUnit.swift
//
//  Created by Evan Anderson on 4/5/23.
//

import Foundation
import HugeNumbers

public struct SpeedUnit : Unit {
    public typealias TargetUnitType = SpeedUnitType
    
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
            
        case .metre_per_second:
            switch unit {
            case .metre_per_second: return value
            case .kilometre_per_hour: return value * HugeFloat("3.6")
            case .mile_per_hour: return value * HugeFloat(integer: HugeInt("2"), remainder: HugeRemainder(dividend: "331", divisor: "1397"))
            case .knot: return value * HugeFloat(integer: HugeInt.one, remainder: HugeRemainder(dividend: "437", divisor: "463"))
            case .foot_per_second: return value * HugeFloat(integer: HugeInt("3"), remainder: HugeRemainder(dividend: "107", divisor: "381"))
            }
            
        case .kilometre_per_hour:
            switch unit {
            case .metre_per_second: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "5", divisor: "18"))
            case .kilometre_per_hour: return value
            case .mile_per_hour: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "15625", divisor: "25146"))
            case .knot: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "250", divisor: "463"))
            case .foot_per_second: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "3125", divisor: "3429"))
            }
            
        case .mile_per_hour:
            switch unit {
            case .metre_per_second: return value * HugeFloat("0.44704")
            case .kilometre_per_hour: return value * HugeFloat("1.609344")
            case .mile_per_hour: return value
            case .knot: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "50292", divisor: "57875"))
            case .foot_per_second: return value * HugeFloat(integer: HugeInt.one, remainder: HugeRemainder(dividend: "7", divisor: "15"))
            }
            
        case .knot:
            switch unit {
            case .metre_per_second: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "463", divisor: "900"))
            case .kilometre_per_hour: return value * HugeFloat("1.852")
            case .mile_per_hour: return value * HugeFloat(integer: HugeInt.one, remainder: HugeRemainder(dividend: "7583", divisor: "50292"))
            case .knot: return value
            case .foot_per_second: return value * HugeFloat(integer: HugeInt.one, remainder: HugeRemainder(dividend: "4717", divisor: "6858"))
            }
            
        case .foot_per_second:
            switch unit {
            case .metre_per_second: return value * HugeFloat("0.3048")
            case .kilometre_per_hour: return value * HugeFloat("1.09728")
            case .mile_per_hour: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "15", divisor: "22"))
            case .knot: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "6858", divisor: "11575"))
            case .foot_per_second: return value
            }
        }
    }
}
