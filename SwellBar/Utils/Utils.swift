//
//  Utils.swift
//  SwellBar
//
//  Created by Rick Sutherland on 4/23/24.
//

import Foundation

let debugDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss.SSS"
    return formatter
}()

func debugPrint(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    let filename = (file as NSString).lastPathComponent
    let timestamp = debugDateFormatter.string(from: Date())
    print("\(timestamp) [\(filename):\(line) \(function)] - \(message)")
}

struct DataFormatter {
    
    static func metersToFeet(meters: Double) -> String {
        let feetPerMeter = 3.28084
        let feet = meters * feetPerMeter
        return String(format: "%.2f", feet)
    }
    
    static func compassDirection(fromDegrees degrees: Int) -> String {
        // Ensure the angle is within 0-360 degrees
        let angle = Double(degrees).truncatingRemainder(dividingBy: 360.0)
        // Each direction covers 45 degrees. Add 22.5 so the division centers on the direction slice.
        let adjustedAngle = angle + 22.5
        if adjustedAngle >= 0 && adjustedAngle < 45 {
            return "N"
        } else if adjustedAngle >= 45 && adjustedAngle < 90 {
            return "NE"
        } else if adjustedAngle >= 90 && adjustedAngle < 135 {
            return "E"
        } else if adjustedAngle >= 135 && adjustedAngle < 180 {
            return "SE"
        } else if adjustedAngle >= 180 && adjustedAngle < 225 {
            return "S"
        } else if adjustedAngle >= 225 && adjustedAngle < 270 {
            return "SW"
        } else if adjustedAngle >= 270 && adjustedAngle < 315 {
            return "W"
        } else if adjustedAngle >= 315 && adjustedAngle < 360 {
            return "NW"
        } else {
            return "N" // Handles exactly 360 degrees which is effectively north
        }
    }
    
    static func directionToEmoji(fromDegrees degrees: Int) -> String {
        let degrees = degrees - 180
        // Ensure the angle is within 0-360 degrees
        let angle = Double(degrees).truncatingRemainder(dividingBy: 360)
        // Each direction covers 45 degrees. Adding 22.5 centers the division on the middle of each slice.
        let adjustedAngle = angle + 22.5
        
        if adjustedAngle >= 0 && adjustedAngle < 45 {
            return "⬆️"  // North
        } else if adjustedAngle >= 45 && adjustedAngle < 90 {
            return "↗️"  // Northeast
        } else if adjustedAngle >= 90 && adjustedAngle < 135 {
            return "➡️"  // East
        } else if adjustedAngle >= 135 && adjustedAngle < 180 {
            return "↘️"  // Southeast
        } else if adjustedAngle >= 180 && adjustedAngle < 225 {
            return "⬇️"  // South
        } else if adjustedAngle >= 225 && adjustedAngle < 270 {
            return "↙️"  // Southwest
        } else if adjustedAngle >= 270 && adjustedAngle < 315 {
            return "⬅️"  // West
        } else if adjustedAngle >= 315 && adjustedAngle < 360 {
            return "↖️"  // Northwest
        } else {
            return "⬆️"  // Handles exactly 360 degrees which is effectively north
        }
    }
    
    static func celsiusToFahrenheit(celsius: Double) -> Int {
        let fahrenheit = (celsius * 9.0 / 5.0) + 32
        return Int(round(fahrenheit))
    }
}
