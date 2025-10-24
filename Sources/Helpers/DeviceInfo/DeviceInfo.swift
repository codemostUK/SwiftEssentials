//
//  Device.swift
//  Device
//
//  Created by Lucas Ortis on 30/10/2015.
//  Copyright © 2015 Ekhoo. All rights reserved.
//

#if os(iOS)
import UIKit

open class DeviceInfo {

    static fileprivate func getVersionCode() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let versionCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!

        return versionCode
    }

    static fileprivate func getVersion(code: String) -> Version {
        switch code {
                /*** iPhone ***/
            case "iPhone1,1":                                return .iPhone2G
            case "iPhone1,2":                                return .iPhone3G
            case "iPhone2,1":                                return .iPhone3GS
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return .iPhone4
            case "iPhone4,1", "iPhone4,2", "iPhone4,3":      return .iPhone4S
            case "iPhone5,1", "iPhone5,2":                   return .iPhone5
            case "iPhone5,3", "iPhone5,4":                   return .iPhone5C
            case "iPhone6,1", "iPhone6,2":                   return .iPhone5S
            case "iPhone7,2":                                return .iPhone6
            case "iPhone7,1":                                return .iPhone6Plus
            case "iPhone8,1":                                return .iPhone6S
            case "iPhone8,2":                                return .iPhone6SPlus
            case "iPhone8,3", "iPhone8,4":                   return .iPhoneSE
            case "iPhone9,1", "iPhone9,3":                   return .iPhone7
            case "iPhone9,2", "iPhone9,4":                   return .iPhone7Plus
            case "iPhone10,1", "iPhone10,4":                 return .iPhone8
            case "iPhone10,2", "iPhone10,5":                 return .iPhone8Plus
            case "iPhone10,3", "iPhone10,6":                 return .iPhoneX
            case "iPhone11,2":                               return .iPhoneXS
            case "iPhone11,4", "iPhone11,6":                 return .iPhoneXS_Max
            case "iPhone11,8":                               return .iPhoneXR
            case "iPhone12,1":                               return .iPhone11
            case "iPhone12,3":                               return .iPhone11Pro
            case "iPhone12,5":                               return .iPhone11Pro_Max
            case "iPhone12,8":                               return .iPhoneSE2
            case "iPhone13,1":                               return .iPhone12Mini
            case "iPhone13,2":                               return .iPhone12
            case "iPhone13,3":                               return .iPhone12Pro
            case "iPhone13,4":                               return .iPhone12Pro_Max
            case "iPhone14,4":                               return .iPhone13Mini
            case "iPhone14,5":                               return .iPhone13
            case "iPhone14,2":                               return .iPhone13Pro
            case "iPhone14,3":                               return .iPhone13Pro_Max
            case "iPhone14,6":                               return .iPhoneSE3
            case "iPhone14,7":                               return .iPhone14
            case "iPhone14,8":                               return .iPhone14Plus
            case "iPhone15,2":                               return .iPhone14Pro
            case "iPhone15,3":                               return .iPhone14Pro_Max
            case "iPhone15,4":                               return .iPhone15
            case "iPhone15,5":                               return .iPhone15Plus
            case "iPhone16,1":                               return .iPhone15Pro
            case "iPhone16,2":                               return .iPhone15Pro_Max
            case "iPhone17,3":                               return .iPhone16
            case "iPhone17,4":                               return .iPhone16Plus
            case "iPhone17,1":                               return .iPhone16Pro
            case "iPhone17,2":                               return .iPhone16Pro_Max
            case "iPhone17,5":                               return .iPhone16e
            case "iPhone18,1":                               return .iPhone17Pro
            case "iPhone18,2":                               return .iPhone17Pro_Max
            case "iPhone18,3":                               return .iPhone17
            case "iPhone18,4":                               return .iPhoneAir

                /*** iPad ***/
            case "iPad1,1", "iPad1,2":                       return .iPad1
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
            case "iPad3,1", "iPad3,2", "iPad3,3":            return .iPad3
            case "iPad3,4", "iPad3,5", "iPad3,6":            return .iPad4
            case "iPad6,11", "iPad6,12":                     return .iPad5
            case "iPad7,5", "iPad7,6":                       return .iPad6
            case "iPad7,11", "iPad7,12":                     return .iPad7
            case "iPad11,6", "iPad11,7":                     return .iPad8
            case "iPad12,1", "iPad12,2":                     return .iPad9
            case "iPad13,18", "iPad13,19":                   return .iPad10
            case "iPad4,1", "iPad4,2", "iPad4,3":            return .iPadAir
            case "iPad5,3", "iPad5,4":                       return .iPadAir2
            case "iPad11,3", "iPad11,4":                     return .iPadAir3
            case "iPad13,1", "iPad13,2":                     return .iPadAir4
            case "iPad13,16", "iPad13,17":                   return .iPadAir5
            case "iPad2,5", "iPad2,6", "iPad2,7":            return .iPadMini
            case "iPad4,4", "iPad4,5", "iPad4,6":            return .iPadMini2
            case "iPad4,7", "iPad4,8", "iPad4,9":            return .iPadMini3
            case "iPad5,1", "iPad5,2":                       return .iPadMini4
            case "iPad11,1", "iPad11,2":                     return .iPadMini5
            case "iPad14,1", "iPad14,2":                     return .iPadMini6
            case "iPad14,8", "iPad14,9":                     return .iPadAirM2_11Inch
            case "iPad14,10", "iPad14,11":                   return .iPadAirM2_13Inch
            case "iPad15,3", "iPad15,4":                     return .iPadAirM3_11Inch
            case "iPad15,5", "iPad15,6":                     return .iPadAirM3_13Inch

                /*** iPadPro ***/
            case "iPad6,3", "iPad6,4":                       return .iPadPro9_7Inch
            case "iPad6,7", "iPad6,8":                       return .iPadPro12_9Inch
            case "iPad7,1", "iPad7,2":                       return .iPadPro12_9Inch2
            case "iPad7,3", "iPad7,4":                       return .iPadPro10_5Inch
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return .iPadPro11_0Inch
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return .iPadPro12_9Inch3
            case "iPad8,9", "iPad8,10":                      return .iPadPro11_0Inch2
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7": return .iPadPro11_0Inch3
            case "iPad8,11", "iPad8,12":                     return .iPadPro12_9Inch4
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11": return .iPadPro12_9Inch5
            case "iPad14,3", "iPad14,4":                     return .iPadPro11_0Inch4
            case "iPad14,5", "iPad14,6":                     return .iPadPro12_9Inch6
            case "iPad16,3", "iPad16,4":                     return .iPadProM4_11Inch
            case "iPad16,5", "iPad16,6":                     return .iPadProM4_13Inch

                /*** iPod ***/
            case "iPod1,1":                                  return .iPodTouch1Gen
            case "iPod2,1":                                  return .iPodTouch2Gen
            case "iPod3,1":                                  return .iPodTouch3Gen
            case "iPod4,1":                                  return .iPodTouch4Gen
            case "iPod5,1":                                  return .iPodTouch5Gen
            case "iPod7,1":                                  return .iPodTouch6Gen
            case "iPod9,1":                                  return .iPodTouch7Gen

                /*** Simulator ***/
            case "i386", "x86_64", "arm64":                  return .simulator

            default:
                assertionFailure("New Device Found! Model Code:\(code). Please create a PR to the repo.")
                return .unknown
        }
    }

    static fileprivate func getType(code: String) -> Type {
        let versionCode = getVersionCode()

        if versionCode.contains("iPhone") {
            return .iPhone
        } else if versionCode.contains("iPad") {
            return .iPad
        } else if versionCode.contains("iPod") {
            return .iPod
        } else if versionCode == "i386" || versionCode == "x86_64" || versionCode == "arm64" {
            return .simulator
        } else {
            return .unknown
        }
    }

    static public func version() -> Version {
        return getVersion(code: getVersionCode())
    }

    static public func size() -> Size {
        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(w, h)

        switch screenHeight {
            case 240, 480:
                return .screen3_5Inch
            case 568:
                return .screen4Inch
            case 667:
                return UIScreen.main.scale == 3.0 ? .screen5_5Inch : .screen4_7Inch
            case 736:
                return .screen5_5Inch
            case 812:
                switch version() {
                    case .iPhone12Mini:
                        return .screen5_4Inch
                    default:
                        return .screen5_8Inch
                }
            case 844:
                return .screen6_1Inch
            case 852:
                return .screen6_1Inch_2
            case 874:
                return .screen6_3Inch
            case 896:
                switch version() {
                    case .iPhoneXS_Max, .iPhone11Pro_Max:
                        return .screen6_5Inch
                    default:
                        return .screen6_1Inch
                }
            case 926:
                return .screen6_7Inch
            case 932:
                return .screen6_7Inch_2
            case 956:
                return .screen6_9Inch
            case 1024:
                switch version() {
                    case .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadMini5:
                        return .screen7_9Inch
                    case .iPadPro10_5Inch:
                        return .screen10_5Inch
                    default:
                        return .screen9_7Inch
                }
            case 1080:
                return .screen10_2Inch
            case 1112:
                return .screen10_5Inch
            case 1180:
                return .screen10_9Inch
            case 1194, 1210:
                return .screen11Inch
            case 1366:
                return .screen12_9Inch
            case 1376:
                return .screen13Inch
            default:
                return .unknownSize
        }
    }

    static public func type() -> Type {
        return getType(code: getVersionCode())
    }

    @available(*, deprecated, message: "use == operator instead")
    static public func isEqualToScreenSize(_ size: Size) -> Bool {
        return size == self.size() ? true : false;
    }

    @available(*, deprecated, message: "use > operator instead")
    static public func isLargerThanScreenSize(_ size: Size) -> Bool {
        return size.rawValue < self.size().rawValue ? true : false;
    }

    @available(*, deprecated, message: "use < operator instead")
    static public func isSmallerThanScreenSize(_ size: Size) -> Bool {
        return size.rawValue > self.size().rawValue ? true : false;
    }

    static public func isRetina() -> Bool {
        return UIScreen.main.scale > 1.0
    }

    static public func isPad() -> Bool {
        return type() == .iPad
    }

    static public func isPhone() -> Bool {
        return type() == .iPhone
    }

    static public func isPod() -> Bool {
        return type() == .iPod
    }

    static public func isSimulator() -> Bool {
        return type() == .simulator
    }

}

