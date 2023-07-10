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
        //write_unit_type_prefixes()
        
        for prefix in UnitPrefix.allCases {
            validate_unit_types(prefix: prefix)
        }
    }
    
    private func write_unit_type_prefixes() {
        var prefixes:Set<UnitPrefix> = Set<UnitPrefix>(UnitPrefix.allCases)
        prefixes.remove(UnitPrefix.zepto)
        prefixes.remove(UnitPrefix.atto)
        prefixes.remove(UnitPrefix.normal)
        for prefix in prefixes {
            generate_prefix_localization(prefix: prefix)
        }
    }
}

extension LocalizationTests {
    func generate_prefix_localization(prefix: UnitPrefix) {
        let normal_catalog_data:Data = FileManager.default.contents(atPath: "/Users/randomhashtags/GitProjects/swift-units/Sources/SwiftUnits/Resources/Localization/UnitsNormal.xcstrings")!
        let normal_catalog:StringCatalog = try! JSONDecoder().decode(StringCatalog.self, from: normal_catalog_data)
        
        var prefix_key:String = "\(prefix)"
        prefix_key = prefix_key.prefix(1).uppercased() + prefix_key.suffix(prefix_key.count-1)
        
        let symbols:[String] = ["%lld", "%f", "%lf"]
        
        let plus_one_offset_types:Set<String> = Set<String>([
            TemperatureUnitType.celsius,
            TemperatureUnitType.fahrenheit,
            TemperatureUnitType.rankine
        ].map({ $0.rawValue }))
        
        var entries:[String:LocalizedKey] = [:]
        for category in UnitCategory.allCases {
            let category_key:String = category.rawValue
            let unit_type:any UnitType.Type = category.unit_type
            
            for type in unit_type.allCases as! [any UnitType] {
                let type_key:String = type.rawValue
                
                for symbol in symbols {
                    let offset:Int = symbol.count + 1 + (plus_one_offset_types.contains(type_key) ? 1 : 0)
                    let identifier:String = category_key + "_" + type_key + " " + symbol
                    var integer_entry:LocalizedKey = normal_catalog.strings[identifier]!
                    var localization:LocalizedKeyLocalization = integer_entry.localizations.en
                    if var string_unit:LocalizedKeyLocalizationStringUnit = localization.stringUnit {
                        var value:String = string_unit.value
                        test(&value, prefix: prefix_key, offset: offset)
                        string_unit.value = value
                        localization.stringUnit = string_unit
                    } else if var variations:LocalizedKeyLocalizationVariations = localization.variations {
                        var single_value:String = variations.plural.one.stringUnit.value
                        var plural_value:String = variations.plural.other.stringUnit.value
                        test(&single_value, prefix: prefix_key, offset: offset)
                        test(&plural_value, prefix: prefix_key, offset: offset)
                        variations.plural.one.stringUnit.value = single_value
                        variations.plural.other.stringUnit.value = plural_value
                        localization.variations = variations
                    }
                    integer_entry.localizations.en = localization
                    entries[identifier] = integer_entry
                }
            }
        }
        print_string_catalog_entries(name: "Units" + prefix_key, folder: "Units", entries)
    }
    private func test(_ value: inout String, prefix: String, offset: Int) {
        let target_single_index:String.Index = value.index(value.startIndex, offsetBy: offset)
        let target_single_character:Character = value[target_single_index]
        value.remove(at: target_single_index)
        value.insert(contentsOf: target_single_character.lowercased(), at: target_single_index)
        value.insert(contentsOf: prefix, at: target_single_index)
    }
    
    private func print_string_catalog_entries(name: String, folder: String, _ entries: [String:LocalizedKey]) {
        let catalog:StringCatalog = StringCatalog(strings: entries)
        
        let encoder:JSONEncoder = JSONEncoder()
        let data:Data = try! encoder.encode(catalog)
        let string:String = String(data: data, encoding: .utf8)!
        write(text: string, to: name, folder: folder, file_extension: "xcstrings")
    }
    
