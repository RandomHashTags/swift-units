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
    case area
    case density
    case electric_charge
    case electric_current
    case electric_potential
    case electric_power
    case electric_resistance
    case energy
    case force
    case frequency
    case heat_capacity
    case illuminance
    case length
    case luminous_flux
    case luminous_intensity
    case magnetic_induction
    case mass
    case pressure
    case speed
    case substance
    case temperature
    case time
    //case volume // TODO: support
    
    var unit_type : any UnitType.Type {
        switch self {
        case .acceleration: return AccelerationUnitType.self
        case .action: return ActionUnitType.self
        case .area: return AreaUnitType.self
        case .density: return DensityUnitType.self
        case .electric_charge: return ElectricChargeUnitType.self
        case .electric_current: return ElectricCurrentUnitType.self
        case .electric_potential: return ElectricPotentialUnitType.self
        case .electric_power: return ElectricPowerUnitType.self
        case .electric_resistance: return ElectricResistanceUnitType.self
        case .energy: return EnergyUnitType.self
        case .force: return ForceUnitType.self
        case .frequency: return FrequencyUnitType.self
        case .heat_capacity: return HeatCapacityUnitType.self
        case .illuminance: return IlluminanceUnitType.self
        case .length: return LengthUnitType.self
        case .luminous_flux: return LuminousFluxUnitType.self
        case .luminous_intensity: return LuminousIntensityUnitType.self
        case .magnetic_induction: return MagneticInductionUnitType.self
        case .mass: return MassUnitType.self
        case .pressure: return PressureUnitType.self
        case .speed: return SpeedUnitType.self
        case .substance: return SubstanceUnitType.self
        case .temperature: return TemperatureUnitType.self
        case .time: return TimeUnitType.self
        //case .volume: return VolumeUnitType.self
        }
    }
}
