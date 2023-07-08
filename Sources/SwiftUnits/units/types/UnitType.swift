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
    private func locale_name(_ key: String.LocalizationValue) -> String {
        return String(localized: key, table: "Units", bundle: Bundle.module)
    }
    func get_name(_ quantity: HugeInt) -> String {
        switch Self.category {
        case .acceleration:
            switch self as! AccelerationUnitType {
            case .metres_per_second_per_second:
                return locale_name("acceleration_metres_per_second_per_second \(quantity)")
            }
        case .action:
            switch self as! ActionUnitType {
            case .joule_second:
                return locale_name("action_joule_second \(quantity)")
            }
        case .density:
            switch self as! DensityUnitType {
            case .kilogram_per_cubic_metre:
                return locale_name("density_kilogram_per_cubic_metre \(quantity)")
            case .gram_per_cubic_centimetre:
                return locale_name("density_gram_per_cubic_centimetre \(quantity)")
            }
        case .electric_charge:
            switch self as! ElectricChargeUnitType {
            case .coulomb:
                return locale_name("electric_charge_coulomb \(quantity)")
            }
        case .energy:
            switch self as! EnergyUnitType {
            case .electronvolt:
                return locale_name("energy_electronvolt \(quantity)")
            case .joule:
                return locale_name("energy_joule \(quantity)")
            }
        case .force:
            switch self as! ForceUnitType {
            case .newton:
                return locale_name("force_newton \(quantity)")
            }
        case .frequency:
            switch self as! FrequencyUnitType {
            case .wavelength_in_metres:
                return locale_name("frequency_wavelength_in_metres \(quantity)")
            case .hertz:
                return locale_name("frequency_hertz \(quantity)")
            }
        case .length:
            switch self as! LengthUnitType {
            case .metre:
                return locale_name("length_metre \(quantity)")
            case .nautical_mile:
                return locale_name("length_nautical_mile \(quantity)")
            case .mile:
                return locale_name("length_mile \(quantity)")
            case .furlong:
                return locale_name("length_furlong \(quantity)")
            case .yard:
                return locale_name("length_yard \(quantity)")
            case .foot:
                return locale_name("length_foot \(quantity)")
            case .inch:
                return locale_name("length_inch \(quantity)")
            }
        case .mass:
            switch self as! MassUnitType {
            case .dalton:
                return locale_name("mass_dalton \(quantity)")
            case .gram:
                return locale_name("mass_gram \(quantity)")
            case .ounce:
                return locale_name("mass_ounce \(quantity)")
            case .pound:
                return locale_name("mass_pound \(quantity)")
            case .tonne:
                return locale_name("mass_tonne \(quantity)")
            }
        case .pressure:
            switch self as! PressureUnitType {
            case .pascal:
                return locale_name("pressure_pascal \(quantity)")
            case .pound_per_square_inch:
                return locale_name("pressure_pound_per_square_inch \(quantity)")
            case .standard_atmosphere:
                return locale_name("pressure_standard_atmosphere \(quantity)")
            }
        case .speed:
            switch self as! SpeedUnitType {
            case .metre_per_second:
                return locale_name("speed_metre_per_second \(quantity)")
            case .kilometre_per_hour:
                return locale_name("speed_kilometre_per_hour \(quantity)")
            case .mile_per_hour:
                return locale_name("speed_mile_per_hour \(quantity)")
            case .knot:
                return locale_name("speed_knot \(quantity)")
            case .foot_per_second:
                return locale_name("speed_foot_per_second \(quantity)")
            }
        case .temperature:
            switch self as! TemperatureUnitType {
            case .fahrenheit:
                return locale_name("temperature_fahrenheit \(quantity)")
            case .celsius:
                return locale_name("temperature_celsius \(quantity)")
            case .kelvin:
                return locale_name("temperature_kelvin \(quantity)")
            case .rankine:
                return locale_name("temperature_rankine \(quantity)")
            }
        case .time:
            switch self as! TimeUnitType {
            case .second:
                return locale_name("time_second \(quantity)")
            case .minute:
                return locale_name("time_minute \(quantity)")
            case .hour:
                return locale_name("time_hour \(quantity)")
            case .day:
                return locale_name("time_day \(quantity)")
            case .week:
                return locale_name("time_week \(quantity)")
            case .month:
                return locale_name("time_month \(quantity)")
            case .year:
                return locale_name("time_year \(quantity)")
            case .decade:
                return locale_name("time_decade \(quantity)")
            case .century:
                return locale_name("time_century \(quantity)")
            case .millennium:
                return locale_name("time_millennium \(quantity)")
            }
        }
    }
    
    func get_name(_ quantity: HugeFloat) -> String {
        switch Self.category {
        case .acceleration:
            switch self as! AccelerationUnitType {
            case .metres_per_second_per_second:
                return locale_name("acceleration_metres_per_second_per_second \(quantity)")
            }
        case .action:
            switch self as! ActionUnitType {
            case .joule_second:
                return locale_name("action_joule_second \(quantity)")
            }
        case .density:
            switch self as! DensityUnitType {
            case .kilogram_per_cubic_metre:
                return locale_name("density_kilogram_per_cubic_metre \(quantity)")
            case .gram_per_cubic_centimetre:
                return locale_name("density_gram_per_cubic_centimetre \(quantity)")
            }
        case .electric_charge:
            switch self as! ElectricChargeUnitType {
            case .coulomb:
                return locale_name("electric_charge_coulomb \(quantity)")
            }
        case .energy:
            switch self as! EnergyUnitType {
            case .electronvolt:
                return locale_name("energy_electronvolt \(quantity)")
            case .joule:
                return locale_name("energy_joule \(quantity)")
            }
        case .force:
            switch self as! ForceUnitType {
            case .newton:
                return locale_name("force_newton \(quantity)")
            }
        case .frequency:
            switch self as! FrequencyUnitType {
            case .wavelength_in_metres:
                return locale_name("frequency_wavelength_in_metres \(quantity)")
            case .hertz:
                return locale_name("frequency_hertz \(quantity)")
            }
        case .length:
            switch self as! LengthUnitType {
            case .metre:
                return locale_name("length_metre \(quantity)")
            case .nautical_mile:
                return locale_name("length_nautical_mile \(quantity)")
            case .mile:
                return locale_name("length_mile \(quantity)")
            case .furlong:
                return locale_name("length_furlong \(quantity)")
            case .yard:
                return locale_name("length_yard \(quantity)")
            case .foot:
                return locale_name("length_foot \(quantity)")
            case .inch:
                return locale_name("length_inch \(quantity)")
            }
        case .mass:
            switch self as! MassUnitType {
            case .dalton:
                return locale_name("mass_dalton \(quantity)")
            case .gram:
                return locale_name("mass_gram \(quantity)")
            case .ounce:
                return locale_name("mass_ounce \(quantity)")
            case .pound:
                return locale_name("mass_pound \(quantity)")
            case .tonne:
                return locale_name("mass_tonne \(quantity)")
            }
        case .pressure:
            switch self as! PressureUnitType {
            case .pascal:
                return locale_name("pressure_pascal \(quantity)")
            case .pound_per_square_inch:
                return locale_name("pressure_pound_per_square_inch \(quantity)")
            case .standard_atmosphere:
                return locale_name("pressure_standard_atmosphere \(quantity)")
            }
        case .speed:
            switch self as! SpeedUnitType {
            case .metre_per_second:
                return locale_name("speed_metre_per_second \(quantity)")
            case .kilometre_per_hour:
                return locale_name("speed_kilometre_per_hour \(quantity)")
            case .mile_per_hour:
                return locale_name("speed_mile_per_hour \(quantity)")
            case .knot:
                return locale_name("speed_knot \(quantity)")
            case .foot_per_second:
                return locale_name("speed_foot_per_second \(quantity)")
            }
        case .temperature:
            switch self as! TemperatureUnitType {
            case .fahrenheit:
                return locale_name("temperature_fahrenheit \(quantity)")
            case .celsius:
                return locale_name("temperature_celsius \(quantity)")
            case .kelvin:
                return locale_name("temperature_kelvin \(quantity)")
            case .rankine:
                return locale_name("temperature_rankine \(quantity)")
            }
        case .time:
            switch self as! TimeUnitType {
            case .second:
                return locale_name("time_second \(quantity)")
            case .minute:
                return locale_name("time_minute \(quantity)")
            case .hour:
                return locale_name("time_hour \(quantity)")
            case .day:
                return locale_name("time_day \(quantity)")
            case .week:
                return locale_name("time_week \(quantity)")
            case .month:
                return locale_name("time_month \(quantity)")
            case .year:
                return locale_name("time_year \(quantity)")
            case .decade:
                return locale_name("time_decade \(quantity)")
            case .century:
                return locale_name("time_century \(quantity)")
            case .millennium:
                return locale_name("time_millennium \(quantity)")
            }
        }
    }
    
    func get_name(_ quantity: Int) -> String {
        switch Self.category {
        case .acceleration:
            switch self as! AccelerationUnitType {
            case .metres_per_second_per_second:
                return locale_name("acceleration_metres_per_second_per_second \(quantity)")
            }
        case .action:
            switch self as! ActionUnitType {
            case .joule_second:
                return locale_name("action_joule_second \(quantity)")
            }
        case .density:
            switch self as! DensityUnitType {
            case .kilogram_per_cubic_metre:
                return locale_name("density_kilogram_per_cubic_metre \(quantity)")
            case .gram_per_cubic_centimetre:
                return locale_name("density_gram_per_cubic_centimetre \(quantity)")
            }
        case .electric_charge:
            switch self as! ElectricChargeUnitType {
            case .coulomb:
                return locale_name("electric_charge_coulomb \(quantity)")
            }
        case .energy:
            switch self as! EnergyUnitType {
            case .electronvolt:
                return locale_name("energy_electronvolt \(quantity)")
            case .joule:
                return locale_name("energy_joule \(quantity)")
            }
        case .force:
            switch self as! ForceUnitType {
            case .newton:
                return locale_name("force_newton \(quantity)")
            }
        case .frequency:
            switch self as! FrequencyUnitType {
            case .wavelength_in_metres:
                return locale_name("frequency_wavelength_in_metres \(quantity)")
            case .hertz:
                return locale_name("frequency_hertz \(quantity)")
            }
        case .length:
            switch self as! LengthUnitType {
            case .metre:
                return locale_name("length_metre \(quantity)")
            case .nautical_mile:
                return locale_name("length_nautical_mile \(quantity)")
            case .mile:
                return locale_name("length_mile \(quantity)")
            case .furlong:
                return locale_name("length_furlong \(quantity)")
            case .yard:
                return locale_name("length_yard \(quantity)")
            case .foot:
                return locale_name("length_foot \(quantity)")
            case .inch:
                return locale_name("length_inch \(quantity)")
            }
        case .mass:
            switch self as! MassUnitType {
            case .dalton:
                return locale_name("mass_dalton \(quantity)")
            case .gram:
                return locale_name("mass_gram \(quantity)")
            case .ounce:
                return locale_name("mass_ounce \(quantity)")
            case .pound:
                return locale_name("mass_pound \(quantity)")
            case .tonne:
                return locale_name("mass_tonne \(quantity)")
            }
        case .pressure:
            switch self as! PressureUnitType {
            case .pascal:
                return locale_name("pressure_pascal \(quantity)")
            case .pound_per_square_inch:
                return locale_name("pressure_pound_per_square_inch \(quantity)")
            case .standard_atmosphere:
                return locale_name("pressure_standard_atmosphere \(quantity)")
            }
        case .speed:
            switch self as! SpeedUnitType {
            case .metre_per_second:
                return locale_name("speed_metre_per_second \(quantity)")
            case .kilometre_per_hour:
                return locale_name("speed_kilometre_per_hour \(quantity)")
            case .mile_per_hour:
                return locale_name("speed_mile_per_hour \(quantity)")
            case .knot:
                return locale_name("speed_knot \(quantity)")
            case .foot_per_second:
                return locale_name("speed_foot_per_second \(quantity)")
            }
        case .temperature:
            switch self as! TemperatureUnitType {
            case .fahrenheit:
                return locale_name("temperature_fahrenheit \(quantity)")
            case .celsius:
                return locale_name("temperature_celsius \(quantity)")
            case .kelvin:
                return locale_name("temperature_kelvin \(quantity)")
            case .rankine:
                return locale_name("temperature_rankine \(quantity)")
            }
        case .time:
            switch self as! TimeUnitType {
            case .second:
                return locale_name("time_second \(quantity)")
            case .minute:
                return locale_name("time_minute \(quantity)")
            case .hour:
                return locale_name("time_hour \(quantity)")
            case .day:
                return locale_name("time_day \(quantity)")
            case .week:
                return locale_name("time_week \(quantity)")
            case .month:
                return locale_name("time_month \(quantity)")
            case .year:
                return locale_name("time_year \(quantity)")
            case .decade:
                return locale_name("time_decade \(quantity)")
            case .century:
                return locale_name("time_century \(quantity)")
            case .millennium:
                return locale_name("time_millennium \(quantity)")
            }
        }
    }
    
    func get_name(_ quantity: Float) -> String {
        switch Self.category {
        case .acceleration:
            switch self as! AccelerationUnitType {
            case .metres_per_second_per_second:
                return locale_name("acceleration_metres_per_second_per_second \(quantity)")
            }
        case .action:
            switch self as! ActionUnitType {
            case .joule_second:
                return locale_name("action_joule_second \(quantity)")
            }
        case .density:
            switch self as! DensityUnitType {
            case .kilogram_per_cubic_metre:
                return locale_name("density_kilogram_per_cubic_metre \(quantity)")
            case .gram_per_cubic_centimetre:
                return locale_name("density_gram_per_cubic_centimetre \(quantity)")
            }
        case .electric_charge:
            switch self as! ElectricChargeUnitType {
            case .coulomb:
                return locale_name("electric_charge_coulomb \(quantity)")
            }
        case .energy:
            switch self as! EnergyUnitType {
            case .electronvolt:
                return locale_name("energy_electronvolt \(quantity)")
            case .joule:
                return locale_name("energy_joule \(quantity)")
            }
        case .force:
            switch self as! ForceUnitType {
            case .newton:
                return locale_name("force_newton \(quantity)")
            }
        case .frequency:
            switch self as! FrequencyUnitType {
            case .wavelength_in_metres:
                return locale_name("frequency_wavelength_in_metres \(quantity)")
            case .hertz:
                return locale_name("frequency_hertz \(quantity)")
            }
        case .length:
            switch self as! LengthUnitType {
            case .metre:
                return locale_name("length_metre \(quantity)")
            case .nautical_mile:
                return locale_name("length_nautical_mile \(quantity)")
            case .mile:
                return locale_name("length_mile \(quantity)")
            case .furlong:
                return locale_name("length_furlong \(quantity)")
            case .yard:
                return locale_name("length_yard \(quantity)")
            case .foot:
                return locale_name("length_foot \(quantity)")
            case .inch:
                return locale_name("length_inch \(quantity)")
            }
        case .mass:
            switch self as! MassUnitType {
            case .dalton:
                return locale_name("mass_dalton \(quantity)")
            case .gram:
                return locale_name("mass_gram \(quantity)")
            case .ounce:
                return locale_name("mass_ounce \(quantity)")
            case .pound:
                return locale_name("mass_pound \(quantity)")
            case .tonne:
                return locale_name("mass_tonne \(quantity)")
            }
        case .pressure:
            switch self as! PressureUnitType {
            case .pascal:
                return locale_name("pressure_pascal \(quantity)")
            case .pound_per_square_inch:
                return locale_name("pressure_pound_per_square_inch \(quantity)")
            case .standard_atmosphere:
                return locale_name("pressure_standard_atmosphere \(quantity)")
            }
        case .speed:
            switch self as! SpeedUnitType {
            case .metre_per_second:
                return locale_name("speed_metre_per_second \(quantity)")
            case .kilometre_per_hour:
                return locale_name("speed_kilometre_per_hour \(quantity)")
            case .mile_per_hour:
                return locale_name("speed_mile_per_hour \(quantity)")
            case .knot:
                return locale_name("speed_knot \(quantity)")
            case .foot_per_second:
                return locale_name("speed_foot_per_second \(quantity)")
            }
        case .temperature:
            switch self as! TemperatureUnitType {
            case .fahrenheit:
                return locale_name("temperature_fahrenheit \(quantity)")
            case .celsius:
                return locale_name("temperature_celsius \(quantity)")
            case .kelvin:
                return locale_name("temperature_kelvin \(quantity)")
            case .rankine:
                return locale_name("temperature_rankine \(quantity)")
            }
        case .time:
            switch self as! TimeUnitType {
            case .second:
                return locale_name("time_second \(quantity)")
            case .minute:
                return locale_name("time_minute \(quantity)")
            case .hour:
                return locale_name("time_hour \(quantity)")
            case .day:
                return locale_name("time_day \(quantity)")
            case .week:
                return locale_name("time_week \(quantity)")
            case .month:
                return locale_name("time_month \(quantity)")
            case .year:
                return locale_name("time_year \(quantity)")
            case .decade:
                return locale_name("time_decade \(quantity)")
            case .century:
                return locale_name("time_century \(quantity)")
            case .millennium:
                return locale_name("time_millennium \(quantity)")
            }
        }
    }
    
    func get_name(_ quantity: Double) -> String {
        switch Self.category {
        case .acceleration:
            switch self as! AccelerationUnitType {
            case .metres_per_second_per_second:
                return locale_name("acceleration_metres_per_second_per_second \(quantity)")
            }
        case .action:
            switch self as! ActionUnitType {
            case .joule_second:
                return locale_name("action_joule_second \(quantity)")
            }
        case .density:
            switch self as! DensityUnitType {
            case .kilogram_per_cubic_metre:
                return locale_name("density_kilogram_per_cubic_metre \(quantity)")
            case .gram_per_cubic_centimetre:
                return locale_name("density_gram_per_cubic_centimetre \(quantity)")
            }
        case .electric_charge:
            switch self as! ElectricChargeUnitType {
            case .coulomb:
                return locale_name("electric_charge_coulomb \(quantity)")
            }
        case .energy:
            switch self as! EnergyUnitType {
            case .electronvolt:
                return locale_name("energy_electronvolt \(quantity)")
            case .joule:
                return locale_name("energy_joule \(quantity)")
            }
        case .force:
            switch self as! ForceUnitType {
            case .newton:
                return locale_name("force_newton \(quantity)")
            }
        case .frequency:
            switch self as! FrequencyUnitType {
            case .wavelength_in_metres:
                return locale_name("frequency_wavelength_in_metres \(quantity)")
            case .hertz:
                return locale_name("frequency_hertz \(quantity)")
            }
        case .length:
            switch self as! LengthUnitType {
            case .metre:
                return locale_name("length_metre \(quantity)")
            case .nautical_mile:
                return locale_name("length_nautical_mile \(quantity)")
            case .mile:
                return locale_name("length_mile \(quantity)")
            case .furlong:
                return locale_name("length_furlong \(quantity)")
            case .yard:
                return locale_name("length_yard \(quantity)")
            case .foot:
                return locale_name("length_foot \(quantity)")
            case .inch:
                return locale_name("length_inch \(quantity)")
            }
        case .mass:
            switch self as! MassUnitType {
            case .dalton:
                return locale_name("mass_dalton \(quantity)")
            case .gram:
                return locale_name("mass_gram \(quantity)")
            case .ounce:
                return locale_name("mass_ounce \(quantity)")
            case .pound:
                return locale_name("mass_pound \(quantity)")
            case .tonne:
                return locale_name("mass_tonne \(quantity)")
            }
        case .pressure:
            switch self as! PressureUnitType {
            case .pascal:
                return locale_name("pressure_pascal \(quantity)")
            case .pound_per_square_inch:
                return locale_name("pressure_pound_per_square_inch \(quantity)")
            case .standard_atmosphere:
                return locale_name("pressure_standard_atmosphere \(quantity)")
            }
        case .speed:
            switch self as! SpeedUnitType {
            case .metre_per_second:
                return locale_name("speed_metre_per_second \(quantity)")
            case .kilometre_per_hour:
                return locale_name("speed_kilometre_per_hour \(quantity)")
            case .mile_per_hour:
                return locale_name("speed_mile_per_hour \(quantity)")
            case .knot:
                return locale_name("speed_knot \(quantity)")
            case .foot_per_second:
                return locale_name("speed_foot_per_second \(quantity)")
            }
        case .temperature:
            switch self as! TemperatureUnitType {
            case .fahrenheit:
                return locale_name("temperature_fahrenheit \(quantity)")
            case .celsius:
                return locale_name("temperature_celsius \(quantity)")
            case .kelvin:
                return locale_name("temperature_kelvin \(quantity)")
            case .rankine:
                return locale_name("temperature_rankine \(quantity)")
            }
        case .time:
            switch self as! TimeUnitType {
            case .second:
                return locale_name("time_second \(quantity)")
            case .minute:
                return locale_name("time_minute \(quantity)")
            case .hour:
                return locale_name("time_hour \(quantity)")
            case .day:
                return locale_name("time_day \(quantity)")
            case .week:
                return locale_name("time_week \(quantity)")
            case .month:
                return locale_name("time_month \(quantity)")
            case .year:
                return locale_name("time_year \(quantity)")
            case .decade:
                return locale_name("time_decade \(quantity)")
            case .century:
                return locale_name("time_century \(quantity)")
            case .millennium:
                return locale_name("time_millennium \(quantity)")
            }
        }
    }
}
