//
//  CalculationMethod.swift
//  Adhan
//
//  Copyright © 2018 Batoul Apps. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public enum CalculationMethod: String, Codable, CaseIterable {
    
    // Algerian Minister of Religious Afairs and Wakfs
    case algerian = "Algerian Minister of Religious Afairs and Wakfs"
    
    // Diyanet Isleri Baskanligi
    // An approximation of the Diyanet method used in Turkey. This approximation is less accurate outside the region of Turkey.
    case turkey = "Diyanet Isleri Baskanligi"
    
    // Egyptian General Authority
    // Early Fajr time using an angle 19.5° and a slightly earlier Isha time using an angle of 17.5°.
    case egyptian = "Egyptian General Authority"
    
    // Egyptian General Authority (Bis)
    case egyptianBis = "Egyptian General Authority (Bis)"
    
    // Fixed Isha Angle Interval
    case fixedIshaAngle = "Fixed Isha Angle Interval"
    
    // France Angle 15
    case FranceAngle15 = "France Angle 15"
    
    // France Angle 18
    case FranceAngle18 = "France Angle 18"
    
    // Islamic University, Karachi
    // A generally applicable method that uses standard Fajr and Isha angles of 18°.
    case karachi = "Islamic University, Karachi"
    
    // JAKIM (Jabatan Kemajuan Islam Malaysia)
    case jakimMalaysia = "JAKIM (Jabatan Kemajuan Islam Malaysia)"
    
    // London Unified Islamic Prayer Timetable
    case london = "London Unified Islamic Prayer Timetable"
    
    // MUIS (Majlis Ugama Islam Singapura)
    // Used in Singapore, Malaysia, and Indonesia. Early Fajr time with an angle of 20° and standard Isha time with an angle of 18°.
    case muisSingapore = "MUIS (Majlis Ugama Islam Singapura)"
    
    // Muslim World League
    // Standard Fajr time with an angle of 18°. Earlier Isha time with an angle of 17°.
    case muslimWorldLeague = "Muslim World League"
    
    // Musulmans de France (ex-UOIF) - Angle 12
    case franceAngle12 = "Musulmans de France (ex-UOIF) - Angle 12"
    
    // North America (ISNA)
    // Also known as the ISNA method. Can be used for North America, but the moonsightingCommittee method is preferable. Gives later Fajr times and early
    // Isha times with angles of 15°.
    case northAmerica = "North America (ISNA)"
    
    // SIHAT/KEMENAG (Kementerian Agama RI)
    case sihatKemenag = "SIHAT/KEMENAG (Kementerian Agama RI)"
    
    // Shia Ithna Ashari (Jafari)
    case shia = "Shia Ithna Ashari (Jafari)"
    
    // Tunisian Ministry of Religious Affairs
    case tunisia = "Tunisian Ministry of Religious Affairs"
    
    // UAE General Authority of Islamic Affairs And Endowments
    // Used in the UAE. Slightly earlier Fajr time and slightly later Isha time with angles of 18.2° for Fajr and Isha in addition to 3 minute
    // offsets for sunrise, Dhuhr, Asr, and Maghrib.
    case uae = "UAE General Authority of Islamic Affairs And Endowments"
    
    // Umm al-Qura, Makkah
    // Uses a fixed interval of 90 minutes from maghrib to calculate Isha. And a slightly earlier Fajr time
    // with an angle of 18.5°. Note: you should add a +30 minute custom adjustment for Isha during Ramadan.
    case ummAlQura = "Umm al-Qura, Makkah"

    // Moonsighting Committee
    // Method developed by Khalid Shaukat, founder of Moonsighting Committee Worldwide. Uses standard 18° angles for Fajr and Isha in addition
    // to seasonal adjustment values. This method automatically applies the 1/7 approximation rule for locations above 55° latitude.
    // Recommended for North America and the UK.
    case moonsightingCommittee = "Moonsighting Committee"

    // Kuwait
    // Standard Fajr time with an angle of 18°. Slightly earlier Isha time with an angle of 17.5°.
    case kuwait = "Kuwait"

    // Qatar
    // Same Isha interval as `ummAlQura` but with the standard Fajr time using an angle of 18°.
    case qatar = "Qatar"
    
    // University of Tehran
    // Institute of Geophysics, University of Tehran. Early Isha time with an angle of 14°. Slightly later Fajr time with an angle of 17.7°.
    // Calculates Maghrib based on the sun reaching an angle of 4.5° below the horizon.
    case tehran = "University of Tehran"

