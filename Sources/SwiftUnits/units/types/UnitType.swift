//
//  UnitType.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation
import HugeNumbers

/// An enum that contains all the unit types of a certain value. The unit types should be organized in decending order by order of magnitude. (Every case is greater than the case above it)
public protocol UnitType : Identifiable, CaseIterable, Hashable, RawRepresentable where RawValue == String, ID == String, StringLiteralType == String {
    static var category : UnitCategory { get }
    
    var symbol : String { get }
    
    // TODO: fix (String.LocalizationValue returns incorrect value when not using literals)
    /// Gets the localized name of this unit type, respecting singular and plural localization.
    func name(_ quantity: HugeInt) -> String
    func name(_ quantity: HugeFloat) -> String
    func name(_ quantity: Int) -> String
}

extension String.LocalizationValue.StringInterpolation {
    mutating func appendLiteral(_ value: HugeInt) {
        // TODO: fix (doesn't support any number larger than UInt64.max)
        let number:Int = value.to_int() ?? -1
        appendInterpolation(number)
    }
    mutating func appendInterpolation(_ value: HugeInt) {
        appendLiteral(value)
    }
    
    mutating func appendLiteral(_ value: HugeFloat) {
        // TODO: fix (doesn't support any number larger than Double.max -> gets represented as an infinity symbol; only supports 6 decimal digits; can only be represented in base 2)
        let number:Float = value.represented_float
        appendInterpolation(number)
    }
    mutating func appendInterpolation(_ value: HugeFloat) {
        appendLiteral(value)
    }
}

public extension UnitType {
    var id : String {
        return rawValue
    }
    
    func name(_ quantity: HugeInt) -> String {
        return get_name(quantity)
    }
    func name(_ quantity: HugeFloat) -> String {
        return get_name(quantity)
    }
    func name(_ quantity: Int) -> String {
        return get_name(quantity)
    }
    func name(_ quantity: Float) -> String {
        return get_name(quantity)
    }
    func name(_ quantity: Double) -> String {
        return get_name(quantity)
    }
    
    func is_less_than(_ unit: Self) -> Bool {
        let elements:Self.AllCases = Self.allCases
        return elements.firstIndex(of: self)! < elements.firstIndex(of: unit)!
    }
    func is_less_than_or_equal_to(_ unit: Self) -> Bool {
        let elements:Self.AllCases = Self.allCases
        return elements.firstIndex(of: self)! <= elements.firstIndex(of: unit)!
    }
    
    func is_greater_than(_ unit: Self) -> Bool {
        let elements:Self.AllCases = Self.allCases
        return elements.firstIndex(of: self)! > elements.firstIndex(of: unit)!
    }
    func is_greater_than_or_equal_to(_ unit: Self) -> Bool {
        let elements:Self.AllCases = Self.allCases
        return elements.firstIndex(of: self)! >= elements.firstIndex(of: unit)!
    }
}

