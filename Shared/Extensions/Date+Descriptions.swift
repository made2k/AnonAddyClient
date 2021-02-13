//
//  Date+Descriptions.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/14/21.
//

import Foundation

extension Date {
  
  /**
   Get the description of a date in age since now.
   
   - Returns: An age description. For example, if the date was yesterday
   it would return "1 day". If the date was 2 weeks ago it would return "2 weeks".
   */
  func ageDescription() -> String {
    
    let interval: TimeInterval = abs(timeIntervalSinceNow)
    
    // If less than a day
    if interval < 60 * 60 * 24 {
      let seconds: Int = Int(interval)
      
      switch seconds {
      case 0..<60:
        return "\(seconds) seconds"
        
      case 60..<60*60:
        let minutes = seconds / 60
        return "\(minutes) minutes"
        
      default:
        let hours = seconds / 60 / 60
        if hours == 1 {
          return "1 hour"
        }
        return "\(hours) hours"
      }
      
    }
    
    let days: Int = Int(round(interval / 60.0 / 60.0 / 24.0))
    
    switch days {
    case 1:
      return "1 day"
      
    case 0..<31:
      return "\(days) days"
      
    case 30..<60:
      return "1 month"
      
    case 30..<365:
      let months: Int = Int(round(Double(days) / 30.0))
      return "\(months) months"
      
    case 365..<356*2:
      return "1 year"
      
    default:
      let years: Int = days / 365
      return "\(years) years"
    }
    
  }
  
}
