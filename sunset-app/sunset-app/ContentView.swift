//
//  ContentView.swift
//  sunset-app
//
//  Created by Megan Ma and Adrian Lam on 4/22/23.
//

import CoreLocation
import SwiftUI
import UIKit
import SwiftUI

struct ContentView: View {
    //color variables
    let textColor = Color.white
    //state variables for hours and minutes
    @State private var hours = 1
    @State private var minutes = 20
    @State private var location: String = "California"
    @State private var sunsetTime: String = ""
    @State private var sunsetDate: Date = Date()
    @State private var sunriseTime: String = ""
    @State private var sunriseDate: Date = Date()
    
    var body: some View {
        
        /*
        NavigationView {
                    VStack {
                        HStack {
                            TextField("Enter Location", text: $location)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button {
                                getWeatherData(for: location)
                            } label: {
                                Image(systemName: "magnifyingglass.circle.fill")
                                    .font(.title3)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .navigationTitle("Mobile Weather")
                }
        */
        
        // UI design for main app page
        ZStack {
            
            backgroundColor()
                .edgesIgnoringSafeArea(.all)
                .onAppear{getWeatherData(for: "\(location)")}
            
            Button {
                getWeatherData(for: "\(location)")
            } label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.title3)
            }
            
            // Glassmorphism location bubble
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.black.opacity(0.1))
                .frame(width: 350, height: 40)
            
                .overlay(
                    (
                        Text("Your current location is: ")
                            .foregroundColor(.white)
                        + Text("\(location)").underline(true, color: .white)
                            .foregroundColor(.white)
                    )
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1)
                )
                .offset(x: 0, y: -350)
            
            
            VStack{
                if sunsetDate > Date() {
                    //Main text+time
                    Text("Sunset is at:")
                        .font(.system(size: 40, weight: .regular, design: .rounded))
                        .foregroundColor(textColor)
                        .padding(.top, 20)
                    
                    Text("\(sunsetTime)")
                        .font(.system(size: 80, weight: .thin, design: .rounded))
                        .foregroundColor(textColor)
                }
                else
                {
                        //Main text+time
                        Text("Sunrise is at:")
                            .font(.system(size: 40, weight: .regular, design: .rounded))
                            .foregroundColor(textColor)
                            .padding(.top, 20)
                        
                        Text("\(sunriseTime)")
                            .font(.system(size: 80, weight: .thin, design: .rounded))
                            .foregroundColor(textColor)
                }
            }
            .frame(width: 350)
            .background(Color.white.opacity(0.1))
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style:.continuous))
            .offset(x:0,y:-100)
            
            
            
            VStack{
                //timer text
                
                Text("Set an alarm for")
                    .font(.system(size: 25, weight: .thin, design: .rounded))
                    .offset(x: 0, y: 80)
                    .foregroundColor(textColor)
                
                HStack(spacing: 10) {
                    //scroll bar for hours
                    Picker("", selection: $hours) {
                        ForEach(0..<24) { hour in
                            Text("\(hour)")
                                .foregroundColor(textColor)
                                .font(.system(size: 25, weight: .regular, design: .rounded))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 80,height:90)
                    .clipped()
                    
                    Text("hour")
                    
                    //scroll bar for minutes
                    Picker("", selection: $minutes) {
                        ForEach(0..<60) { minute in
                            Text("\(minute)")
                                .foregroundColor(textColor)
                                .font(.system(size: 25, weight: .regular, design: .rounded))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 80,height:90)
                    .clipped()
                    
                    Text("minutes")
                }
                .font(.system(size: 35, weight: .thin, design: .rounded))
                .foregroundColor(textColor)
                .padding(.bottom,60)
                .padding(.top,60)
                //.offset(x: 0, y: 140)
                
                Text("before sundown")
                    .font(.system(size: 25, weight: .thin, design: .rounded))
                    .offset(x: 0, y: -80)
                    .foregroundColor(textColor)
            }
            .offset(x: 0, y: 200)
            
            //end timer text
        }
    }
    // OpenWeatherMap API fetch function
    func getWeatherData(for location: String) {
        let apiService = APIService.shared
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                // Don't forget to use your own key
                apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&APPID=b45503aae99f19e3e2b05e58f80b24cf") { (result: Result<WeatherData,APIService.APIError>) in
                    switch result {
                    case .success(let weatherData):
                        // Output datapoints into debug terminal
                        print("   Coord: ", weatherData.coord)
                        print("   Description: ", weatherData.weather[0].description)
                        print("   Country: ", weatherData.sys.country)
                        print("   sunrise: ", weatherData.sys.sunrise)
                        
                        print("   sunset: ", dateFormatter.string(from: weatherData.sys.sunset))
                        DispatchQueue.main.async {
                            // Update the sunset time state variable with the retrieved value
                            self.sunsetTime = "\(dateFormatter.string(from: weatherData.sys.sunset))"
                            self.sunriseTime = "\(dateFormatter.string(from: weatherData.sys.sunrise))"
                            self.sunsetDate = weatherData.sys.sunset
                            self.sunriseDate = weatherData.sys.sunrise

                        }
                    case .failure(let apiError):
                        // Api fetch request error message
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                            print("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&APPID=b45503aae99f19e3e2b05e58f80b24cf")
                        }
                    }
                }
            }
        }
        
    }
    
    /*
    func backgroundColor() -> Color {
        // Calculate the percentage of time between sunset and current time
        let currentDate = Date()
        let sunsetInterval = sunsetDate.timeIntervalSince1970 - currentDate.timeIntervalSince1970
        let currentInterval = currentDate.timeIntervalSince1970 - sunsetDate.timeIntervalSince1970
        let percentage = currentInterval / sunsetInterval
        
        // Calculate the color of the sky based on the percentage of time
        let startColor = UIColor(red: 250/255, green: 220/255, blue: 130/255, alpha: 1)
        let endColor = UIColor(red: 28/255, green: 169/255, blue: 136/255, alpha: 1)
        
        let skyColor = UIColor.interpolate(from: startColor, to: endColor, with: percentage)
        let skyColorSwiftUI = Color(skyColor)
        return skyColorSwiftUI
    }
*/
        

     // Define a computed property to calculate the background color for the current time of day
     func backgroundColor() -> Color {
     let date = Date()
     let calendar = Calendar.current
     let hour = calendar.component(.hour, from: date)
     
     if hour >= 6 && hour < 18 {
     //day color: orange
     return Color(red: 0x1C/255, green: 0x23/255, blue: 0x3E/255)
     } else if hour >= 18 && hour < 21 {
     //sunset color
     return Color(red: 0xFb/255, green: 0xa9/255, blue: 0x88/255)
     } else {
     //night color: dark blue
     return Color(red: 0x1C/255, green: 0x23/255, blue: 0x3E/255)
     }
 }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
