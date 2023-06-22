//
//  TargetDevice.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 14.06.2023.
//


#if !os(macOS)
import UIKit
#endif


enum TargetDevice {
    case nativeMac
    case iPad
    case iPhone
    case iWatch
    
    public static var currentDevice: Self {
        var currentDeviceModel: String = ""
        #if os(macOS)
        currentDeviceModel = "nativeMac"
        #elseif os(watchOS)
        currentDeviceModel = "watchOS"
        #elseif os(iOS)
        currentDeviceModel = UIDevice.current.model
        #endif
        if currentDeviceModel.starts(with: "iPhone") {
            return .iPhone
        }
        if currentDeviceModel.starts(with: "iPad") {
            return .iPad
        }
        if currentDeviceModel.starts(with: "watchOS") {
            return .iWatch
        }
        return .nativeMac
    }
}