extension UnitType {
    func get_name(_ quantity: HugeInt) -> String {
        let key:String.LocalizationValue
        switch Self.category {
        case .acceleration:
            switch self as! AccelerationUnitType {
            case .metres_per_second_per_second:
                key = String.LocalizationValue("acceleration_metres_per_second_per_second \(quantity)")
                break
            }
        case .action:
            switch self as! ActionUnitType {
            case .joule_second:
                key = String.LocalizationValue("action_joule_second \(quantity)")
                break
            }
        case .density:
            switch self as! DensityUnitType {
            case .kilogram_per_cubic_metre:
                key = String.LocalizationValue("density_kilogram_per_cubic_metre \(quantity)")
                break
            case .gram_per_cubic_centimetre:
                key = String.LocalizationValue("density_gram_per_cubic_centimetre \(quantity)")
                break
            }
        case .electric_charge:
            switch self as! ElectricChargeUnitType {
            case .coulomb:
                key = String.LocalizationValue("electric_charge_coulomb \(quantity)")
                break
            }
        case .energy:
            switch self as! EnergyUnitType {
            case .electronvolt:
                key = String.LocalizationValue("energy_electronvolt \(quantity)")
                break
            case .joule:
                key = String.LocalizationValue("energy_joule \(quantity)")
                break
            }
        case .force:
            switch self as! ForceUnitType {
            case .newton:
                key = String.LocalizationValue("force_newton \(quantity)")
                break
            }
        case .frequency:
            switch self as! FrequencyUnitType {
            case .wavelength_in_metres:
                key = String.LocalizationValue("frequency_wavelength_in_metres \(quantity)")
                break
            case .hertz:
                key = String.LocalizationValue("frequency_hertz \(quantity)")
                break
            }
        case .length:
            switch self as! LengthUnitType {
            case .metre:
                key = String.LocalizationValue("length_metre \(quantity)")
                break
            case .nautical_mile:
                key = String.LocalizationValue("length_nautical_mile \(quantity)")
                break
            case .mile:
                key = String.LocalizationValue("length_mile \(quantity)")
                break
            case .furlong:
                key = String.LocalizationValue("length_furlong \(quantity)")
                break
            case .yard:
                key = String.LocalizationValue("length_yard \(quantity)")
                break
            case .foot:
                key = String.LocalizationValue("length_foot \(quantity)")
                break
            case .inch:
                key = String.LocalizationValue("length_inch \(quantity)")
                break
            }
        case .mass:
            switch self as! MassUnitType {
            case .dalton:
                key = String.LocalizationValue("mass_dalton \(quantity)")
                break
            case .gram:
                key = String.LocalizationValue("mass_gram \(quantity)")
                break
            case .ounce:
                key = String.LocalizationValue("mass_ounce \(quantity)")
                break
            case .pound:
                key = String.LocalizationValue("mass_pound \(quantity)")
                break
            case .tonne:
                key = String.LocalizationValue("mass_tonne \(quantity)")
                break
            }
        case .pressure:
            switch self as! PressureUnitType {
            case .pascal:
                key = String.LocalizationValue("pressure_pascal \(quantity)")
                break
            case .pound_per_square_inch:
                key = String.LocalizationValue("pressure_pound_per_square_inch \(quantity)")
                break
            case .standard_atmosphere:
                key = String.LocalizationValue("pressure_standard_atmosphere \(quantity)")
                break
            }
        case .speed:
            switch self as! SpeedUnitType {
            case .metre_per_second:
                key = String.LocalizationValue("speed_metre_per_second \(quantity)")
                break
            case .kilometre_per_hour:
                key = String.LocalizationValue("speed_kilometre_per_hour \(quantity)")
                break
            case .mile_per_hour:
                key = String.LocalizationValue("speed_mile_per_hour \(quantity)")
                break
            case .knot:
                key = String.LocalizationValue("speed_knot \(quantity)")
                break
            case .foot_per_second:
                key = String.LocalizationValue("speed_foot_per_second \(quantity)")
                break
            }
        case .temperature:
            switch self as! TemperatureUnitType {
            case .fahrenheit:
                key = String.LocalizationValue("temperature_fahrenheit \(quantity)")
                break
            case .celsius:
                key = String.LocalizationValue("temperature_celsius \(quantity)")
                break
            case .kelvin:
                key = String.LocalizationValue("temperature_kelvin \(quantity)")
                break
            case .rankine:
                key = String.LocalizationValue("temperature_rankine \(quantity)")
                break
            }
        case .time:
            switch self as! TimeUnitType {
            case .second:
                key = String.LocalizationValue("time_second \(quantity)")
                break
            case .minute:
                key = String.LocalizationValue("time_minute \(quantity)")
                break
            case .hour:
                key = String.LocalizationValue("time_hour \(quantity)")
                break
            case .day:
                key = String.LocalizationValue("time_day \(quantity)")
                break
            case .week:
                key = String.LocalizationValue("time_week \(quantity)")
                break
            case .month:
                key = String.LocalizationValue("time_month \(quantity)")
                break
            case .year:
                key = String.LocalizationValue("time_year \(quantity)")
                break
            case .decade:
                key = String.LocalizationValue("time_decade \(quantity)")
                break
            case .century:
                key = String.LocalizationValue("time_century \(quantity)")
                break
            case .millennium:
                key = String.LocalizationValue("time_millennium \(quantity)")
                break
            }
        }
        return String(localized: key, table: "Units", bundle: Bundle.module)
    }
    
