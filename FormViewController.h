//
//  FormViewController.h
//  MapCoord
//
//  Created by Andrei on 07/11/2015.
//  Copyright © 2015 Andrei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FormViewController : UIViewController<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@end
