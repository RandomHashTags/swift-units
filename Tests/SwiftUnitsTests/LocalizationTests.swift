//
//  LocalizationTests.swift
//
//
//  Created by Evan Anderson on 7/8/23.
//

import XCTest
@testable import SwiftUnits
import HugeNumbers

struct LocalizationTests {
    func validate() {
        validate_unit_types()
    }
}

extension LocalizationTests {
    private func validate_unit_types() {
        validate_unit {
            return AccelerationUnit(type: AccelerationUnitType.metres_per_second_per_second, value: "1")
        } get_type_string: { type in
            return type == .metres_per_second_per_second ? "Metre per second squared" : nil
        } get_plural_string: { type in
            return type == .metres_per_second_per_second ? "Metres per second squared" : nil
        }
        
        validate_unit {
            return ActionUnit(type: ActionUnitType.joule_second, value: "1")
        } get_type_string: { type in
            return type == .joule_second ? "Joule-second" : nil
        } get_plural_string: { type in
            return type == .joule_second ? "Joule-seconds" : nil
        }
        
        validate_unit {
            return DensityUnit(type: DensityUnitType.gram_per_cubic_centimetre, value: "1")
        } get_plural_string: { type in
            switch type {
            case .gram_per_cubic_centimetre: return "Grams per cubic centimetre"
            case .kilogram_per_cubic_metre: return "Kilograms per cubic metre"
            }
        }
        
        validate_unit {
            return ElectricChargeUnit(type: ElectricChargeUnitType.coulomb, value: "1")
        }
        
        validate_unit {
            return ForceUnit(type: ForceUnitType.newton, value: "1")
        }
        
        validate_unit {
            return FrequencyUnit(type: FrequencyUnitType.hertz, value: "1")
        } get_type_string: { type in
            return type == .hertz ? "Hertz" : type == .wavelength_in_metres ? "Wavelength" : nil
        } get_plural_string: { type in
            return type == .hertz ? "Hertz" : type == .wavelength_in_metres ? "Wavelength" : nil
        }
        
        validate_unit {
            return LengthUnit(type: LengthUnitType.foot, value: "1")
        } get_type_string: { type in
            switch type {
            case .nautical_mile: return "Nautical Mile"
            default: return nil
            }
        } get_plural_string: { type in
            switch type {
            case .nautical_mile: return "Nautical Miles"
            case .foot: return "Feet"
            case .inch: return "Inches"
            default: return nil
            }
        }
        
        validate_unit {
            return MassUnit(type: MassUnitType.dalton, value: "1")
        } get_plural_string: { type in
            return type == .dalton ? "Dalton" : nil
        }
        
        validate_unit {
            return PressureUnit(type: PressureUnitType.pascal, value: "1")
        } get_type_string: { type in
            return type == .standard_atmosphere ? "Standard Atmosphere" : nil
        } get_plural_string: { type in
            switch type {
            case .pound_per_square_inch: return "Pounds per square inch"
            case .standard_atmosphere: return "Standard Atmosphere"
            default: return nil
            }
        }
        
        validate_unit {
            return SpeedUnit(type: SpeedUnitType.foot_per_second, value: "1")
        } get_plural_string: { type in
            switch type {
            case .foot_per_second: return "Feet per second"
            case .kilometre_per_hour: return "Kilometres per hour"
            case .metre_per_second: return "Metres per second"
            case .mile_per_hour: return "Miles per hour"
            default: return nil
            }
        }
        
        validate_unit {
            return TemperatureUnit(type: TemperatureUnitType.celsius, value: "1")
        } get_plural_string: { type in
            let string:String = type.rawValue
            return string.prefix(1).uppercased() + string.suffix(string.count-1)
        } get_number_suffix: { type in
            return type == .kelvin ? "" : "°"
        }
        
        validate_unit {
            return TimeUnit(type: TimeUnitType.century, value: "1")
        } get_plural_string: { type in
            switch type {
            case .century: return "Centuries"
            case .millennium: return "Millennia"
            default: return nil
            }
        }
    }
    private func validate_unit<U: SwiftUnits.Unit>(_ get_unit: () -> U, get_type_string: ((U.TargetUnitType) -> String?)? = nil, get_plural_string: ((U.TargetUnitType) -> String?)? = nil, get_number_suffix: ((U.TargetUnitType) -> String?)? = nil) {
        for type in U.TargetUnitType.allCases {
            var mass:U = U(type: type, value: "5")
            var string:String = mass.description
            var type_string:String
            if let test:String = get_type_string?(type) {
                type_string = test
            } else {
                type_string = type.rawValue.replacingOccurrences(of: "_", with: " ")
                type_string = type_string.prefix(1).uppercased() + type_string.suffix(type_string.count-1)
            }
            let plural_string:String = get_plural_string?(type) ?? type_string + "s"
            let number_suffix:String = (get_number_suffix?(type) ?? "").appending(" ")
            XCTAssert(string.elementsEqual("5.000000" + number_suffix + plural_string), string + ";type_string=" + type_string)
            
            mass.value = HugeFloat.one
            string = mass.description
            XCTAssert(string.elementsEqual("1.000000" + number_suffix + type_string), string + ";type_string=" + type_string)
            
            string = mass.type.get_name(1)
            XCTAssert(string.elementsEqual("1" + number_suffix + type_string), string + ";type_string=" + type_string)
            
            string = mass.type.get_name(Float(1))
            XCTAssert(string.elementsEqual("1.000000" + number_suffix + type_string), string + ";type_string=" + type_string)
            
            string = mass.type.get_name(Double(9.25))
            XCTAssert(string.elementsEqual("9.250000" + number_suffix + plural_string), string + ";type_string=" + type_string)
        }
    }
}
