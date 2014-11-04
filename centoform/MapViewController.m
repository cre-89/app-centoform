//
//  MapViewController.m
//  centoform
//
//  Created by Studente on 04/11/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import "MapViewController.h"

@import MapKit;
#import "Annotation.h"

@interface MapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic)CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation MapViewController


-(CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}




- (IBAction)closeMap:(id)sender {
    

    
    [self dismissViewControllerAnimated:YES completion:^{
        [UIApplication sharedApplication].statusBarHidden = NO;
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    CLLocationCoordinate2D location;
    location.latitude = [self.detail2[@"latitude"]doubleValue];
    location.longitude = [self.detail2[@"longitude"]doubleValue];
    
    
    Annotation *puntino = [[Annotation alloc]initWithCoordinate:location posto:self.detail2[@"location"] via:self.detail2[@"address"]];
    [self.map addAnnotation:puntino];
    
    
    MKMapRect zoomRect = MKMapRectNull;
    MKMapPoint annotationPoint = MKMapPointForCoordinate(puntino.coordinate);
    MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
    zoomRect = MKMapRectUnion(zoomRect, pointRect);
    [self.map setVisibleMapRect:zoomRect animated:YES];
    [self.map setShowsUserLocation:YES];
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:location addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc]initWithPlacemark: placemark];
    [self getDirectionsFor: item];
    
    [self.locationManager requestWhenInUseAuthorization];
    self.map.delegate = self;
    


     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Chiudi mappa" style:UIBarButtonItemStylePlain target:self action:@selector(closeMap:)];
    
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    }




-(void)getDirectionsFor:(MKMapItem *)item
{
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = item;
    request.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            
            [self showRoute:response];
        }
    }];
    
}


-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes) {
        [self.map addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps) {
            NSLog(@"%@", step.instructions);
        }
        
    }
    
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    
    MKPolylineRenderer *renderer = [[[MKPolylineRenderer alloc]init] initWithOverlay:overlay];
    
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
    
}


@end
