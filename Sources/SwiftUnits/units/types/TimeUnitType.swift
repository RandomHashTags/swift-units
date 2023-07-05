//
//  TimeUnitType.swift
//  
//
//  Created by Evan Anderson on 4/25/23.
//

import Foundation

public enum TimeUnitType : String, UnitType {
    case second
    case minute
    case hour
    case day
    case week
    /// measured as 30 days
    case month
    /// measured as 365.25 days
    case year
    /// measured as 10 years
    case decade
    case century
    case millennium
    
    public var symbol : String {
        switch self {
        case .second: return "s"
        case .minute: return "min"
        case .hour: return "hr"
        case .day: return "d"
        case .week: return "week"
        case .month: return "mo"
        case .year: return "yr"
        case .decade: return "decade"
        case .century: return "century"
        case .millennium: return "millennium"
        }
    }
}
