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
    func name(prefix: UnitPrefix, _ quantity: HugeInt) -> String
    func name(prefix: UnitPrefix, _ quantity: HugeFloat) -> String
    func name(prefix: UnitPrefix, _ quantity: Int) -> String
    func name(prefix: UnitPrefix, _ quantity: Float) -> String
    func name(prefix: UnitPrefix, _ quantity: Double) -> String
}

public extension String.LocalizationValue.StringInterpolation {
    mutating func appendInterpolation(_ value: UnitCategory) {
        appendLiteral(value.rawValue)
    }
    mutating func appendInterpolation(_ value: any UnitType) {
        appendLiteral(value.rawValue)
    }
}

public extension UnitType {
    var id : String {
        return rawValue
    }
    
    private func locale_name(prefix: UnitPrefix, _ key: String.LocalizationValue) -> String {
        let table_prefix:String = "\(prefix)"
        return String(localized: key, table: "Units" + table_prefix.prefix(1).uppercased() + table_prefix.suffix(table_prefix.count-1), bundle: Bundle.module)
    }
    
    func name(prefix: UnitPrefix, _ quantity: HugeInt) -> String {
        return locale_name(prefix: prefix, "\(Self.category)_\(self) \(quantity)")
    }
    
    func name(prefix: UnitPrefix, _ quantity: HugeFloat) -> String {
        return locale_name(prefix: prefix, "\(Self.category)_\(self) \(quantity)")
    }
    
    func name(prefix: UnitPrefix, _ quantity: Int) -> String {
        return locale_name(prefix: prefix, "\(Self.category)_\(self) \(quantity)")
    }
    
    func name(prefix: UnitPrefix, _ quantity: Float) -> String {
        return locale_name(prefix: prefix, "\(Self.category)_\(self) \(quantity)")
    }
    
    func name(prefix: UnitPrefix, _ quantity: Double) -> String {
        return locale_name(prefix: prefix, "\(Self.category)_\(self) \(quantity)")
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