// MARK: - Dynamic island
extension DeviceInfo {
    static public var hasDynamicIsland: Bool {
        switch version() {
            case .iPhone14Pro,
                    .iPhone14Pro_Max,
                    .iPhone15,
                    .iPhone15Plus,
                    .iPhone15Pro,
                    .iPhone15Pro_Max,
                    .iPhone16,
                    .iPhone16Plus,
                    .iPhone16Pro,
                    .iPhone16Pro_Max:
                return true
            default:
                return false
        }
    }
}

#endif
extension DeviceInfo {
    //
    //  Version.swift
    //  Device
    //
    //  Created by Lucas Ortis on 30/10/2015.
    //  Copyright © 2015 Ekhoo. All rights reserved.
    //

    public enum Version: String {
        /*** iPhone ***/
        case iPhone2G
        case iPhone3G
        case iPhone3GS
        case iPhone4
        case iPhone4S
        case iPhone5
        case iPhone5C
        case iPhone5S
        case iPhone6
        case iPhone6Plus
        case iPhone6S
        case iPhone6SPlus
        case iPhoneSE
        case iPhone7
        case iPhone7Plus
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPhoneXS
        case iPhoneXS_Max
        case iPhoneXR
        case iPhone11
        case iPhone11Pro
        case iPhone11Pro_Max
        case iPhoneSE2
        case iPhone12Mini
        case iPhone12
        case iPhone12Pro
        case iPhone12Pro_Max
        case iPhone13Mini
        case iPhone13
        case iPhone13Pro
        case iPhone13Pro_Max
        case iPhoneSE3
        case iPhone14
        case iPhone14Plus
        case iPhone14Pro
        case iPhone14Pro_Max
        case iPhone15
        case iPhone15Plus
        case iPhone15Pro
        case iPhone15Pro_Max
        case iPhone16
        case iPhone16Plus
        case iPhone16Pro
        case iPhone16Pro_Max
        case iPhone16e
        case iPhone17
        case iPhone17Pro
        case iPhone17Pro_Max
        case iPhoneAir