    func write(text: String, to fileNamed: String, folder: String, file_extension: String) {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first,
              let writePath = NSURL(fileURLWithPath: path).appendingPathComponent(folder) else {
            return
        }
        try? FileManager.default.createDirectory(atPath: writePath.path, withIntermediateDirectories: true)
        let file = writePath.appendingPathComponent(fileNamed + "." + file_extension)
        try? text.write(to: file, atomically: false, encoding: String.Encoding.utf8)
    }
}

private struct StringCatalog : Codable {
    var sourceLanguage:String = "en"
    var strings:[String:LocalizedKey]
    var version:String = "1.0"
}
private struct LocalizedKey : Codable {
    var extractionState:String = "manual"
    var localizations:LocalizedKeyLocalizations
}
private struct LocalizedKeyLocalizations : Codable {
    var en:LocalizedKeyLocalization
}
private struct LocalizedKeyLocalization : Codable {
    var variations:LocalizedKeyLocalizationVariations?
    var stringUnit:LocalizedKeyLocalizationStringUnit?
}
private struct LocalizedKeyLocalizationVariations : Codable {
    var plural:LocalizedKeyLocalizationPluralVariant
}

private struct LocalizedKeyLocalizationVariantValue : Codable {
    var stringUnit:LocalizedKeyLocalizationStringUnit
}
private struct LocalizedKeyLocalizationPluralVariant : Codable {
    var one:LocalizedKeyLocalizationVariantValue
    var other:LocalizedKeyLocalizationVariantValue
}

private struct LocalizedKeyLocalizationStringUnit : Codable {
    var state:String = "translated"
    var value:String
}