//    // Other
//    // Defaults to angles of 0°, should generally be used for making a custom method and setting your own values.
//    case other

    public var params: CalculationParameters {
        switch(self) {
        case .algerian :
            return CalculationParameters(fajrAngle: 16, ishaAngle: 14, method: self)
        case .turkey:
            var params = CalculationParameters(fajrAngle: 18, ishaAngle: 17, method: self)
            params.methodAdjustments = PrayerAdjustments(fajr: 0, sunrise: -7, dhuhr: 5, asr: 4, maghrib: 7, isha: 0)
            return params
        case .egyptian:
            var params = CalculationParameters(fajrAngle: 19.5, ishaAngle: 17.5, method: self)
            params.methodAdjustments = PrayerAdjustments(dhuhr: 1)
            return params
        case .egyptianBis:
            var params = CalculationParameters(fajrAngle: 20, ishaAngle: 18, method: self)
            params.methodAdjustments = PrayerAdjustments(dhuhr: 1)
            return params
        case .fixedIshaAngle:
            return CalculationParameters(fajrAngle: 19.5, ishaInterval: 90, method: self)
        case .FranceAngle15:
            return CalculationParameters(fajrAngle: 15, ishaAngle: 15, method: self)
        case .FranceAngle18:
            return CalculationParameters(fajrAngle: 18, ishaAngle: 18, method: self)
        case .karachi:
            var params = CalculationParameters(fajrAngle: 18, ishaAngle: 18, method: self)
            params.methodAdjustments = PrayerAdjustments(dhuhr: 1)
            return params
        case .jakimMalaysia:
            return CalculationParameters(fajrAngle: 20, ishaAngle: 18, method: self)
        case .london:
            var params = CalculationParameters(fajrAngle: 18, ishaAngle: 18, method: self)
            params.methodAdjustments = PrayerAdjustments(sunrise: -3)
            return params
        case .muisSingapore:
            var params = CalculationParameters(fajrAngle: 20, ishaAngle: 18, method: self)
            params.methodAdjustments = PrayerAdjustments(dhuhr: 1)
            return params
        case .muslimWorldLeague:
            var params = CalculationParameters(fajrAngle: 18, ishaAngle: 17, method: self)
            params.methodAdjustments = PrayerAdjustments(dhuhr: 1)
            return params
        case .franceAngle12:
            return CalculationParameters(fajrAngle: 12, ishaAngle: 12, method: self)
        case .northAmerica:
            var params = CalculationParameters(fajrAngle: 15, ishaAngle: 15, method: self)
            params.methodAdjustments = PrayerAdjustments(dhuhr: 1)
            return params
        case .sihatKemenag:
            return CalculationParameters(fajrAngle: 20, ishaAngle: 18, method: self)
        case .shia:
            return CalculationParameters(fajrAngle: 16, ishaAngle: 14, method: self)
        case .tunisia:
            return CalculationParameters(fajrAngle: 18, ishaAngle: 18, method: self)
        case .uae:
            var params = CalculationParameters(fajrAngle: 19.5, ishaInterval: 90, method: self)
            params.methodAdjustments = PrayerAdjustments(sunrise: -3, dhuhr: 3, asr: 3, maghrib: 3)
            return params
        case .ummAlQura:
            return CalculationParameters(fajrAngle: 18.5, ishaInterval: 90, method: self)
        case .moonsightingCommittee:
            var params = CalculationParameters(fajrAngle: 18, ishaAngle: 18, method: self)
            params.methodAdjustments = PrayerAdjustments(dhuhr: 5, maghrib: 3)
            return params
        case .kuwait:
            return CalculationParameters(fajrAngle: 18, ishaAngle: 17.5, method: self)
        case .qatar:
            return CalculationParameters(fajrAngle: 18, ishaInterval: 90, method: self)
        case .tehran:
            return CalculationParameters(fajrAngle: 17.7, maghribAngle: 4.5, ishaAngle: 14, method: self)
//        case .other:
//            return CalculationParameters(fajrAngle: 0, ishaAngle: 0, method: self)
        }
    }
}
