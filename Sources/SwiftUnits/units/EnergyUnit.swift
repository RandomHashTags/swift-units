//
//  EnergyUnit.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation
import HugeNumbers

public struct EnergyUnit : Unit {
    public typealias TargetUnitType = EnergyUnitType
    
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
            
        case .joule:
            switch unit {
            case .joule: return value
            case .electronvolt: return value * HugeFloat("6241509343260179456")
            }
            
        case .electronvolt:
            switch unit {
            case .joule: return value / HugeFloat("6241509343260179456")
            case .electronvolt: return value
            }
        }
    }
    
    /// Converts this ``EnergyUnit`` to a ``MassUnit``. Default is the kilogram.
    public func to_mass(unit_prefix: UnitPrefix = UnitPrefix.kilo, unit_type: MassUnitType = MassUnitType.gram) -> MassUnit {
        let kilograms_value:HugeFloat = convert_value_to_unit(EnergyUnitType.joule) / MathmaticalConstant.speed_of_light_in_a_vacuum_squared.value
        let kilograms:MassUnit = MassUnit(prefix: UnitPrefix.kilo, type: MassUnitType.gram, value: kilograms_value)
        return kilograms.to_unit(prefix: unit_prefix, unit: unit_type)
    }
}
