//
//  CustomPin.swift
//  EFREI_PROJECT_
//
//  Created by Nassim Guettat on 06/04/2021.
//

import UIKit
import MapKit

class CustomPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var id: String?
    var location: Location?
    init(pinLocation: Location, pinTitle: String, pinCoordinate: CLLocationCoordinate2D, pinSubtitle: String, pinId: String) {
        title = pinTitle
        coordinate = pinCoordinate
        subtitle = pinSubtitle
        id = pinId
        location = pinLocation
    }
}
