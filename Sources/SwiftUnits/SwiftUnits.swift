// The Swift Programming Language
// https://docs.swift.org/swift-book


// MARK: CocoaPods support
import Foundation

private class BundleFinder {}

extension Foundation.Bundle {
    static func get_module() -> Bundle {
        #if COCOAPODS
        return module_cocoapods
        #else
        return Bundle.module
        #endif
    }
    /// Returns the resource bundle associated with the current Swift module.
    private static let module_cocoapods: Bundle = {
        let bundleName = "swift-units_SwiftUnits"
        let overrides: [URL]
        #if DEBUG
        if let override = ProcessInfo.processInfo.environment["PACKAGE_RESOURCE_BUNDLE_URL"] {
            overrides = [URL(fileURLWithPath: override)]
        } else {
            overrides = []
        }
        #else
        overrides = []
        #endif

        let candidates = overrides + [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named swift-units_SwiftUnits")
    }()
}

// MARK: Convenience conversions
public extension ExpressibleByIntegerLiteral {
    func to_unit<T: Unit>(prefix: UnitPrefix = UnitPrefix.normal, unit: T.TargetUnitType) -> T {
        return T.init(prefix: prefix, type: unit, value: "\(self)")
    }
}
public extension ExpressibleByFloatLiteral {
    func to_unit<T: Unit>(prefix: UnitPrefix = UnitPrefix.normal, unit: T.TargetUnitType) -> T {
        return T.init(prefix: prefix, type: unit, value: "\(self)")
    }
}

public extension ExpressibleByIntegerLiteral {
    // MARK: AccelerationUnit
    func metres_per_second_squared() -> AccelerationUnit {
        return to_unit(unit: AccelerationUnitType.metres_per_second_per_second)
    }
    
    // MARK: ActionUnit
    func joule_seconds() -> ActionUnit {
        return to_unit(unit: ActionUnitType.joule_second)
    }
    
    // MARK: DensityUnit
    func kilograms_per_cubic_metre() -> DensityUnit {
        return to_unit(unit: DensityUnitType.kilogram_per_cubic_metre)
    }
    func grams_per_cubmic_centimetre() -> DensityUnit {
        return to_unit(unit: DensityUnitType.gram_per_cubic_centimetre)
    }
    
    // MARK: ElectricChargeUnit
    func coulombs() -> ElectricChargeUnit {
        return to_unit(unit: ElectricChargeUnitType.coulomb)
    }
    
    // MARK: EnergyUnit
    func electronvolts() -> EnergyUnit {
        return to_unit(unit: EnergyUnitType.electronvolt)
    }
    func joules() -> EnergyUnit {
        return to_unit(unit: EnergyUnitType.joule)
    }
    func kilojoules() -> EnergyUnit {
        return to_unit(prefix: UnitPrefix.kilo, unit: EnergyUnitType.joule)
    }
    
    // MARK: ForceUnit
    func newtons() -> ForceUnit {
        return to_unit(unit: ForceUnitType.newton)
    }
    
    // MARK: FrequencyUnit
    func wavelength() -> FrequencyUnit {
        return to_unit(unit: FrequencyUnitType.wavelength_in_metres)
    }
    func hertz() -> FrequencyUnit {
        return to_unit(unit: FrequencyUnitType.hertz)
    }
    func megahertz() -> FrequencyUnit {
        return to_unit(prefix: UnitPrefix.mega, unit: FrequencyUnitType.hertz)
    }
    func gigahertz() -> FrequencyUnit {
        return to_unit(prefix: UnitPrefix.giga, unit: FrequencyUnitType.hertz)
    }
    
    // MARK: MassUnit
    func dalton() -> MassUnit {
        return to_unit(unit: MassUnitType.dalton)
    }
    
    func milligrams() -> MassUnit {
        return to_unit(prefix: UnitPrefix.milli, unit: MassUnitType.gram)
    }
    func grams() -> MassUnit {
        return to_unit(unit: MassUnitType.gram)
    }
    func kilograms() -> MassUnit {
        return to_unit(prefix: UnitPrefix.kilo, unit: MassUnitType.gram)
    }
    
    func ounces() -> MassUnit {
        return to_unit(unit: MassUnitType.ounce)
    }
    func pounds() -> MassUnit {
        return to_unit(unit: MassUnitType.pound)
    }
    func tonnes() -> MassUnit {
        return to_unit(unit: MassUnitType.tonne)
    }
    
    // MARK: PressureUnit
    func pascal() -> PressureUnit {
        return to_unit(unit: PressureUnitType.pascal)
    }
    func hectopascal() -> PressureUnit {
        return to_unit(prefix: UnitPrefix.hecto, unit: PressureUnitType.pascal)
    }
    func kilopascal() -> PressureUnit {
        return to_unit(prefix: UnitPrefix.kilo, unit: PressureUnitType.pascal)
    }
    
    func psi() -> PressureUnit {
        return pounds_per_square_inch()
    }
    func pounds_per_square_inch() -> PressureUnit {
        return to_unit(unit: PressureUnitType.pound_per_square_inch)
    }
    func atmosphere() -> PressureUnit {
        return to_unit(unit: PressureUnitType.standard_atmosphere)
    }
    
    // MARK: SpeedUnit
    func metres_per_second() -> SpeedUnit {
        return to_unit(unit: SpeedUnitType.metre_per_second)
    }
    func kph() -> SpeedUnit {
        return kilometres_per_hour()
    }
    func kilometres_per_hour() -> SpeedUnit {
        return to_unit(unit: SpeedUnitType.kilometre_per_hour)
    }
    
    func mph() -> SpeedUnit {
        return miles_per_hour()
    }
    func miles_per_hour() -> SpeedUnit {
        return to_unit(unit: SpeedUnitType.mile_per_hour)
    }
    
    func knots() -> SpeedUnit {
        return to_unit(unit: SpeedUnitType.knot)
    }
    func feet_per_second() -> SpeedUnit {
        return to_unit(unit: SpeedUnitType.foot_per_second)
    }
    
    // MARK: TemperatureUnit
    func fahrenheit() -> TemperatureUnit {
        return to_unit(unit: TemperatureUnitType.fahrenheit)
    }
    func celsius() -> TemperatureUnit {
        return to_unit(unit: TemperatureUnitType.celsius)
    }
    func kelvin() -> TemperatureUnit {
        return to_unit(unit: TemperatureUnitType.kelvin)
    }
    func rankine() -> TemperatureUnit {
        return to_unit(unit: TemperatureUnitType.rankine)
    }
    
    // MARK: TimeUnit
    func seconds() -> TimeUnit {
        return to_unit(unit: TimeUnitType.second)
    }
    func minutes() -> TimeUnit {
        return to_unit(unit: TimeUnitType.minute)
    }
    func hours() -> TimeUnit {
        return to_unit(unit: TimeUnitType.hour)
    }
    func days() -> TimeUnit {
        return to_unit(unit: TimeUnitType.day)
    }
    func weeks() -> TimeUnit {
        return to_unit(unit: TimeUnitType.week)
    }
    func years() -> TimeUnit {
        return to_unit(unit: TimeUnitType.year)
    }
    func decades() -> TimeUnit {
        return to_unit(unit: TimeUnitType.decade)
    }
    func centuries() -> TimeUnit {
        return to_unit(unit: TimeUnitType.century)
    }
    func millennium() -> TimeUnit {
        return to_unit(unit: TimeUnitType.millennium)
    }
}
