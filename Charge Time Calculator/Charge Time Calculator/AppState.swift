//
//  AppState.swift
//  Charge Time Calculator
//
//  Created by Ronan Furuta on 8/24/22.
//

import Foundation
import ChargeTimeLogic

class AppState: ObservableObject {
    @Published var currentCharge:Int = 20
    @Published var goalCharge: Int = 90
    @Published var startTime: Date = Date()
    @Published var endTime: Date = Date()
    @Published var speed: ChargeSpeed = .fullSpeed
    var appLogic = ChargeLogic()
    init() {
        runCalculation()
    }
   
    func runCalculation() {

        self.endTime = appLogic.getEndTime(start: self.startTime, currentLevel: self.currentCharge, chargeSpeed: self.speed, goalCharge: self.goalCharge)
    }
    func setSpeed(speed: ChargeSpeed) {
        self.speed = speed
        runCalculation()
    }
    func setStartTime(_ date: Date) {
        self.startTime = date
        self.runCalculation()
    }
    func setCurrentCharge(_ level: Int) {
        self.currentCharge = level
        self.runCalculation()
    }
    func setGoalCharge(_ level: Int) {
        self.goalCharge = level
        self.runCalculation()
    }
}
