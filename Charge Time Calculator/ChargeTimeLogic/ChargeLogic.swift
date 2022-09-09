//
//  ChargeLogic.swift
//  ChargeTimeLogic
//
//  Created by Ronan Furuta on 8/24/22.
//

import Foundation


public enum ChargeSpeed: String {
    case unkown = "Unknown"
    case varies = "Varies"
    case fullSpeed = "Full Speed"
}
public class ChargeLogic {
    public init() {
        
    }
    public func getEndTime(start: Date, currentLevel: Int, chargeSpeed: ChargeSpeed, goalCharge: Int) -> Date {
        
        let chargeToGo:Double = Double(goalCharge-currentLevel)
        let milesToPutIn:Double = (chargeToGo/100)*225
        let hoursToCharge:Double = milesToPutIn / self.getChargeRate(chargeSpeed)
        
        return Date(timeInterval: Double(hoursToCharge * 3600), since: start)
    }
    public func getFloorFromSpeed(speed: ChargeSpeed) -> String {
        switch speed {
        case .unkown:
            return "B"
        case .varies:
            return "C"
        case .fullSpeed:
            return "E/G" //22
        }
    }
    public func getChargeRate(_ chargeSpeed: ChargeSpeed) -> Double {
        switch chargeSpeed {
        case .unkown:
            return 11
        case .varies:
            return 11
        case .fullSpeed:
            return 22
        }
    }
   
}