        /*** iPad ***/
        case iPad1
        case iPad2
        case iPad3
        case iPad4
        case iPad5
        case iPad6
        case iPad7
        case iPad8
        case iPad9
        case iPad10
        case iPadAir
        case iPadAir2
        case iPadAir3
        case iPadAir4
        case iPadAir5
        case iPadMini
        case iPadMini2
        case iPadMini3
        case iPadMini4
        case iPadMini5
        case iPadMini6
        case iPadAirM2_11Inch
        case iPadAirM2_13Inch
        case iPadAirM3_11Inch
        case iPadAirM3_13Inch

        /*** iPadPro ***/
        case iPadPro9_7Inch
        case iPadPro12_9Inch
        case iPadPro10_5Inch
        case iPadPro12_9Inch2
        case iPadPro11_0Inch
        case iPadPro12_9Inch3
        case iPadPro11_0Inch2
        case iPadPro11_0Inch3
        case iPadPro11_0Inch4
        case iPadPro12_9Inch4
        case iPadPro12_9Inch5
        case iPadPro12_9Inch6
        case iPadProM4_11Inch
        case iPadProM4_13Inch

        /*** iPod ***/
        case iPodTouch1Gen
        case iPodTouch2Gen
        case iPodTouch3Gen
        case iPodTouch4Gen
        case iPodTouch5Gen
        case iPodTouch6Gen
        case iPodTouch7Gen

