import XCTest
@testable import SwiftUnits
import HugeNumbers

// https://www.calculateme.com
// https://www.calculatorsoup.com
final class SwiftUnitsTests : XCTestCase {
    func test_conversion_electric_potential() {
        var result:ElectricPotentialUnit = ElectricPotentialUnit(type: ElectricPotentialUnitType.volt, value: HugeFloat.one).to_unit(unit: ElectricPotentialUnitType.statvolt)
        var expected_result:ElectricPotentialUnit = ElectricPotentialUnit(type: ElectricPotentialUnitType.statvolt, value: "0.0033356409519815")
        XCTAssertEqual(result, expected_result)
        
        result = expected_result.to_unit(unit: ElectricPotentialUnitType.abvolt)
        expected_result = ElectricPotentialUnit(type: ElectricPotentialUnitType.abvolt, value: "100000000")
        XCTAssertEqual(result.description, expected_result.description, result.value.description + ";" + expected_result.value.description)
        
        result = expected_result.to_unit(unit: ElectricPotentialUnitType.volt)
        expected_result = ElectricPotentialUnit(type: ElectricPotentialUnit.TargetUnitType.volt, value: HugeFloat.one)
        XCTAssertEqual(result, expected_result)
    }
    func test_conversion_density() {
        var result:DensityUnit = DensityUnit(type: DensityUnitType.gram_per_cubic_centimetre, value: HugeFloat.one).to_unit(unit: DensityUnitType.kilogram_per_cubic_metre)
        var expected_result:DensityUnit = DensityUnit(type: DensityUnitType.kilogram_per_cubic_metre, value: "1000")
        XCTAssertEqual(result, expected_result)
        
        result = expected_result.to_unit(unit: DensityUnitType.gram_per_cubic_centimetre)
        expected_result = DensityUnit(type: DensityUnitType.gram_per_cubic_centimetre, value: HugeFloat.one)
        XCTAssertEqual(result, expected_result)
    }
    func test_conversion_frequency() {
        var result:FrequencyUnit = FrequencyUnit(type: FrequencyUnitType.hertz, value: HugeFloat.one).to_unit(unit: FrequencyUnitType.wavelength_in_metres)
        var expected_result:FrequencyUnit = FrequencyUnit(type: FrequencyUnitType.wavelength_in_metres, value: "299792458")
        XCTAssertEqual(result, expected_result)
        
        result = expected_result.to_unit(unit: FrequencyUnitType.hertz)
        expected_result = FrequencyUnit(type: FrequencyUnitType.hertz, value: HugeFloat.one)
        XCTAssertEqual(result, expected_result)
    }
    func test_conversion_substance() {
        var result:SubstanceUnit = SubstanceUnit(type: SubstanceUnitType.mole, value: "1").to_unit(unit: SubstanceUnitType.elementary_entities)
        var expected_result:SubstanceUnit = SubstanceUnit(type: SubstanceUnitType.elementary_entities, value: "602214076000000000000000")
        XCTAssertEqual(result, expected_result)
        
        result = expected_result.to_unit(unit: SubstanceUnitType.mole)
        expected_result = SubstanceUnit(type: SubstanceUnitType.mole, value: HugeFloat.one)
        XCTAssertEqual(result, expected_result)
    }
    func test_conversion_mass() {
        var result:MassUnit = MassUnit(type: MassUnitType.gram, value: "1000000").to_unit(unit: MassUnitType.tonne)
        var expected_result:MassUnit = MassUnit(type: MassUnitType.tonne, value: HugeFloat.one)
        XCTAssertEqual(result, expected_result)
        
        result = expected_result.to_unit(unit: MassUnitType.gram)
        expected_result = MassUnit(type: MassUnitType.gram, value: "1000000")
        XCTAssertEqual(result, expected_result)
    }
    func test_conversion_temperature() {
        var result:TemperatureUnit = TemperatureUnit(type: TemperatureUnitType.fahrenheit, value: "-40").to_unit(unit: TemperatureUnitType.celsius)
        var expected_result:TemperatureUnit = TemperatureUnit(type: TemperatureUnitType.celsius, value: "-40")
        XCTAssertEqual(result, expected_result)
        
        result = TemperatureUnit(type: TemperatureUnitType.fahrenheit, value: "32").to_unit(unit: TemperatureUnitType.celsius)
        expected_result = TemperatureUnit(type: TemperatureUnitType.celsius, value: HugeFloat.zero)
        XCTAssertEqual(result, expected_result)
    }
    
    func test_conversion_mass_to_energy() {
        let kilogram_to_joules:EnergyUnit = MassUnit(prefix: UnitPrefix.kilo, type: MassUnitType.gram, value: HugeFloat.one).to_energy()
        XCTAssertEqual(kilogram_to_joules, EnergyUnit(type: EnergyUnitType.joule, value: "89875517873681764"))
        
        let kilogram_to_electronvolt:EnergyUnit = kilogram_to_joules.to_unit(unit: EnergyUnitType.electronvolt)
        XCTAssertEqual(kilogram_to_electronvolt, EnergyUnit(type: EnergyUnitType.electronvolt, value: "560958884538931987162813850074640384"))
        
        let electronvolt_to_mass:MassUnit = kilogram_to_electronvolt.to_mass()
        XCTAssertEqual(electronvolt_to_mass, MassUnit(prefix: UnitPrefix.kilo, type: MassUnitType.gram, value: HugeFloat.one), "joule_to_mass=\(electronvolt_to_mass)")
    }
}
