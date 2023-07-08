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
            return MassUnit(type: MassUnitType.dalton, value: "1")
        } get_plural_string: { type in
            return type == .dalton ? "Dalton" : nil
        }
    }
    private func validate_unit<U: SwiftUnits.Unit>(_ get_unit: () -> U, get_type_string: ((U.TargetUnitType) -> String?)? = nil, get_plural_string: ((U.TargetUnitType) -> String?)? = nil) {
        for type in U.TargetUnitType.allCases {
            var mass:U = U(type: type, value: "5")
            var string:String = mass.description
            var type_string:String
            if let test:String = get_type_string?(type) {
                type_string = test
            } else {
                type_string = type.rawValue
                type_string = type_string.prefix(1).uppercased() + type_string.suffix(type_string.count-1)
            }
            let plural_string:String = get_plural_string?(type) ?? type_string + "s"
            XCTAssert(string.elementsEqual("5.000000 " + plural_string), string)
            
            mass.value = HugeFloat.one
            string = mass.description
            XCTAssert(string.elementsEqual("1.000000 " + type_string), string)
            
            string = mass.type.get_name(1)
            XCTAssert(string.elementsEqual("1 " + type_string), string)
            
            string = mass.type.get_name(Float(1))
            XCTAssert(string.elementsEqual("1.000000 " + type_string), string)
            
            string = mass.type.get_name(Double(9.25))
            XCTAssert(string.elementsEqual("9.250000 " + plural_string), string)
        }
    }
}
