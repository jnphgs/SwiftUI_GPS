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
    var body: some View {
        ZStack{
            MapView(coordinate: CLLocationCoordinate2D(latitude: 35, longitude: 135))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
