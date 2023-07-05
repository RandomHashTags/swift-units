// The Swift Programming Language
// https://docs.swift.org/swift-book

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
    // MARK: MassUnit
    func milligrams() -> MassUnit {
        return to_unit(prefix: UnitPrefix.milli, unit: MassUnitType.gram)
    }
    func grams() -> MassUnit {
        return to_unit(unit: MassUnitType.gram)
    }
    func kilograms() -> MassUnit {
        return to_unit(prefix: UnitPrefix.kilo, unit: MassUnitType.gram)
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
}
