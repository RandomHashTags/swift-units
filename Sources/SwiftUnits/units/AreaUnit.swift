//
//  AreaUnit.swift
//
//
//  Created by Evan Anderson on 1/22/24.
//

import Foundation
import HugeNumbers

public struct AreaUnit : Unit {
    public typealias TargetUnitType = AreaUnitType
    
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
            
        case .square_metre:
            switch unit {
            case .square_metre: return value
                
            case .square_mile: return value / HugeFloat("2589988.110336")
            case .square_yard: return value / HugeFloat("0.83612736")
            case .square_foot: return value / HugeFloat("0.09290304")
            case .square_inch: return value * HugeFloat("1550.0031000062")
            }
            
        case .square_mile:
            switch unit {
            case .square_metre: return value * HugeFloat("2589988.110336")
                
            case .square_mile: return value
            case .square_yard: return value * HugeFloat("3097600")
            case .square_foot: return value * HugeFloat("27878400")
            case .square_inch: return value * HugeFloat("4014489600")
            }
            
        case .square_yard:
            switch unit {
            case .square_metre: return value * HugeFloat("0.83612736")
                
            case .square_mile: return value / HugeFloat("3097600")
            case .square_yard: return value
            case .square_foot: return value * HugeFloat("9")
            case .square_inch: return value * HugeFloat("1296")
            }
            
        case .square_foot:
            switch unit {
            case .square_metre: return value * HugeFloat("0.09290304")
                
            case .square_mile: return value / HugeFloat("27878400")
            case .square_yard: return value / HugeFloat("9")
            case .square_foot: return value
            case .square_inch: return value * HugeFloat("144")
            }
            
        case .square_inch:
            switch unit {
            case .square_metre: return value / HugeFloat("1550.0031000062")
                
            case .square_mile: return value / HugeFloat("4014489600")
            case .square_yard: return value / HugeFloat("1296")
            case .square_foot: return value / HugeFloat("144")
            case .square_inch: return value
            }
        }
    }
}
