//
//  ASMapView.h
//  MapCoord
//
//  Created by Andrei on 06/11/2015.
//  Copyright © 2015 Andrei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>

@interface ASMapView : UIView<MKMapViewDelegate>
{
    MKMapView* mapView;
    NSArray* routes;
    BOOL isUpdatingRoutes;
}

-(void) showRouteFrom:(id<MKAnnotation>)f to:(id<MKAnnotation>)t;

@end
