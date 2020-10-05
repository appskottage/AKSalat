# AKSalat

AKSalat Swift is a well tested and well documented library for calculating Islamic prayer times. AKSalat Swift supports Swift 4.0, Swift 4.2, Swift 5.0

All astronomical calculations are high precision equations directly from the book “Astronomical Algorithms” by Jean Meeus. This book is recommended by the Astronomical Applications Department of the U.S. Naval Observatory and the Earth System Research Laboratory of the National Oceanic and Atmospheric Administration.

Implementations of found in the parent repo Adhan-Swift


## Usage

To get prayer times initialize the `PrayerTimes` struct passing in coordinates,
date, and calculation parameters.

```swift
let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params)
```

### Initialization parameters

#### Coordinates

Create a `Coordinates` struct with the latitude and longitude for the location
you want prayer times for.

```swift
let coordinates = Coordinates(latitude: 35.78056, longitude: -78.6389)
```

#### Date

To avoid confusion with timezones the date parameter passed in should be an instance of
`DateComponents`. The year, month, and day components need to be populated. All other
components will be ignored. The year, month and day values should be for the local date
that you want prayer times for. These date components are expected to be for the Gregorian calendar.

```swift
let cal = Calendar(identifier: Calendar.Identifier.gregorian)
let date = cal.dateComponents([.year, .month, .day], from: Date())
```

### Calculation parameters & Calculation Methods

The rest of the needed information is contained within the `CalculationParameters` struct.

[Calculation Parameters & Methods Guide](METHODS.md)



### Prayer Times

Once the `PrayerTimes` struct has been initialized it will contain members
for all five prayer times and the time for sunrise. The prayer times will be instances
of NSDate and as such will refer to a fixed point in universal time. To display these
times for the local timezone you will need to create a date formatter and set
the appropriate timezone.

```swift
let formatter = DateFormatter()
formatter.timeStyle = .medium
formatter.timeZone = TimeZone(identifier: "America/New_York")!

print("fajr \(formatter.string(from: prayers.fajr))")
```

## Full Example

```swift
let cal = Calendar(identifier: Calendar.Identifier.gregorian)
let date = cal.dateComponents([.year, .month, .day], from: Date())
let coordinates = Coordinates(latitude: 35.78056, longitude: -78.6389)
var params = CalculationMethod.moonsightingCommittee.params
params.madhab = .hanafi
if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.timeZone = TimeZone(identifier: "America/New_York")!

    print("fajr \(formatter.string(from: prayers.fajr))")
    print("sunrise \(formatter.string(from: prayers.sunrise))")
    print("dhuhr \(formatter.string(from: prayers.dhuhr))")
    print("asr \(formatter.string(from: prayers.asr))")
    print("maghrib \(formatter.string(from: prayers.maghrib))")
    print("isha \(formatter.string(from: prayers.isha))")
}
```

## Convenience Utilities

The `PrayerTimes` struct has functions for getting the current prayer and the next prayer. You can also get the time for a specified prayer, making it
easier to dynamically show countdowns until the next prayer.

```swift
let prayerTimes = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params)

let current = prayerTimes.currentPrayer()
let next = prayerTimes.nextPrayer()
let countdown = prayerTimes.time(for: next)
```

## Sunnah Times

The AKSalat library can also calulate Sunnah times. Given an instance of `PrayerTimes`, you can get a `SunnahTimes` struct with the times for Qiyam.

```swift
if let sunnahTimes = SunnahTimes(from: todayPrayers) {
	print(dateFormatter.string(from: sunnahTimes.lastThirdOfTheNight)
	print(dateFormatter.string(from: sunnahTimes.middleOfTheNight)
}
```

## Qibla Direction

Get the direction, in degrees from North, of the Qibla from a given set of coordinates.

```swift
let nyc = Coordinates(latitude: 40.7128, longitude: -74.0059)
let qiblaDirection = Qibla(coordinates: nyc).direction
```


