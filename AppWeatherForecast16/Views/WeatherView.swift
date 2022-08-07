//
//  WeatherView.swift
//  AppWeatherForecast16
//
//  Created by Анна Тибекина on 08.08.2022.
//

import SwiftUI



struct WeatherView: View {
    var forecast: Forecast
    
    
    
    var body: some View {
        ZStack{
            Image("back")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                
            VStack {
            
                Text(forecast.cityName)
                    .font(.largeTitle)
                    .padding()
                    
                VStack {
                    Text(Date().formatted(.dateTime.month().day().hour().minute()))
                        .fontWeight(.semibold)
                    Text(forecast.data[0].temp.roundDouble() + "°")
                        .font(.system(size: 95, weight: .thin))
                    Text(forecast.data[0].weather.weatherDescription)
                        .font(.title3.weight(.semibold))
                }
                Spacer()
                
                
                ForecastCard(forecast: previewForecastWeather)
                    .padding(.bottom)
                    .padding(3)
            }
            .foregroundColor(.white)
            .padding(.top, 51)
            
            
           
            
        }
    
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(forecast: previewForecastWeather)
            .preferredColorScheme(.dark)
    }
}
