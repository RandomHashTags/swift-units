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
    
    public func convert_value_to_unit(_ unit: SpeedUnitType) -> HugeFloat {
        switch type {
            
        case .metre_per_second:
            switch unit {
            case .metre_per_second: return value
            case .kilometre_per_hour: return value * HugeFloat("3.6")
            case .mile_per_hour: return value * HugeFloat("2.236936")
            case .knot: return value * HugeFloat("1.943844")
            case .foot_per_second: return value * HugeFloat("3.280840")
            }
            
        case .kilometre_per_hour:
            switch unit {
            case .metre_per_second: return value * HugeFloat("0.277778")
            case .kilometre_per_hour: return value
            case .mile_per_hour: return value * HugeFloat("0.621371")
            case .knot: return value * HugeFloat("0.539957")
            case .foot_per_second: return value * HugeFloat("0.911344")
            }
            
        case .mile_per_hour:
            switch unit {
            case .metre_per_second: return value * HugeFloat("0.44704")
            case .kilometre_per_hour: return value * HugeFloat("1.609344")
            case .mile_per_hour: return value
            case .knot: return value * HugeFloat("0.868976")
            case .foot_per_second: return value * HugeFloat("1.466667")
            }
            
        case .knot:
            switch unit {
            case .metre_per_second: return value * HugeFloat("0.514444")
            case .kilometre_per_hour: return value * HugeFloat("1.852")
            case .mile_per_hour: return value * HugeFloat("1.150779")
            case .knot: return value
            case .foot_per_second: return value * HugeFloat("1.68810")
            }
            
        case .foot_per_second:
            switch unit {
            case .metre_per_second: return value * HugeFloat("0.3048")
            case .kilometre_per_hour: return value * HugeFloat("1.09728")
            case .mile_per_hour: return value * HugeFloat("0.681818")
            case .knot: return value * HugeFloat("0.592484")
            case .foot_per_second: return value
            }
        }
    }
}