    func get_name(_ quantity: HugeFloat) -> String {
        let key:String.LocalizationValue
        switch Self.category {
        case .acceleration:
            switch self as! AccelerationUnitType {
            case .metres_per_second_per_second:
                key = String.LocalizationValue("acceleration_metres_per_second_per_second \(quantity)")
                break
            }
        case .action:
            switch self as! ActionUnitType {
            case .joule_second:
                key = String.LocalizationValue("action_joule_second \(quantity)")
                break
            }
        case .density:
            switch self as! DensityUnitType {
            case .kilogram_per_cubic_metre:
                key = String.LocalizationValue("density_kilogram_per_cubic_metre \(quantity)")
                break
            case .gram_per_cubic_centimetre:
                key = String.LocalizationValue("density_gram_per_cubic_centimetre \(quantity)")
                break
            }
        case .electric_charge:
            switch self as! ElectricChargeUnitType {
            case .coulomb:
                key = String.LocalizationValue("electric_charge_coulomb \(quantity)")
                break
            }
        case .energy:
            switch self as! EnergyUnitType {
            case .electronvolt:
                key = String.LocalizationValue("energy_electronvolt \(quantity)")
                break
            case .joule:
                key = String.LocalizationValue("energy_joule \(quantity)")
                break
            }
        case .force:
            switch self as! ForceUnitType {
            case .newton:
                key = String.LocalizationValue("force_newton \(quantity)")
                break
            }
        case .frequency:
            switch self as! FrequencyUnitType {
            case .wavelength_in_metres:
                key = String.LocalizationValue("frequency_wavelength_in_metres \(quantity)")
                break
            case .hertz:
                key = String.LocalizationValue("frequency_hertz \(quantity)")
                break
            }
        case .length:
            switch self as! LengthUnitType {
            case .metre:
                key = String.LocalizationValue("length_metre \(quantity)")
                break
            case .nautical_mile:
                key = String.LocalizationValue("length_nautical_mile \(quantity)")
                break
            case .mile:
                key = String.LocalizationValue("length_mile \(quantity)")
                break
            case .furlong:
                key = String.LocalizationValue("length_furlong \(quantity)")
                break
            case .yard:
                key = String.LocalizationValue("length_yard \(quantity)")
                break
            case .foot:
                key = String.LocalizationValue("length_foot \(quantity)")
                break
            case .inch:
                key = String.LocalizationValue("length_inch \(quantity)")
                break
            }
        case .mass:
            switch self as! MassUnitType {
            case .dalton:
                key = String.LocalizationValue("mass_dalton \(quantity)")
                break
            case .gram:
                key = String.LocalizationValue("mass_gram \(quantity)")
                break
            case .ounce:
                key = String.LocalizationValue("mass_ounce \(quantity)")
                break
            case .pound:
                key = String.LocalizationValue("mass_pound \(quantity)")
                break
            case .tonne:
                key = String.LocalizationValue("mass_tonne \(quantity)")
                break
            }
        case .pressure:
            switch self as! PressureUnitType {
            case .pascal:
                key = String.LocalizationValue("pressure_pascal \(quantity)")
                break
            case .pound_per_square_inch:
                key = String.LocalizationValue("pressure_pound_per_square_inch \(quantity)")
                break
            case .standard_atmosphere:
                key = String.LocalizationValue("pressure_standard_atmosphere \(quantity)")
                break
            }
        case .speed:
            switch self as! SpeedUnitType {
            case .metre_per_second:
                key = String.LocalizationValue("speed_metre_per_second \(quantity)")
                break
            case .kilometre_per_hour:
                key = String.LocalizationValue("speed_kilometre_per_hour \(quantity)")
                break
            case .mile_per_hour:
                key = String.LocalizationValue("speed_mile_per_hour \(quantity)")
                break
            case .knot:
                key = String.LocalizationValue("speed_knot \(quantity)")
                break
            case .foot_per_second:
                key = String.LocalizationValue("speed_foot_per_second \(quantity)")
                break
            }
        case .temperature:
            switch self as! TemperatureUnitType {
            case .fahrenheit:
                key = String.LocalizationValue("temperature_fahrenheit \(quantity)")
                break
            case .celsius:
                key = String.LocalizationValue("temperature_celsius \(quantity)")
                break
            case .kelvin:
                key = String.LocalizationValue("temperature_kelvin \(quantity)")
                break
            case .rankine:
                key = String.LocalizationValue("temperature_rankine \(quantity)")
                break
            }
        case .time:
            switch self as! TimeUnitType {
            case .second:
                key = String.LocalizationValue("time_second \(quantity)")
                break
            case .minute:
                key = String.LocalizationValue("time_minute \(quantity)")
                break
            case .hour:
                key = String.LocalizationValue("time_hour \(quantity)")
                break
            case .day:
                key = String.LocalizationValue("time_day \(quantity)")
                break
            case .week:
                key = String.LocalizationValue("time_week \(quantity)")
                break
            case .month:
                key = String.LocalizationValue("time_month \(quantity)")
                break
            case .year:
                key = String.LocalizationValue("time_year \(quantity)")
                break
            case .decade:
                key = String.LocalizationValue("time_decade \(quantity)")
                break
            case .century:
                key = String.LocalizationValue("time_century \(quantity)")
                break
            case .millennium:
                key = String.LocalizationValue("time_millennium \(quantity)")
                break
            }
        }
        return String(localized: key, table: "Units", bundle: Bundle.module)
    }
    
