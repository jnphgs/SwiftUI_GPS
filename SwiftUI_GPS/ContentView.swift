//
//  ContentView.swift
//  SwiftUI_GPS
//
//  Created by higashi on 2020/03/05.
//  Copyright © 2020 jnphgs. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var lm: LocationManager
    var latitude: String  { return("\(lm.location?.latitude ?? 0)") }
    var longitude: String { return("\(lm.location?.longitude ?? 0)") }
    var placemark: String { return("\(lm.placemark?.description ?? "XXX")") }
    var status: String    { return("\(lm.status.debugDescription)") }
    
    var body: some View {
        ZStack{
            MapView(coordinate: CLLocationCoordinate2D(latitude: 35, longitude: 135))
            VStack {
                Text("Latitude: \(self.latitude)")
                Text("Longitude: \(self.longitude)")
                Text("Placemark: \(self.placemark)")
                Text("Status: \(self.status)")
            }
            GeometryReader{ geometry in
                Button(action: {
                    self.lm.updateLocation()
                }) {
                    Image(systemName: "location.circle")
                        .imageScale(.large)
                        .padding()
                        .rotationEffect(Angle(degrees: 30.0))
                        .animation(.easeInOut)
                }.offset(x: 0.5*geometry.size.width-40, y: 0.5*geometry.size.height-70)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LocationManager())
    }
}
