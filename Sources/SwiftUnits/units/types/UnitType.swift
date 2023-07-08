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
        // TODO: fix (doesn't support any number larger than UInt64.max)
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
        let key:String.LocalizationValue = String.LocalizationValue(stringLiteral: "\(1)")
        return String(localized: key, table: "Units", bundle: Bundle.module)
    }
    func name(_ quantity: HugeFloat) -> String {
        let key:String.LocalizationValue
        switch Self.category {
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
        default:
            return "UNKNOWN"
        }
        return String(localized: key, table: "Units", bundle: Bundle.module)
    }
    func name(_ quantity: Int) -> String {
        let key:String.LocalizationValue = String.LocalizationValue(stringLiteral: "\(1)")
        return String(localized: key, table: "Units", bundle: Bundle.module)
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