    func get_name(_ quantity: Int) -> String {
        let key:String.LocalizationValue
        switch Self.category {
        case .acceleration:
            switch self as! AccelerationUnitType {
            case .metres_per_second_per_second:
                key = String.LocalizationValue("acceleration_metres_per_second_per_second \(quantity)")
                break
            }
        case .action:
            switch self as! ActionUnitType {
            case .joule_second:
                key = String.LocalizationValue("action_joule_second \(quantity)")
                break
            }
        case .density:
            switch self as! DensityUnitType {
            case .kilogram_per_cubic_metre:
                key = String.LocalizationValue("density_kilogram_per_cubic_metre \(quantity)")
                break
            case .gram_per_cubic_centimetre:
                key = String.LocalizationValue("density_gram_per_cubic_centimetre \(quantity)")
                break
            }
        case .electric_charge:
            switch self as! ElectricChargeUnitType {
            case .coulomb:
                key = String.LocalizationValue("electric_charge_coulomb \(quantity)")
                break
            }
        case .energy:
            switch self as! EnergyUnitType {
            case .electronvolt:
                key = String.LocalizationValue("energy_electronvolt \(quantity)")
                break
            case .joule:
                key = String.LocalizationValue("energy_joule \(quantity)")
                break
            }
        case .force:
            switch self as! ForceUnitType {
            case .newton:
                key = String.LocalizationValue("force_newton \(quantity)")
                break
            }
        case .frequency:
            switch self as! FrequencyUnitType {
            case .wavelength_in_metres:
                key = String.LocalizationValue("frequency_wavelength_in_metres \(quantity)")
                break
            case .hertz:
                key = String.LocalizationValue("frequency_hertz \(quantity)")
                break
            }
        case .length:
            switch self as! LengthUnitType {
            case .metre:
                key = String.LocalizationValue("length_metre \(quantity)")
                break
            case .nautical_mile:
                key = String.LocalizationValue("length_nautical_mile \(quantity)")
                break
            case .mile:
                key = String.LocalizationValue("length_mile \(quantity)")
                break
            case .furlong:
                key = String.LocalizationValue("length_furlong \(quantity)")
                break
            case .yard:
                key = String.LocalizationValue("length_yard \(quantity)")
                break
            case .foot:
                key = String.LocalizationValue("length_foot \(quantity)")
                break
            case .inch:
                key = String.LocalizationValue("length_inch \(quantity)")
                break
            }
        case .mass:
            switch self as! MassUnitType {
            case .dalton:
                key = String.LocalizationValue("mass_dalton \(quantity)")
                break
            case .gram:
                key = String.LocalizationValue("mass_gram \(quantity)")
                break
            case .ounce:
                key = String.LocalizationValue("mass_ounce \(quantity)")
                break
            case .pound:
                key = String.LocalizationValue("mass_pound \(quantity)")
                break
            case .tonne:
                key = String.LocalizationValue("mass_tonne \(quantity)")
                break
            }
        case .pressure:
            switch self as! PressureUnitType {
            case .pascal:
                key = String.LocalizationValue("pressure_pascal \(quantity)")
                break
            case .pound_per_square_inch:
                key = String.LocalizationValue("pressure_pound_per_square_inch \(quantity)")
                break
            case .standard_atmosphere:
                key = String.LocalizationValue("pressure_standard_atmosphere \(quantity)")
                break
            }
        case .speed:
            switch self as! SpeedUnitType {
            case .metre_per_second:
                key = String.LocalizationValue("speed_metre_per_second \(quantity)")
                break
            case .kilometre_per_hour:
                key = String.LocalizationValue("speed_kilometre_per_hour \(quantity)")
                break
            case .mile_per_hour:
                key = String.LocalizationValue("speed_mile_per_hour \(quantity)")
                break
            case .knot:
                key = String.LocalizationValue("speed_knot \(quantity)")
                break
            case .foot_per_second:
                key = String.LocalizationValue("speed_foot_per_second \(quantity)")
                break
            }
        case .temperature:
            switch self as! TemperatureUnitType {
            case .fahrenheit:
                key = String.LocalizationValue("temperature_fahrenheit \(quantity)")
                break
            case .celsius:
                key = String.LocalizationValue("temperature_celsius \(quantity)")
                break
            case .kelvin:
                key = String.LocalizationValue("temperature_kelvin \(quantity)")
                break
            case .rankine:
                key = String.LocalizationValue("temperature_rankine \(quantity)")
                break
            }
        case .time:
            switch self as! TimeUnitType {
            case .second:
                key = String.LocalizationValue("time_second \(quantity)")
                break
            case .minute:
                key = String.LocalizationValue("time_minute \(quantity)")
                break
            case .hour:
                key = String.LocalizationValue("time_hour \(quantity)")
                break
            case .day:
                key = String.LocalizationValue("time_day \(quantity)")
                break
            case .week:
                key = String.LocalizationValue("time_week \(quantity)")
                break
            case .month:
                key = String.LocalizationValue("time_month \(quantity)")
                break
            case .year:
                key = String.LocalizationValue("time_year \(quantity)")
                break
            case .decade:
                key = String.LocalizationValue("time_decade \(quantity)")
                break
            case .century:
                key = String.LocalizationValue("time_century \(quantity)")
                break
            case .millennium:
                key = String.LocalizationValue("time_millennium \(quantity)")
                break
            }
        }
        return String(localized: key, table: "Units", bundle: Bundle.module)
    }
    
