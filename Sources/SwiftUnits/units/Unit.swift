//
//  Unit.swift
//
//  Created by Evan Anderson on 4/6/23.
//

import Foundation
import HugeNumbers

public protocol Unit : Hashable, Comparable, CustomStringConvertible {
    associatedtype TargetUnitType : UnitType
    
    var prefix : UnitPrefix { get set }
    var type : TargetUnitType { get set }
    var value : HugeFloat { get set }
    
    init(type: TargetUnitType, value: String)
    init(type: TargetUnitType, value: HugeFloat)
    init(prefix: UnitPrefix, type: TargetUnitType, value: String)
    init(prefix: UnitPrefix, type: TargetUnitType, value: HugeFloat)
    
    mutating func convert_to_unit(_ unit: TargetUnitType)
    func convert_value_to_unit(_ unit: TargetUnitType) -> HugeFloat
    func convert_value_to_unit(prefix: UnitPrefix, _ unit: TargetUnitType) -> HugeFloat
    func to_unit(unit: TargetUnitType) -> Self
    func to_unit(prefix: UnitPrefix, unit: TargetUnitType) -> Self
}

// MARK: Defaults
public extension Unit {
    init(type: TargetUnitType, value: String) {
        self.init(prefix: UnitPrefix.normal, type: type, value: value)
    }
    init(type: TargetUnitType, value: HugeFloat) {
        self.init(prefix: UnitPrefix.normal, type: type, value: value)
    }
    init(prefix: UnitPrefix, type: TargetUnitType, value: String) {
        self.init(prefix: prefix, type: type, value: HugeFloat(value))
    }
    
    var symbol : String {
        return prefix.symbol + type.symbol
    }
    
    var is_zero : Bool {
        return value.is_zero
    }
    
    var description : String {
        return "\(value) " + symbol
    }
    
    mutating func convert_to_unit(_ unit: TargetUnitType) {
        // TODO: finish
    }
    
    func convert_value_to_unit(prefix: UnitPrefix, _ unit: TargetUnitType) -> HugeFloat {
        return self.prefix.convert_to(prefix, value: convert_value_to_unit(unit))
    }
    func to_unit(unit: TargetUnitType) -> Self {
        return to_unit(prefix: prefix, unit: unit)
    }
    func to_unit(prefix: UnitPrefix, unit: TargetUnitType) -> Self {
        let value:HugeFloat = convert_value_to_unit(prefix: prefix, unit)
        return Self(prefix: prefix, type: unit, value: value)
    }
}

// MARK: Comparable
public extension Unit {
    static func < (left: Self, right: Self) -> Bool {
        let left_prefix:UnitPrefix = left.prefix, right_prefix:UnitPrefix = right.prefix
        guard left_prefix == right_prefix else {
            return left_prefix.rawValue < right_prefix.rawValue
        }
        let left_type:TargetUnitType = left.type, right_type:TargetUnitType = right.type
        guard left_type == right_type else {
            return left.value < right.convert_value_to_unit(left_type)
        }
        return left.value < right.value
    }
    static func <= (left: Self, right: Self) -> Bool {
        let left_prefix:UnitPrefix = left.prefix, right_prefix:UnitPrefix = right.prefix
        guard left_prefix == right_prefix else {
            return left_prefix.rawValue <= right_prefix.rawValue
        }
        let left_type:TargetUnitType = left.type, right_type:TargetUnitType = right.type
        guard left_type == right_type else {
            return left.value <= right.convert_value_to_unit(left_type)
        }
        return left.value <= right.value
    }
}
public extension Unit {
    static func == (left: Self, right: Self) -> Bool {
        return left.prefix == right.prefix && left.type == right.type && left.value == right.value
    }
}
public extension Unit {
    static func > (left: Self, right: Self) -> Bool {
        let left_prefix:UnitPrefix = left.prefix, right_prefix:UnitPrefix = right.prefix
        guard left_prefix == right_prefix else {
            return left_prefix.rawValue > right_prefix.rawValue
        }
        let left_type:TargetUnitType = left.type, right_type:TargetUnitType = right.type
        guard left_type == right_type else {
            return left.value > right.convert_value_to_unit(left_type)
        }
        return left.value > right.value
    }
    static func >= (left: Self, right: Self) -> Bool {
        let left_prefix:UnitPrefix = left.prefix, right_prefix:UnitPrefix = right.prefix
        guard left_prefix == right_prefix else {
            return left_prefix.rawValue >= right_prefix.rawValue
        }
        let left_type:TargetUnitType = left.type, right_type:TargetUnitType = right.type
        guard left_type == right_type else {
            return left.value >= right.convert_value_to_unit(left_type)
        }
        return left.value >= right.value
    }
}

// MARK: prefixes / postfixes
public extension Unit {
    static prefix func - (item: Self) -> Self {
        return Self(prefix: item.prefix, type: item.type, value: -item.value)
    }
}

// MARK: Addition
public extension Unit {
    static func + (left: Self, right: Self) -> Self {
        let left_type:TargetUnitType = left.type, left_prefix:UnitPrefix = left.prefix
        let right_updated:Self = right.to_unit(prefix: left_prefix, unit: left_type)
        return Self(prefix: left_prefix, type: left_type, value: left.value + right_updated.value)
    }
    
    static func += (left: inout Self, right: Self) {
        left = left + right
    }
}

// MARK: Subtraction
public extension Unit {
    static func - (left: Self, right: Self) -> Self {
        let left_type:TargetUnitType = left.type, left_prefix:UnitPrefix = left.prefix
        let right_updated:Self = right.to_unit(prefix: left_prefix, unit: left_type)
        return Self(prefix: left_prefix, type: left_type, value: left.value - right_updated.value)
    }
    
    static func -= (left: inout Self, right: Self) {
        left = left - right
    }
}

// MARK: Multiplication
public extension Unit {
    static func * (left: Self, right: Self) -> Self {
        let left_type:TargetUnitType = left.type, left_prefix:UnitPrefix = left.prefix
        let right_updated:Self = right.to_unit(prefix: left_prefix, unit: left_type)
        return Self(prefix: left_prefix, type: left_type, value: left.value * right_updated.value)
    }
}
public extension Unit {
    static func * (left: Self, right: HugeFloat) -> Self {
        var copy:Self = left
        copy.value *= right
        return copy
    }
    static func * (left: HugeFloat, right: Self) -> Self {
        var copy:Self = right
        copy.value *= left
        return copy
    }
    
    static func * (left: Self, right: HugeInt) -> Self {
        return left * right.to_float
    }
    static func * (left: HugeInt, right: Self) -> Self {
        return right * left.to_float
    }
}

// MARK: Division
public extension Unit {
    static func / (left: Self, right: HugeFloat) -> Self {
        var copy:Self = left
        copy.value = copy.value / right
        return copy
    }
}
