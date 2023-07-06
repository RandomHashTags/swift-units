import XCTest
@testable import SwiftUnits
import HugeNumbers

// https://www.calculateme.com
final class SwiftUnitsTests: XCTestCase {
    func testExample() {
        test_unit_conversion_density()
        test_unit_conversion_frequency()
        test_unit_conversion_mass()
        test_unit_conversion_temperature()
        
        test_unit_conversion_mass_to_energy()
    }
    private func test_unit_conversion_density() {
        var result:DensityUnit = DensityUnit(type: DensityUnitType.gram_per_cubic_centimetre, value: HugeFloat.one).to_unit(unit: DensityUnitType.kilogram_per_cubic_metre)
        var expected_result:DensityUnit = DensityUnit(type: DensityUnitType.kilogram_per_cubic_metre, value: HugeFloat("1000"))
        XCTAssert(result == expected_result, "test_unit_conversion_density;result=\(result);expected_result=\(expected_result)")
        
        result = expected_result.to_unit(unit: DensityUnitType.gram_per_cubic_centimetre)
        expected_result = DensityUnit(type: DensityUnitType.gram_per_cubic_centimetre, value: HugeFloat.one)
        XCTAssert(result == expected_result, "test_unit_conversion_density;result=\(result);expected_result=\(expected_result)")
    }
    private func test_unit_conversion_frequency() {
        var result:FrequencyUnit = FrequencyUnit(type: FrequencyUnitType.hertz, value: HugeFloat.one).to_unit(unit: FrequencyUnitType.wavelength_in_metres)
        var expected_result:FrequencyUnit = FrequencyUnit(type: FrequencyUnitType.wavelength_in_metres, value: HugeFloat("299792458"))
        XCTAssert(result == expected_result, "test_unit_conversion_frequency;result=\(result);expected_result=\(expected_result)")
        
        result = expected_result.to_unit(unit: FrequencyUnitType.hertz)
        expected_result = FrequencyUnit(type: FrequencyUnitType.hertz, value: HugeFloat.one)
        XCTAssert(result == expected_result, "test_unit_conversion_frequency;result=\(result);expected_result=\(expected_result)")
    }
    private func test_unit_conversion_mass() {
        var result:MassUnit = MassUnit(type: MassUnitType.gram, value: HugeFloat("1000000")).to_unit(unit: MassUnitType.tonne)
        var expected_result:MassUnit = MassUnit(type: MassUnitType.tonne, value: HugeFloat.one)
        XCTAssert(result == expected_result, "test_unit_conversion_mass;result=\(result);expected_result=\(expected_result)")
        
        result = expected_result.to_unit(unit: MassUnitType.gram)
        expected_result = MassUnit(type: MassUnitType.gram, value: HugeFloat("1000000"))
        XCTAssert(result == expected_result, "test_unit_conversion_mass;result=\(result);expected_result=\(expected_result)")
    }
    private func test_unit_conversion_temperature() {
        var result:TemperatureUnit = TemperatureUnit(type: TemperatureUnitType.fahrenheit, value: HugeFloat(string: "-40")).to_unit(unit: TemperatureUnitType.celsius)
        var expected_result:TemperatureUnit = TemperatureUnit(type: TemperatureUnitType.celsius, value: HugeFloat("-40"))
        XCTAssert(result == expected_result, "test_unit_conversion_temperature;result=\(result);expected_result=\(expected_result)")
        
        result = TemperatureUnit(type: TemperatureUnitType.fahrenheit, value: HugeFloat("32")).to_unit(unit: TemperatureUnitType.celsius)
        expected_result = TemperatureUnit(type: TemperatureUnitType.celsius, value: HugeFloat.zero)
        XCTAssert(result == expected_result, "test_unit_conversion_temperature;result=\(result);expected_result=\(expected_result)")
    }
    
    private func test_unit_conversion_mass_to_energy() {
        let kilogram_to_joules:EnergyUnit = MassUnit(prefix: UnitPrefix.kilo, type: MassUnitType.gram, value: HugeFloat.one).to_energy()
        XCTAssert(kilogram_to_joules == EnergyUnit(type: EnergyUnitType.joule, value: HugeFloat("89875517873681764")))
        let kilogram_to_electronvolt:EnergyUnit = kilogram_to_joules.to_unit(unit: EnergyUnitType.electronvolt)
        XCTAssert(kilogram_to_electronvolt == EnergyUnit(type: EnergyUnitType.electronvolt, value: HugeFloat("560958884538931987162813850074640384")))
        let electronvolt_to_mass:MassUnit = kilogram_to_electronvolt.to_mass()
        XCTAssert(electronvolt_to_mass == MassUnit(prefix: UnitPrefix.kilo, type: MassUnitType.gram, value: HugeFloat("1")), "test_unit_conversion_mass_to_energy;joule_to_mass=\(electronvolt_to_mass)")
    }
}
