//
//  DetailViewController.swift
//  CodingChallenge
//
//  Created by jason debottis on 5/9/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

@objc class DetailViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    let MapSize:CGFloat = 250
    
    var providerMapView = MKMapView()
    let locationManager = CLLocationManager()
    var stackedView = UIStackView()
    
    var companyName = UILabel()
    var reviewsLabel = UILabel()
    var gradeLabel = UILabel()
    var locationLabel = UILabel()
    var providerLocation = CLLocationCoordinate2D()
    var providerInformationView = UIView()
    var viewsDict = [String : AnyObject]()
    var serviceProvider = ServiceProvider()
    
    @objc func GetProvider(provider: ServiceProvider)->Void{
        self.serviceProvider = provider
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.setUpVIews()
        
    }
    
    func setUpVIews() -> Void {
        self.providerMapView = MKMapView()
        self.providerMapView.layer.cornerRadius = 10.0
        self.providerMapView.delegate = self
        let lat = (self.serviceProvider.latitude as NSString).doubleValue
        let long = (self.serviceProvider.longitude as NSString).doubleValue
        self.providerLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let spanX = 0.00725;
        let spanY = 0.00725;
        var region = MKCoordinateRegion()
        region.center.latitude = lat
        region.center.longitude = long
        region.span.latitudeDelta = spanX
        region.span.longitudeDelta = spanY
        let pin = MKPointAnnotation()
        pin.coordinate = self.providerLocation
        self.providerMapView.addAnnotation(pin)
        
        self.providerMapView.setRegion(region, animated: true)
        self.view.addSubview(self.providerMapView)
        self.view.addSubview(self.providerInformationView)
        self.providerInformationView.addSubview(self.companyName)
        self.providerInformationView.addSubview(self.locationLabel)
        self.providerInformationView.addSubview(self.reviewsLabel)
        self.providerInformationView.addSubview(self.gradeLabel)
        self.viewsDict = ["company":self.companyName,
                          "reviews":self.reviewsLabel,
                          "grade":self.gradeLabel,
                          "location":self.locationLabel];
        self.companyName.font = UIFont(name: "ChalkboardSE-Bold", size: 15)
        self.companyName.text = self.serviceProvider.name
        
        self.locationLabel.text = String(format: "%@, %@ %@",
                                         self.serviceProvider.city,
                                         self.serviceProvider.state,
                                         self.serviceProvider.postalCode)
        self.locationLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 14)
        self.reviewsLabel.text = String(format: "Reviews: %i",self.serviceProvider.reviewCount )
        self.reviewsLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 12)

        self.gradeLabel.text = String(format: "Grade: %@", self.serviceProvider.overallRating)
        self.gradeLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 12)
        self.gradeLabel.textAlignment = .Right
        self.updateViews()
        self.SetUpConstraints()
    }
    
    func updateViews() -> Void {
        self.view.removeConstraints(self.view.constraints)
        switch UIApplication.sharedApplication().statusBarOrientation {
        case .LandscapeLeft:
            self.providerMapView.frame = CGRectMake(0, 20,CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame))
            self.providerInformationView.frame = CGRectMake(CGRectGetWidth(self.providerMapView.frame),
                                                            40,
                                                            CGRectGetWidth(self.providerMapView.frame),
                                                            MapSize)
            break
            
        case .LandscapeRight:
            self.providerMapView.frame = CGRectMake(0, 20,CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame))
            self.providerInformationView.frame = CGRectMake(CGRectGetWidth(self.providerMapView.frame),
                                                            40,
                                                            CGRectGetWidth(self.providerMapView.frame),
                                                            MapSize)
            break
            
        case .Portrait:
            self.providerMapView.frame = CGRectMake(0, 70,CGRectGetWidth(self.view.frame), MapSize)
            self.providerInformationView.frame = CGRectMake(0,self.providerMapView.frame.origin.y + CGRectGetHeight(self.providerMapView.frame),
                                                            CGRectGetWidth(self.view.frame),150)
            break
            
        default:
            break
        }
        
    }
    
    func SetUpConstraints() -> Void {
        ConstraintHelper.visualFormatHelper(self.providerInformationView, format: "H:|-5-[company]-|", children: self.viewsDict)
        ConstraintHelper.visualFormatHelper(self.providerInformationView, format: "H:|-5-[location]-|", children: self.viewsDict)
        ConstraintHelper.visualFormatHelper(self.providerInformationView, format: "H:|-5-[reviews(==150)]-[grade(==150)]-5-|",
                                            children: self.viewsDict)
        ConstraintHelper.visualFormatHelper(self.providerInformationView, format: "V:|-5-[company(30)][location(==20)]-[reviews(==20)]-|", children: self.viewsDict)
        
        self.providerInformationView.addConstraint(NSLayoutConstraint(item: self.gradeLabel,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self.reviewsLabel,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))

        
    }
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.updateViews()
    }
    
    //MARK: mapview delegate
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        
    }
    
}
