//
//  LocationMapViewController.swift
//  EFREI_PROJECT_
//
//  Created by Nassim Guettat on 06/04/2021.
//

import UIKit
import MapKit
import CoreLocation


class LocationMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    @IBOutlet weak var blurryView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var adressLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedItem: CustomPin?
    
    var chosenLocation: Location?
    var locations: [Location]?
    let locationManager = CLLocationManager()
    var mapAlreadyCentered = false
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var showdetailsButton: UIButton!
    
    
    var chosenActivity: Schedule?
    var activities = [Schedule](){
        didSet{
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow //On suit l'utilisateur
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = mapView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurryView.addSubview(blurEffectView)
        
        
        showdetailsButton.layer.cornerRadius = 12
        showdetailsButton.layer.borderWidth = 1
        showdetailsButton.layer.borderColor = UIColor.init(named: "Slate")?.cgColor
        showdetailsButton.isHidden = true
        blurryView.isHidden = true
    
        blurryView.bringSubviewToFront(cardView)
        blurryView.bringSubviewToFront(dismissButton)
        
        cardView.layer.cornerRadius = 15
        cardView.layer.borderColor = UIColor.white.cgColor
        cardView.layer.borderWidth = 2
        
        //blurryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissBlurryView)))
    }
    
    
    @objc private func dismissBlurryView(){
        
        UIView.transition(with: showdetailsButton, duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.blurryView.isHidden = true
                            self.showdetailsButton.isHidden = false
                      })
        
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        
        self.dismissBlurryView()
        
    }
    
    @IBAction func showDetailsTapped(_ sender: Any) {
        
        UIView.transition(with: showdetailsButton, duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.blurryView.isHidden = false
                            self.showdetailsButton.isHidden = true
                      })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        statutLocalisation()
    }
    
    
    private func statutLocalisation(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
        else{
            locationManager.requestWhenInUseAuthorization() //permet de demander l'authorisation si l'on ne l'a pas
        }
    }
    
    func centrerMap(location: CLLocation){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
        mapView.setRegion(region, animated: true)
    }
    

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        if status == CLAuthorizationStatus.authorizedWhenInUse{
            mapView.showsUserLocation = true
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if let loc = userLocation.location {
            
            if !mapAlreadyCentered {
                centrerMap(location: loc)
                mapAlreadyCentered = true
            }
            
            Airtable.fetchLocation(from: Airtable.locationLink + Airtable.key){ data in
                self.locations = data
                
                if let values = self.locations{
                    
                    for location in values{
                        
                   
                        let geocoder = CLGeocoder()
                        geocoder.geocodeAddressString(location.fields.adress ?? "4 rue de Rome") {
                            placemarks, error in
                            let placemark = placemarks?.first
                            let lat = placemark?.location?.coordinate.latitude ?? 12
                            let lon = placemark?.location?.coordinate.longitude ?? 22
                            let pin = CustomPin(pinLocation: location, pinTitle: location.fields.name ?? "Grand ballroom", pinCoordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), pinSubtitle: location.fields.adress ?? "4 rue de Rome", pinId: location.id)
                            self.mapView.addAnnotation(pin)
                            
                        }
                        

                        
                    }
                    
                }
            }
        }
        
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if view.annotation is MKUserLocation{
            return
        }
        selectedItem = view.annotation as? CustomPin
        chosenLocation = selectedItem?.location
        
        self.nameLbl.text = selectedItem?.location?.fields.name
        self.adressLbl.text = selectedItem?.location?.fields.adress
        self.descriptionLbl.text = selectedItem?.location?.fields.description
        initializeEvents()
        
        showdetailsButton.isHidden = false
        
    }
    
    /*
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is MKUserLocation){
            return nil
        }
        
        

        
        let customAnnotation = LocationAnnotationView.init(annotation: annotation, reuseIdentifier: "myAnnotation")
        
        customAnnotation.canShowCallout = true
        return customAnnotation
    }
 */
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LocationMapViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func initializeEvents(){
        eventsTableView.backgroundColor = UIColor.init(named: "Slate")
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        if let valueExist = chosenLocation{
            
            var events = [Schedule]() {didSet{
                DispatchQueue.main.async {
                    self.activities = events
                }
            
            }
            }
            
            if let locationEvents = valueExist.fields.scheduledEvents{
                for s in locationEvents{
                    
                    Airtable.getActivity(from: Airtable.scheduleLink + "/" + s + Airtable.key){ data in
                        
                        events.append(data)
                        
                    }
                    
                }
                
            }
            

        }
        else{
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationActivityCell", for: indexPath) as! LocationActivityCell
        
        cell.dateView.layer.cornerRadius = 10
        cell.dateLbl.layer.cornerRadius = 10
        cell.dateLbl.layer.masksToBounds = true
        cell.dateLbl.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cell.nameLbl.text = self.activities[indexPath.section].fields.activity
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: activities[indexPath.section].fields.start ?? "2017-01-09T11:00:00.000Z")!
        let calanderDate = Calendar.current.dateComponents([.minute,.hour,.day, .year, .month], from: date)
        let dateEnd = dateFormatter.date(from: activities[indexPath.section].fields.end ?? "2017-01-09T11:00:00.000Z")!
        let calanderDateEnd = Calendar.current.dateComponents([.minute,.hour,.day, .year, .month], from: dateEnd)
        cell.dateLbl.text = calanderDate.day!.description + "/" + calanderDate.month!.description + "/" + calanderDate.year!.description
        
        
        
       
        
        cell.startLbl.text = calanderDate.hour!.description + "h" + calanderDate.minute!.description
        
        if(calanderDate.minute == 0){
            cell.startLbl.text! += "0"
        }
        if(calanderDateEnd.minute == 0){
            cell.endLbl.text! += "0"
        }
        
        cell.endLbl.text = calanderDateEnd.hour!.description + "h" + calanderDateEnd.hour!.description
        
        cell.layer.cornerRadius = 30
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.init(named: "lipstick")?.cgColor
        //cell.backgroundColor = UIColor.white
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
        headerView.backgroundColor = UIColor.init(named: "Slate")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenActivity = activities[indexPath.section]
        
        performSegue(withIdentifier: "goDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let vc = segue.destination as? DetailViewController
        vc?.schedule = chosenActivity
        // Pass the selected object to the new view controller.
    }

    
    
}
