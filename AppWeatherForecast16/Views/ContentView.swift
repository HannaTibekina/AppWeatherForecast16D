//
//  ContentView.swift
//  AppWeatherForecast16
//
//  Created by Анна Тибекина on 08.08.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var forecastManager = ForecastManager()
    @State var weatherForecast: Forecast?
    
    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        VStack {
           
            if let location = locationManager.location {
                if let weatherForecast = weatherForecast {
                    WeatherView(forecast: weatherForecast)
                } else {
                    LoadingView()
                        .task {
                            do {
                              weatherForecast = try await forecastManager.getForecast(latitude: location.latitude, longtitude: location.longitude)
                            } catch {
                                print("Error getting weather!: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                WelcomeView()
                    .environmentObject(locationManager)
                }
            
            }
           
        }
//        .background(Color("AccentColor"))
//        .preferredColorScheme(.dark)
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
