//
//  ViewController.m
//  MapCoord
//
//  Created by Andrei on 06/11/2015.
//  Copyright © 2015 Andrei. All rights reserved.
//

#import "ViewController.h"
#import <Mapkit/Mapkit.h>
#import "ASMapView.h"
@interface ViewController ()<MKMapViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.title = @"Route";
 
}
-(void)showMapWithOriginLat:(double)lat1 andLon1:(double)lon1 andDestinationLat:(double)lat2 andLon2:(double)lon2{
    
    CLLocationCoordinate2D coordinateArray[2];
    
    coordinateArray[0] = CLLocationCoordinate2DMake(lat1, lon1);
    coordinateArray[1] = CLLocationCoordinate2DMake(lat2, lon2);
  
    MKPointAnnotation* pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = coordinateArray[0];
    MKPointAnnotation* pointAnnotation2 = [[MKPointAnnotation alloc] init];
    pointAnnotation2.coordinate = coordinateArray[1];
    ASMapView *mapView = [[ASMapView alloc]initWithFrame:self.view.frame];
    [mapView showRouteFrom:pointAnnotation to:pointAnnotation2];
    [self.view addSubview:mapView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
