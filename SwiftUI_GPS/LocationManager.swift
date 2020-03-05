// https://adrianhall.github.io/swift/2019/11/05/swiftui-location/

import Foundation
import Combine
import MapKit

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var locationCache: CLLocation?
    
    @Published var location: CLLocation?
    @Published var status: CLAuthorizationStatus?
    @Published var placemark: CLPlacemark?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func updateLocation(){
        guard let location = locationCache else { return }
        self.location = location
        self.geocode()
    }
    
    private func geocode(){
        guard let location = self.location else {return}
        geocoder.reverseGeocodeLocation(location, completionHandler: {(places, error) in
            if error == nil{
                self.placemark = places?[0]
            }else{
                self.placemark = nil
            }
        })
    }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.locationCache = location
    }
}

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}
