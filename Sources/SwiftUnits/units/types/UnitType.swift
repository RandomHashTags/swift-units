//
//  UnitType.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation

/// An enum that contains all the unit types of a certain value. The unit types should be organized in decending order by order of magnitude. (Every case is greater than the case above it)
public protocol UnitType : Identifiable, CaseIterable, Equatable, RawRepresentable where RawValue == String, ID == String {
    var symbol : String { get }
}
public extension UnitType {
    var id : String {
        return rawValue
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