    func get_name(_ quantity: Float) -> String {
        let key:String.LocalizationValue
        switch Self.category {
        case .acceleration:
            switch self as! AccelerationUnitType {
            case .metres_per_second_per_second:
                key = String.LocalizationValue("acceleration_metres_per_second_per_second \(quantity)")
                break
            }
        case .action:
            switch self as! ActionUnitType {
            case .joule_second:
                key = String.LocalizationValue("action_joule_second \(quantity)")
                break
            }
        case .density:
            switch self as! DensityUnitType {
            case .kilogram_per_cubic_metre:
                key = String.LocalizationValue("density_kilogram_per_cubic_metre \(quantity)")
                break
            case .gram_per_cubic_centimetre:
                key = String.LocalizationValue("density_gram_per_cubic_centimetre \(quantity)")
                break
            }
        case .electric_charge:
            switch self as! ElectricChargeUnitType {
            case .coulomb:
                key = String.LocalizationValue("electric_charge_coulomb \(quantity)")
                break
            }
        case .energy:
            switch self as! EnergyUnitType {
            case .electronvolt:
                key = String.LocalizationValue("energy_electronvolt \(quantity)")
                break
            case .joule:
                key = String.LocalizationValue("energy_joule \(quantity)")
                break
            }
        case .force:
            switch self as! ForceUnitType {
            case .newton:
                key = String.LocalizationValue("force_newton \(quantity)")
                break
            }
        case .frequency:
            switch self as! FrequencyUnitType {
            case .wavelength_in_metres:
                key = String.LocalizationValue("frequency_wavelength_in_metres \(quantity)")
                break
            case .hertz:
                key = String.LocalizationValue("frequency_hertz \(quantity)")
                break
            }
        case .length:
            switch self as! LengthUnitType {
            case .metre:
                key = String.LocalizationValue("length_metre \(quantity)")
                break
            case .nautical_mile:
                key = String.LocalizationValue("length_nautical_mile \(quantity)")
                break
            case .mile:
                key = String.LocalizationValue("length_mile \(quantity)")
                break
            case .furlong:
                key = String.LocalizationValue("length_furlong \(quantity)")
                break
            case .yard:
                key = String.LocalizationValue("length_yard \(quantity)")
                break
            case .foot:
                key = String.LocalizationValue("length_foot \(quantity)")
                break
            case .inch:
                key = String.LocalizationValue("length_inch \(quantity)")
                break
            }
        case .mass:
            switch self as! MassUnitType {
            case .dalton:
                key = String.LocalizationValue("mass_dalton \(quantity)")
                break
            case .gram:
                key = String.LocalizationValue("mass_gram \(quantity)")
                break
            case .ounce:
                key = String.LocalizationValue("mass_ounce \(quantity)")
                break
            case .pound:
                key = String.LocalizationValue("mass_pound \(quantity)")
                break
            case .tonne:
                key = String.LocalizationValue("mass_tonne \(quantity)")
                break
            }
        case .pressure:
            switch self as! PressureUnitType {
            case .pascal:
                key = String.LocalizationValue("pressure_pascal \(quantity)")
                break
            case .pound_per_square_inch:
                key = String.LocalizationValue("pressure_pound_per_square_inch \(quantity)")
                break
            case .standard_atmosphere:
                key = String.LocalizationValue("pressure_standard_atmosphere \(quantity)")
                break
            }
        case .speed:
            switch self as! SpeedUnitType {
            case .metre_per_second:
                key = String.LocalizationValue("speed_metre_per_second \(quantity)")
                break
            case .kilometre_per_hour:
                key = String.LocalizationValue("speed_kilometre_per_hour \(quantity)")
                break
            case .mile_per_hour:
                key = String.LocalizationValue("speed_mile_per_hour \(quantity)")
                break
            case .knot:
                key = String.LocalizationValue("speed_knot \(quantity)")
                break
            case .foot_per_second:
                key = String.LocalizationValue("speed_foot_per_second \(quantity)")
                break
            }
        case .temperature:
            switch self as! TemperatureUnitType {
            case .fahrenheit:
                key = String.LocalizationValue("temperature_fahrenheit \(quantity)")
                break
            case .celsius:
                key = String.LocalizationValue("temperature_celsius \(quantity)")
                break
            case .kelvin:
                key = String.LocalizationValue("temperature_kelvin \(quantity)")
                break
            case .rankine:
                key = String.LocalizationValue("temperature_rankine \(quantity)")
                break
            }
        case .time:
            switch self as! TimeUnitType {
            case .second:
                key = String.LocalizationValue("time_second \(quantity)")
                break
            case .minute:
                key = String.LocalizationValue("time_minute \(quantity)")
                break
            case .hour:
                key = String.LocalizationValue("time_hour \(quantity)")
                break
            case .day:
                key = String.LocalizationValue("time_day \(quantity)")
                break
            case .week:
                key = String.LocalizationValue("time_week \(quantity)")
                break
            case .month:
                key = String.LocalizationValue("time_month \(quantity)")
                break
            case .year:
                key = String.LocalizationValue("time_year \(quantity)")
                break
            case .decade:
                key = String.LocalizationValue("time_decade \(quantity)")
                break
            case .century:
                key = String.LocalizationValue("time_century \(quantity)")
                break
            case .millennium:
                key = String.LocalizationValue("time_millennium \(quantity)")
                break
            }
        }
        return String(localized: key, table: "Units", bundle: Bundle.module)
    }
    