        /*** simulator ***/
        case simulator

        /*** unknown ***/
        case unknown
    }
}
//MARK: - Type
extension DeviceInfo {

    public enum `Type`: String {
#if os(iOS)
        case iPhone
        case iPad
        case iPod
        case simulator
#elseif os(OSX)
        case iMac
        case macMini
        case macPro
        case macBook
        case macBookAir
        case macBookPro
        case xserve
#endif
        case unknown
    }
}
//MARK: - Size
extension DeviceInfo {
    public enum Size: Int, Comparable {
        case unknownSize = 0
#if os(iOS)
        /// iPhone 2G, 3G, 3GS, 4, 4s, iPod Touch 4th gen.
        case screen3_5Inch
        /// iPhone 5, 5s, 5c, SE, iPod Touch 5-7th gen.
        case screen4Inch
        /// iPhone 6, 6s, 7, 8, SE 2nd gen.
        case screen4_7Inch
        /// iPhone 12 Mini
        case screen5_4Inch
        /// iPhone 6+, 6s+, 7+, 8+
        case screen5_5Inch
        /// iPhone X, Xs, 11 Pro
        case screen5_8Inch
        /// iPhone Xr, 11, 12, 12 Pro, 13, 13 Pro, 14
        case screen6_1Inch
        /// iPhone 14 Pro,  iPhone 15, iPhone 15 Pro, iPhone 16
        case screen6_1Inch_2
        /// iPhone 16 Pro
        case screen6_3Inch
        /// iPhone Xs Max, 11 Pro Max
        case screen6_5Inch
        /// iPhone 12 Pro Max, 13 Pro Max, 14 Plus, 15 Plus
        case screen6_7Inch
        /// iPhone 14 Pro Max, iPhone 15 Pro Max, iPhone 16 Plus
        case screen6_7Inch_2
        /// iPhone 16 Pro Max
        case screen6_9Inch
        /// iPad Mini
        case screen7_9Inch
        /// iPad, iPad Pro (9.7-inch)
        case screen9_7Inch
        /// iPad (10.2-inch)
        case screen10_2Inch
        /// iPad Pro (10.5-inch)
        case screen10_5Inch
        /// iPad Air 4th gen.
        case screen10_9Inch
        /// iPad Pro (11-inch)
        case screen11Inch
        /// iPad Pro (12.9-inch)
        case screen12_9Inch
        /// iPad Pro (13-inch)
        case screen13Inch
#elseif os(OSX)
        case screen11Inch
        case screen12Inch
        case screen13Inch
        case screen15Inch
        case screen16Inch
        case screen17Inch
        case screen20Inch
        case screen21_5Inch
        case screen24Inch
        case screen27Inch
#endif

        static public func <(lhs: Size, rhs: Size) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }

        static public func ==(lhs: Size, rhs: Size) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }


}
