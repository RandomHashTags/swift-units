//
//  TimeUnit.swift
//  
//
//  Created by Evan Anderson on 4/25/23.
//

import Foundation
import HugeNumbers

public struct TimeUnit : Unit {
    public typealias TargetUnitType = TimeUnitType
    
    public var prefix:UnitPrefix
    public var type:TargetUnitType
    public var value:HugeFloat
    
    public init(prefix: UnitPrefix, type: TargetUnitType, value: HugeFloat) {
        self.prefix = prefix
        self.type = type
        self.value = value
    }
    
    public func convert_value_to_unit(_ unit: TimeUnitType) -> HugeFloat {
        switch type {
            
        case .second:
            switch unit {
            case .second: return value
            case .minute: return value / HugeFloat("60")
            case .hour: return value / HugeFloat("3600")
            case .day: return value / HugeFloat("86400")
            case .week: return value / HugeFloat("604800")
            case .month: return value / HugeFloat("2592000")
            case .year: return value / HugeFloat("31557600")
            case .decade: return value / HugeFloat("315576000")
            case .century: return value / HugeFloat("3155760000")
            case .millennium: return value / HugeFloat("31557600000")
            }
            
        case .minute:
            switch unit {
            case .second: return value * HugeFloat("60")
            case .minute: return value
            case .hour: return value / HugeFloat("60")
            case .day: return value / HugeFloat("1440")
            case .week: return value / HugeFloat("10080")
            case .month: return value / HugeFloat("43200")
            case .year: return value / HugeFloat("525960")
            case .decade: return value / HugeFloat("5259600")
            case .century: return value / HugeFloat("52596000")
            case .millennium: return value / HugeFloat("525960000") 
            }
            
        case .hour:
            switch unit {
            case .second: return value * HugeFloat("3600")
            case .minute: return value * HugeFloat("60")
            case .hour: return value
            case .day: return value / HugeFloat("24")
            case .week: return value / HugeFloat("168")
            case .month: return value / HugeFloat("720")
            case .year: return value / HugeFloat("8766")
            case .decade: return value / HugeFloat("87660")
            case .century: return value / HugeFloat("876600")
            case .millennium: return value / HugeFloat("8766000")
            }
            
        case .day:
            switch unit {
            case .second: return value * HugeFloat("86400")
            case .minute: return value * HugeFloat("1440")
            case .hour: return value * HugeFloat("24")
            case .day: return value
            case .week: return value / HugeFloat("7")
            case .month: return value / HugeFloat("30")
            case .year: return value / HugeFloat(integer: HugeInt("365"), remainder: HugeRemainder(dividend: "1", divisor: "4"))
            case .decade: return value / HugeFloat(integer: HugeInt("3652"), remainder: HugeRemainder(dividend: "1", divisor: "2"))
            case .century: return value / HugeFloat("36525")
            case .millennium: return value / HugeFloat("365250")
            }
            
        case .week:
            switch unit {
            case .second: return value * HugeFloat("604800")
            case .minute: return value * HugeFloat("10080")
            case .hour: return value * HugeFloat("168")
            case .day: return value * HugeFloat("7")
            case .week: return value
            case .month: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "7", divisor: "30"))
            case .year: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "28", divisor: "1461"))
            case .decade: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "14", divisor: "7305"))
            case .century: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "7", divisor: "36525"))
            case .millennium: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "7", divisor: "365250"))
            }
            
        case .month:
            switch unit {
            case .second: return value * HugeFloat("414720")
            case .minute: return value * HugeFloat("17280")
            case .hour: return value * HugeFloat("720")
            case .day: return value * HugeFloat("30")
            case .week: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "30", divisor: "7"))
            case .month: return value
            case .year: return value / HugeFloat("12") // TODO: fix
            case .decade: return value / HugeFloat("120") // TODO: fix
            case .century: return value / HugeFloat("1200") // TODO: fix
            case .millennium: return value / HugeFloat("12000") // TODO: fix
            }
            
        case .year:
            switch unit {
            case .second: return value * HugeFloat("31557600")
            case .minute: return value * HugeFloat("525960")
            case .hour: return value * HugeFloat("8766")
            case .day: return value * HugeFloat(integer: HugeInt("365"), remainder: HugeRemainder(dividend: "1", divisor: "4"))
            case .week: return value * HugeFloat(integer: HugeInt("52"), remainder: HugeRemainder(dividend: "1", divisor: "8")) // TODO: fix
            case .month: return value * HugeFloat("12")
            case .year: return value
            case .decade: return value.multiply_by_ten(-1)
            case .century: return value.multiply_by_ten(-2)
            case .millennium: return value.multiply_by_ten(-3)
            }
            
        case .decade:
            switch unit {
            case .second: return value * HugeFloat("315576000")
            case .minute: return value * HugeFloat("5259600")
            case .hour: return value * HugeFloat("87660")
            case .day: return value * HugeFloat(integer: "3652", remainder: HugeRemainder(dividend: "1", divisor: "2"))
            case .week: return value * HugeFloat("520") // TODO: fix
            case .month: return value * HugeFloat("120") // TODO: fix
            case .year: return value.multiply_by_ten(1)
            case .decade: return value
            case .century: return value.multiply_by_ten(-1)
            case .millennium: return value.multiply_by_ten(-2)
            }
            
        case .century:
            switch unit {
            case .second: return value * HugeFloat("3155760000")
            case .minute: return value * HugeFloat("52596000")
            case .hour: return value * HugeFloat("876600")
            case .day: return value * HugeFloat("36525")
            case .week: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "36525", divisor: "7"))
            case .month: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "36525", divisor: "30"))
            case .year: return value.multiply_by_ten(2)
            case .decade: return value.multiply_by_ten(1)
            case .century: return value
            case .millennium: return value.multiply_by_ten(-1)
            }
            
        case .millennium:
            switch unit {
            case .second: return value * HugeFloat("31557600000")
            case .minute: return value * HugeFloat("525960000")
            case .hour: return value * HugeFloat("8766000")
            case .day: return value * HugeFloat("365250")
            case .week: return value * HugeFloat(integer: HugeInt.zero, remainder: HugeRemainder(dividend: "365250", divisor: "7"))
            case .month: return value * HugeFloat("12175")
            case .year: return value.multiply_by_ten(3)
            case .decade: return value.multiply_by_ten(2)
            case .century: return value.multiply_by_ten(1)
            case .millennium: return value
            }
        }
    }
}
