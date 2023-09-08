//
//  VolumeUnit.swift
//  
//
//  Created by Evan Anderson on 9/7/23.
//

import Foundation
import HugeNumbers

public struct VolumeUnit : Unit {
    public typealias TargetUnitType = VolumeUnitType
    
    public var prefix:UnitPrefix
    public var type:TargetUnitType
    public var value:HugeFloat
    
    public init(prefix: UnitPrefix, type: TargetUnitType, value: HugeFloat) {
        self.prefix = prefix
        self.type = type
        self.value = value
    }
    
    public func convert_value_to_unit(_ unit: TargetUnitType) -> HugeFloat {
        return value // TODO: fix (not exact conversions)
        /*
        switch type {
        case .cubic_centimetre:
            switch unit {
            case .cubic_centimetre: return value
            case .cubic_inch: return value * HugeFloat("0.061023744094732")
            case .pint: return value * HugeFloat("0.0021133764188652")
            case .cubic_decimetre: return value.move_decimal(-3)
            case .litre: return value.move_decimal(-3)
            case .gallon: return value * HugeFloat("0.00026417205235815")
            case .cubic_foot: return value * HugeFloat("0.000035314666721489")
            case .barrel: return value * HugeFloat("0.0000083864143605761")
            case .cubic_metre: return value.move_decimal(-6)
            }
            
        case .cubic_inch:
            switch unit {
            case .cubic_inch: return value
            case .litre: return value * HugeFloat("0.016387064")
            case .cubic_metre: return value * HugeFloat("0.000016387064")
            }
            
        case .pint:
            switch unit {
            case .pint: return value
            case .litre: return value * HugeFloat("0.473176473")
            case .cubic_metre: return value * HugeFloat("0.000473176473")
            }
            
        case .cubic_decimetre:
            switch unit {
            case .cubic_centimetre: return value
            case .litre: return value
            case .cubic_metre: return value.move_decimal(-3)
            }
            
        case .litre:
            switch unit {
            case .cubic_centimetre: return value.move_decimal(3)
            case .cubic_inch: return value * HugeFloat("61.023744094732")
            case .pint: return value * HugeFloat("2.1133764188652")
            case .cubic_decimetre: return value
            case .litre: return value
            case .gallon: return value * HugeFloat("0.26417205235815")
            case .cubic_foot: return value * HugeFloat("0.035314666721489")
            case .barrel: return value * HugeFloat("0.008386414360576102")
            case .cubic_metre: return value.move_decimal(-3)
            }
            
        case .gallon:
            switch unit {
            case .cubic_centimetre: return value * HugeFloat("3785.411784")
            case .litre: return value
            case .gallon: return value * HugeFloat("3.785411784")
            case .cubic_metre: return value * HugeFloat("0.003785411784")
            }
            
        case .cubic_foot:
            switch unit {
            case .litre: return value * HugeFloat("28.316864592")
            case .cubic_foot: return value
            case .cubic_metre: return value * HugeFloat("0.028316846592")
            }
            
        case .barrel:
            switch unit {
            case .litre: return value * HugeFloat("158.987294928")
            case .barrel: return value
            case .cubic_metre: return value * HugeFloat("0.158987294928")
            }
            
        case .cubic_metre:
            switch unit {
            case .cubic_centimetre: return value.move_decimal(6)
            case .cubic_inch: return value * HugeFloat("61023.744094732")
            case .pint: return value * HugeFloat("2113.3764189")
            case .cubic_decimetre: return value.move_decimal(3)
            case .litre: return value.move_decimal(3)
            case .gallon: return value * HugeFloat("264.17205236")
            case .cubic_foot: return value * HugeFloat("35.314666721")
            case .barrel: return value * HugeFloat("8.3864143606")
            case .cubic_metre: return value
            }
        }*/
    }
}