extension LocalizationTests {
    private func validate_unit_types(prefix: UnitPrefix) {
        validate_unit {
            return AccelerationUnit(prefix: prefix, type: AccelerationUnitType.metres_per_second_per_second, value: "1")
        } get_type_string: { type in
            return type == .metres_per_second_per_second ? "metre per second squared" : nil
        } get_plural_string: { type in
            return type == .metres_per_second_per_second ? "metres per second squared" : nil
        }
        
        validate_unit {
            return ActionUnit(prefix: prefix, type: ActionUnitType.joule_second, value: "1")
        } get_type_string: { type in
            return type == .joule_second ? "joule-second" : nil
        } get_plural_string: { type in
            return type == .joule_second ? "joule-seconds" : nil
        }
        
        validate_unit {
            return DensityUnit(prefix: prefix, type: DensityUnitType.gram_per_cubic_centimetre, value: "1")
        } get_plural_string: { type in
            switch type {
            case .gram_per_cubic_centimetre: return "grams per cubic centimetre"
            case .kilogram_per_cubic_metre: return "kilograms per cubic metre"
            }
        }
        
        validate_unit {
            return ElectricChargeUnit(prefix: prefix, type: ElectricChargeUnitType.coulomb, value: "1")
        }
        
        validate_unit {
            return ForceUnit(prefix: prefix, type: ForceUnitType.newton, value: "1")
        }
        
        validate_unit {
            return FrequencyUnit(prefix: prefix, type: FrequencyUnitType.hertz, value: "1")
        } get_type_string: { type in
            return type == .hertz ? "hertz" : type == .wavelength_in_metres ? "wavelength" : nil
        } get_plural_string: { type in
            return type == .hertz ? "hertz" : type == .wavelength_in_metres ? "wavelength" : nil
        }
        
        validate_unit {
            return LengthUnit(prefix: prefix, type: LengthUnitType.foot, value: "1")
        } get_type_string: { type in
            switch type {
            case .nautical_mile: return "nautical Mile"
            default: return nil
            }
        } get_plural_string: { type in
            switch type {
            case .nautical_mile: return "nautical Miles"
            case .foot: return "feet"
            case .inch: return "inches"
            default: return nil
            }
        }
        
        validate_unit {
            return MassUnit(prefix: prefix, type: MassUnitType.dalton, value: "1")
        } get_plural_string: { type in
            return type == .dalton ? "dalton" : nil
        }
        
        validate_unit {
            return PressureUnit(prefix: prefix, type: PressureUnitType.pascal, value: "1")
        } get_type_string: { type in
            return type == .standard_atmosphere ? "standard Atmosphere" : nil
        } get_plural_string: { type in
            switch type {
            case .pound_per_square_inch: return "pounds per square inch"
            case .standard_atmosphere: return "standard Atmosphere"
            default: return nil
            }
        }
        
        validate_unit {
            return SpeedUnit(prefix: prefix, type: SpeedUnitType.foot_per_second, value: "1")
        } get_plural_string: { type in
            switch type {
            case .foot_per_second: return "feet per second"
            case .kilometre_per_hour: return "kilometres per hour"
            case .metre_per_second: return "metres per second"
            case .mile_per_hour: return "miles per hour"
            default: return nil
            }
        }
        
        validate_unit {
            return TemperatureUnit(prefix: prefix, type: TemperatureUnitType.celsius, value: "1")
        } get_plural_string: { type in
            return type.rawValue
        } get_number_suffix: { type in
            return type == .kelvin ? "" : "°"
        }
        
        validate_unit {
            return TimeUnit(prefix: prefix, type: TimeUnitType.century, value: "1")
        } get_plural_string: { type in
            switch type {
            case .century: return "centuries"
            case .millennium: return "millennia"
            default: return nil
            }
        }
    }
    private func validate_unit<U: SwiftUnits.Unit>(_ get_unit: () -> U, get_type_string: ((U.TargetUnitType) -> String?)? = nil, get_plural_string: ((U.TargetUnitType) -> String?)? = nil, get_number_suffix: ((U.TargetUnitType) -> String?)? = nil) {
        var unit:U = get_unit()
        let is_normal:Bool = unit.prefix == .normal
        var prefix_key:String = "\(unit.prefix)"
        prefix_key = prefix_key.prefix(1).uppercased() + prefix_key.suffix(prefix_key.count-1)
        
        let five:HugeFloat = HugeFloat("5")
        
        for type in U.TargetUnitType.allCases {
            unit.type = type
            unit.value = five
            var string:String = unit.description
            var type_string:String
            if let test:String = get_type_string?(type) {
                type_string = test
            } else {
                type_string = type.rawValue.replacingOccurrences(of: "_", with: " ")
            }
            if is_normal {
                type_string = type_string.prefix(1).uppercased() + type_string.suffix(type_string.count-1)
            } else {
                type_string.insert(contentsOf: prefix_key, at: type_string.startIndex)
            }
            let plural_string:String
            if var test:String = get_plural_string?(type) {
                if is_normal {
                    test = test.prefix(1).uppercased() + test.suffix(test.count-1)
                } else {
                    test.insert(contentsOf: prefix_key, at: test.startIndex)
                }
                plural_string = test
            } else {
                plural_string = type_string + "s"
            }
            let number_suffix:String = (get_number_suffix?(type) ?? "").appending(" ")
            XCTAssert(string.elementsEqual("5.000000" + number_suffix + plural_string), string + ";plural_string=" + plural_string + ";type_string=" + type_string)
            
            unit.value = HugeFloat.one
            string = unit.description
            XCTAssert(string.elementsEqual("1.000000" + number_suffix + type_string), string + ";type_string=" + type_string)
            
            string = unit.type.name(prefix: unit.prefix, 1)
            XCTAssert(string.elementsEqual("1" + number_suffix + type_string), string + ";type_string=" + type_string)
            
            string = unit.type.name(prefix: unit.prefix, Float(1))
            XCTAssert(string.elementsEqual("1.000000" + number_suffix + type_string), string + ";type_string=" + type_string)
            
            string = unit.type.name(prefix: unit.prefix, Double(9.25))
            XCTAssert(string.elementsEqual("9.250000" + number_suffix + plural_string), string + ";plural_string=" + plural_string + ";type_string=" + type_string)
        }
    }
}
