//
//  UnitCategory.swift
//
//
//  Created by Evan Anderson on 7/7/23.
//

import Foundation

public enum UnitCategory : String, CaseIterable {
    case acceleration
    case action
    case density
    case electric_charge
    case electric_potential
    case energy
    case force
    case frequency
    case length
    case mass
    case pressure
    case speed
    case temperature
    case time
    
    var unit_type : any UnitType.Type {
        switch self {
        case .acceleration: return AccelerationUnitType.self
        case .action: return ActionUnitType.self
        case .density: return DensityUnitType.self
        case .electric_charge: return ElectricChargeUnitType.self
        case .electric_potential: return ElectricPotentialUnitType.self
        case .energy: return EnergyUnitType.self
        case .force: return ForceUnitType.self
        case .frequency: return FrequencyUnitType.self
        case .length: return LengthUnitType.self
        case .mass: return MassUnitType.self
        case .pressure: return PressureUnitType.self
        case .speed: return SpeedUnitType.self
        case .temperature: return TemperatureUnitType.self
        case .time: return TimeUnitType.self
        }
    }
}
