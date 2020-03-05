//
//  MapView.swift
//  SwiftUI_GPS
//
//  Created by higashi on 2020/03/05.
//  Copyright © 2020 jnphgs. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate = CLLocationCoordinate2D(
    latitude: 34.011_286, longitude: -116.166_868)
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 35, longitude: 135))
    }
}
