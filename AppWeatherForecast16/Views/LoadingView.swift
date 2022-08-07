//
//  LoadingView.swift
//  AppWeatherForecast16
//
//  Created by Анна Тибекина on 08.08.2022.
//

import SwiftUI

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
