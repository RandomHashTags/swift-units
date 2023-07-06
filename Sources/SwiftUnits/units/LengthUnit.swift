//
//  LengthUnit.swift
//
//
//  Created by Evan Anderson on 7/6/23.
//

import Foundation
import HugeNumbers

public struct LengthUnit : Unit {
    public typealias TargetUnitType = LengthUnitType
    
    public var prefix:UnitPrefix
    public var type:TargetUnitType
    public var value:HugeFloat
    
    public init(prefix: UnitPrefix, type: TargetUnitType, value: HugeFloat) {
        self.prefix = prefix
        self.type = type
        self.value = value
    }
    
    public func convert_value_to_unit(_ unit: LengthUnitType) -> HugeFloat {
        switch type {
            
        case .metre:
            switch unit {
            case .metre: return value
            case .nautical_mile: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "1852"))
            case .mile: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "125", divisor: "201168"))
            case .furlong: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "125", divisor: "25146"))
            case .yard: return value * HugeFloat(integer: HugeInt.one, remainder: HugeRemainder(dividend: "107", divisor: "1143"))
            case .foot: return value * HugeFloat(integer: HugeInt("3"), remainder: HugeRemainder(dividend: "107", divisor: "381"))
            case .inch: return value * HugeFloat(integer: HugeInt("39"), remainder: HugeRemainder(dividend: "47", divisor: "127"))
            }
            
        case .nautical_mile:
            switch unit {
            case .metre: return value * HugeFloat("1852")
            case .nautical_mile: return value
            case .mile: return value * HugeFloat(integer: HugeInt.one, remainder: HugeRemainder(dividend: "7583", divisor: "50292"))
            case .furlong: return value * HugeFloat(integer: HugeInt("9"), remainder: HugeRemainder(dividend: "2593", divisor: "12573"))
            case .yard: return value * HugeFloat(integer: HugeInt("2025"), remainder: HugeRemainder(dividend: "425", divisor: "1143"))
            case .foot: return value * HugeFloat(integer: HugeInt("6076"), remainder: HugeRemainder(dividend: "44", divisor: "381"))
            case .inch: return value * HugeFloat(integer: HugeInt("72913"), remainder: HugeRemainder(dividend: "49", divisor: "127"))
            }
            
        case .mile:
            switch unit {
            case .metre: return value * HugeFloat("1609.344")
            case .nautical_mile: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "50292", divisor: "57875"))
            case .mile: return value
            case .furlong: return value * HugeFloat("8")
            case .yard: return value * HugeFloat("1760")
            case .foot: return value * HugeFloat("5280")
            case .inch: return value * HugeFloat("63360")
            }
            
        case .furlong:
            switch unit {
            case .metre: return value * HugeFloat("201.168")
            case .nautical_mile: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "12573", divisor: "115750"))
            case .mile: return value * HugeFloat("0.125")
            case .furlong: return value
            case .yard: return value * HugeFloat("220")
            case .foot: return value * HugeFloat("660")
            case .inch: return value * HugeFloat("7920")
            }
            
        case .yard:
            switch unit {
            case .metre: return value * HugeFloat("0.9144")
            case .nautical_mile: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1143", divisor: "2315000"))
            case .mile: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "1760"))
            case .furlong: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "220"))
            case .yard: return value
            case .foot: return value * HugeFloat("3")
            case .inch: return value * HugeFloat("36")
            }
            
        case .foot:
            switch unit {
            case .metre: return value * HugeFloat("0.3048")
            case .nautical_mile: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "381", divisor: "2315000"))
            case .mile: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "5280"))
            case .furlong: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "660"))
            case .yard: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "3"))
            case .foot: return value
            case .inch: return value * HugeFloat("12")
            }
            
        case .inch:
            switch unit {
            case .metre: return value * HugeFloat("0.0254")
            case .nautical_mile: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "127", divisor: "9260000"))
            case .mile: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "63360"))
            case .furlong: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "7920"))
            case .yard: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "36"))
            case .foot: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "1", divisor: "12"))
            case .inch: return value
            }
        }
    }
}
