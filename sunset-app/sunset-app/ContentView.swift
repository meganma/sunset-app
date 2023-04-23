//
//  ContentView.swift
//  sunset-app
//
//  Created by Megan Ma and Adrian Lam on 4/22/23.
//

import SwiftUI

struct ContentView: View {
    //color variables
    let textColor = Color.white
    //state variables for hours and minutes
        @State private var hours = 1
        @State private var minutes = 20
    var body: some View {
        ZStack {
            backgroundColor()
                .edgesIgnoringSafeArea(.all)
            
            // Glassmorphism location bubble
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.white.opacity(0.2))
                .frame(width: 350, height: 40)
            
                .overlay(
                    (
                        Text("Your current location is: ")
                            .foregroundColor(.white)
                        + Text("San Francisco").underline(true, color: .white)
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
                //Main text+time
                Text("Sundown is at:")
                    .font(.system(size: 40, weight: .regular, design: .rounded))
                    .foregroundColor(textColor)
                    .padding(.top, 20)
                
                Text("6:59")
                    .font(.system(size: 150, weight: .thin, design: .rounded))
                    .foregroundColor(textColor)
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
