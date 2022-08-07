//
//  ForecastManager.swift
//  AppWeatherForecast16
//
//  Created by Анна Тибекина on 08.08.2022.
//

import Foundation
import CoreLocation

class ForecastManager {
    func getForecast(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) async throws -> Forecast {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(latitude)&lon=\(longtitude)&cnt=16&appid=\("cad672bae6d9451d9fcd93f78adb14cb")&units=metric") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error feathing weather data") }
        
        let decodedData = try JSONDecoder().decode(Forecast.self, from: data)

        return decodedData
    }
}

struct Forecast: Decodable {
    let data: [Datum]
    let cityName, lon, timezone, lat: String
    let countryCode, stateCode: String

    enum CodingKeys: String, CodingKey {
        case data
        case cityName = "city_name"
        case lon, timezone, lat
        case countryCode = "country_code"
        case stateCode = "state_code"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let moonriseTs: Int
    let windCdir: String
    let rh: Int
    let pres, highTemp: Double
    let sunsetTs: Int
    let ozone, moonPhase, windGustSpd: Double
    let snowDepth, clouds, ts, sunriseTs: Int
    let appMinTemp, windSpd: Double
    let pop: Int
    let windCdirFull: String
    let slp, moonPhaseLunation: Double
    let validDate: String
    let appMaxTemp, vis, dewpt: Double
    let snow: Int
    let uv: Double
    let weather: Weathers
    let windDir: Int
    let maxDhi: JSONNull?
    let cloudsHi: Int
    let precip, lowTemp, maxTemp: Double
    let moonsetTs: Int
    let datetime: String
    let temp, minTemp: Double
    let cloudsMid, cloudsLow: Int

    enum CodingKeys: String, CodingKey {
        case moonriseTs = "moonrise_ts"
        case windCdir = "wind_cdir"
        case rh, pres
        case highTemp = "high_temp"
        case sunsetTs = "sunset_ts"
        case ozone
        case moonPhase = "moon_phase"
        case windGustSpd = "wind_gust_spd"
        case snowDepth = "snow_depth"
        case clouds, ts
        case sunriseTs = "sunrise_ts"
        case appMinTemp = "app_min_temp"
        case windSpd = "wind_spd"
        case pop
        case windCdirFull = "wind_cdir_full"
        case slp
        case moonPhaseLunation = "moon_phase_lunation"
        case validDate = "valid_date"
        case appMaxTemp = "app_max_temp"
        case vis, dewpt, snow, uv, weather
        case windDir = "wind_dir"
        case maxDhi = "max_dhi"
        case cloudsHi = "clouds_hi"
        case precip
        case lowTemp = "low_temp"
        case maxTemp = "max_temp"
        case moonsetTs = "moonset_ts"
        case datetime, temp
        case minTemp = "min_temp"
        case cloudsMid = "clouds_mid"
        case cloudsLow = "clouds_low"
    }
}

// MARK: - Weather
struct Weathers: Codable {
    let icon: String
    let code: Int
    let weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case icon, code
        case weatherDescription = "description"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

