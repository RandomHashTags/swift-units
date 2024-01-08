//
//  MathmaticalConstant.swift
//
//  Created by Evan Anderson on 4/5/23.
//

import Foundation
import HugeNumbers

public enum MathmaticalConstant {
    public static let speed_of_light_in_a_vacuum:SpeedUnit = SpeedUnit(type: SpeedUnitType.metre_per_second, value: "299792458")
    public static let speed_of_light_in_a_vacuum_squared:SpeedUnit = SpeedUnit(type: SpeedUnitType.metre_per_second, value: HugeFloat("299792458") * HugeFloat("299792458"))
    
    /// Exactly `6.62607015×10^−34 Joule per Hertz`, as defined at https://en.wikipedia.org/wiki/Planck_constant .
    public static let planck_constant:ActionUnit = ActionUnit(type: ActionUnitType.joule_second, value: "0.000000000000000000000000000000000662607015")
    
    /// Exactly `160.2176634 zeptocoulombs`, as defined at https://en.wikipedia.org/wiki/Elementary_charge .
    public static let elementary_charge:ElectricChargeUnit = ElectricChargeUnit(prefix: UnitPrefix.zepto, type: ElectricChargeUnitType.coulomb, value: "160.2176634")
    
    /// Exactly `273.15 degrees Kelvin`, as defined at https://en.wikipedia.org/wiki/Standard_temperature_and_pressure .
    public static let standard_temperature:TemperatureUnit = TemperatureUnit(type: TemperatureUnitType.kelvin, value: "273.15")
    /// Exactly `100 kiloPascals`, as defined at https://en.wikipedia.org/wiki/Standard_temperature_and_pressure .
    public static let standard_pressure:PressureUnit = PressureUnit(prefix: UnitPrefix.kilo, type: PressureUnitType.pascal, value: "100")
    
    /// Exactly `9.80665 meters per second squared`, as defined at https://en.wikipedia.org/wiki/Gravity_of_Earth .
    public static let standard_gravity:AccelerationUnit = AccelerationUnit(type: AccelerationUnitType.metres_per_second_per_second, value: "9.80665")
    
    /// Exactly `1.380649×10^-23 Joule per Kelvin`, as defined at https://en.wikipedia.org/wiki/Boltzmann_constant .
    public static let boltzmann_constant:HeatCapacityUnit = HeatCapacityUnit(type: HeatCapacityUnitType.joule_per_kelvin, value: "0.00000000000000000000001380649")
}
