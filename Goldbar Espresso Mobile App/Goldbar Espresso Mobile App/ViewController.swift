//
//  ViewController.swift
//  Goldbar Espresso Mobile App
//
//  Created by Jessica Miller on 10/13/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var searchItem: UITextField!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var mapType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMap(_ sender: Any) {
     
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
        
        case 1:
           map.mapType = MKMapType.satellite
        
        case 2:
           map.mapType = MKMapType.hybrid
            
        default:
            map.mapType = MKMapType.standard
        }
        
        // display the map
        let lon : CLLocationDegrees = -111.90807
        
        let lat : CLLocationDegrees = 33.39472
        
        let coordinates = CLLocationCoordinate2D( latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
        
        self.map.setRegion(region, animated: true)
        
        // add an annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "Gold Bar Espresso"
        
        self.map.addAnnotation(annotation)
        
    }
    
    
    @IBAction func search(_ sender: UIButton) {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = self.searchItem.text//"pizza"
            request.region = map.region
            let search = MKLocalSearch(request: request)
            
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
        
        case 1:
           map.mapType = MKMapType.satellite
        
        case 2:
           map.mapType = MKMapType.hybrid
            
        default:
            map.mapType = MKMapType.standard
        }
        
            search.start { response, _ in
                guard let response = response else {
                    return
                }
                print( response.mapItems )
                var matchingItems:[MKMapItem] = []
                matchingItems = response.mapItems
                for i in 1...matchingItems.count - 1
                {
                        let place = matchingItems[i].placemark
                         print(place.location?.coordinate.latitude)
                         print(place.location?.coordinate.longitude)
                         print(place.name)
                    
                }
               
            }
          
        }
    

    
    

}

