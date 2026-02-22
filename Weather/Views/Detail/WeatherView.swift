//
//  WeatherView.swift
//  Weather
//
//  Created by Zeynep Kılıç on 21.02.2026.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    
    var searchResults: [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        } else {
            return Forecast.cities.filter {
                $0.location.contains(searchText)
            }
        }
    }
    var body: some View {
        ZStack {
            // Mark: Background
            Color.background
                .ignoresSafeArea()
            
            //Mark: Weather Widgets
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchResults) {
                        forecast in WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
           NavigationBar(searchText: $searchText)
        }
        .navigationBarHidden(true)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a city or airport")
    }
}

#Preview {
    NavigationView {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}
