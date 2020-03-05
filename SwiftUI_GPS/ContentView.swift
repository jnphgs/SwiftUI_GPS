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
    
    var latitude_str: String  { return("\(lm.location?.latitude ?? 0)") }
    var longitude_str: String { return("\(lm.location?.longitude ?? 0)") }
    
    var currentAnnotation: MKPointAnnotation{
        let newLocation = MKPointAnnotation()
        newLocation.coordinate = CLLocationCoordinate2D(
            latitude: (lm.location?.latitude ?? 0), longitude: (lm.location?.longitude ?? 0)
        )
        return newLocation
    }
    
    var body: some View {
        VStack {
            ZStack{
                MapView(annotation: currentAnnotation)
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
            VStack {
                Text("Latitude: \(self.latitude_str)")
                Text("Longitude: \(self.longitude_str)")
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LocationManager())
    }
}
