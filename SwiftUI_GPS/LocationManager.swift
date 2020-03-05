// https://adrianhall.github.io/swift/2019/11/05/swiftui-location/

import Foundation
import Combine
import MapKit

// NSObjectはインスタンス作成時にinitを呼び出すのでinit内にlocationManagerの初期化を書きます。
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


// Authorizationの変化、GPSの値の変化時に呼び出される関数をextensionとして定義します
extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // @publishedのself.locationを変更するとそれを利用しているViewも更新されるため地図が現在地から動かなくなります。
        // GPSの値が更新されるたびにself.locationCacheの値を更新してキャッシュしておきます。
        // ユーザーが任意のタイミングでGPSの現在値を取得した際にself.locationにlocationCacheをコピーすることでViewを更新します
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