    func get_name(_ quantity: Double) -> String {
        let key:String.LocalizationValue
        switch Self.category {
        case .acceleration:
            switch self as! AccelerationUnitType {
            case .metres_per_second_per_second:
                key = String.LocalizationValue("acceleration_metres_per_second_per_second \(quantity)")
                break
            }
        case .action:
            switch self as! ActionUnitType {
            case .joule_second:
                key = String.LocalizationValue("action_joule_second \(quantity)")
                break
            }
        case .density:
            switch self as! DensityUnitType {
            case .kilogram_per_cubic_metre:
                key = String.LocalizationValue("density_kilogram_per_cubic_metre \(quantity)")
                break
            case .gram_per_cubic_centimetre:
                key = String.LocalizationValue("density_gram_per_cubic_centimetre \(quantity)")
                break
            }
        case .electric_charge:
            switch self as! ElectricChargeUnitType {
            case .coulomb:
                key = String.LocalizationValue("electric_charge_coulomb \(quantity)")
                break
            }
        case .energy:
            switch self as! EnergyUnitType {
            case .electronvolt:
                key = String.LocalizationValue("energy_electronvolt \(quantity)")
                break
            case .joule:
                key = String.LocalizationValue("energy_joule \(quantity)")
                break
            }
        case .force:
            switch self as! ForceUnitType {
            case .newton:
                key = String.LocalizationValue("force_newton \(quantity)")
                break
            }
        case .frequency:
            switch self as! FrequencyUnitType {
            case .wavelength_in_metres:
                key = String.LocalizationValue("frequency_wavelength_in_metres \(quantity)")
                break
            case .hertz:
                key = String.LocalizationValue("frequency_hertz \(quantity)")
                break
            }
        case .length:
            switch self as! LengthUnitType {
            case .metre:
                key = String.LocalizationValue("length_metre \(quantity)")
                break
            case .nautical_mile:
                key = String.LocalizationValue("length_nautical_mile \(quantity)")
                break
            case .mile:
                key = String.LocalizationValue("length_mile \(quantity)")
                break
            case .furlong:
                key = String.LocalizationValue("length_furlong \(quantity)")
                break
            case .yard:
                key = String.LocalizationValue("length_yard \(quantity)")
                break
            case .foot:
                key = String.LocalizationValue("length_foot \(quantity)")
                break
            case .inch:
                key = String.LocalizationValue("length_inch \(quantity)")
                break
            }
        case .mass:
            switch self as! MassUnitType {
            case .dalton:
                key = String.LocalizationValue("mass_dalton \(quantity)")
                break
            case .gram:
                key = String.LocalizationValue("mass_gram \(quantity)")
                break
            case .ounce:
                key = String.LocalizationValue("mass_ounce \(quantity)")
                break
            case .pound:
                key = String.LocalizationValue("mass_pound \(quantity)")
                break
            case .tonne:
                key = String.LocalizationValue("mass_tonne \(quantity)")
                break
            }
        case .pressure:
            switch self as! PressureUnitType {
            case .pascal:
                key = String.LocalizationValue("pressure_pascal \(quantity)")
                break
            case .pound_per_square_inch:
                key = String.LocalizationValue("pressure_pound_per_square_inch \(quantity)")
                break
            case .standard_atmosphere:
                key = String.LocalizationValue("pressure_standard_atmosphere \(quantity)")
                break
            }
        case .speed:
            switch self as! SpeedUnitType {
            case .metre_per_second:
                key = String.LocalizationValue("speed_metre_per_second \(quantity)")
                break
            case .kilometre_per_hour:
                key = String.LocalizationValue("speed_kilometre_per_hour \(quantity)")
                break
            case .mile_per_hour:
                key = String.LocalizationValue("speed_mile_per_hour \(quantity)")
                break
            case .knot:
                key = String.LocalizationValue("speed_knot \(quantity)")
                break
            case .foot_per_second:
                key = String.LocalizationValue("speed_foot_per_second \(quantity)")
                break
            }
        case .temperature:
            switch self as! TemperatureUnitType {
            case .fahrenheit:
                key = String.LocalizationValue("temperature_fahrenheit \(quantity)")
                break
            case .celsius:
                key = String.LocalizationValue("temperature_celsius \(quantity)")
                break
            case .kelvin:
                key = String.LocalizationValue("temperature_kelvin \(quantity)")
                break
            case .rankine:
                key = String.LocalizationValue("temperature_rankine \(quantity)")
                break
            }
        case .time:
            switch self as! TimeUnitType {
            case .second:
                key = String.LocalizationValue("time_second \(quantity)")
                break
            case .minute:
                key = String.LocalizationValue("time_minute \(quantity)")
                break
            case .hour:
                key = String.LocalizationValue("time_hour \(quantity)")
                break
            case .day:
                key = String.LocalizationValue("time_day \(quantity)")
                break
            case .week:
                key = String.LocalizationValue("time_week \(quantity)")
                break
            case .month:
                key = String.LocalizationValue("time_month \(quantity)")
                break
            case .year:
                key = String.LocalizationValue("time_year \(quantity)")
                break
            case .decade:
                key = String.LocalizationValue("time_decade \(quantity)")
                break
            case .century:
                key = String.LocalizationValue("time_century \(quantity)")
                break
            case .millennium:
                key = String.LocalizationValue("time_millennium \(quantity)")
                break
            }
        }
        return String(localized: key, table: "Units", bundle: Bundle.module)
    }
}
