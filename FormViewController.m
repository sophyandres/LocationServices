//
//  FormViewController.m
//  MapCoord
//
//  Created by Andrei on 07/11/2015.
//  Copyright © 2015 Andrei. All rights reserved.
//

#import "FormViewController.h"
#import "ViewController.h"

@interface FormViewController (){
    double DestinationLatitude;
    double DestinationLongitude;
}
@property (weak, nonatomic) IBOutlet UITextField *OriginTextField;
@property (weak, nonatomic) IBOutlet UITextField *DestinationTextField;
@property (weak, nonatomic) IBOutlet UIButton *MyLocationButton;

@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)GetMyLocation:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                           
                       }
                       
                       if(placemarks && placemarks.count > 0)
                           
                       {
                          
                           CLPlacemark *topResult = [placemarks objectAtIndex:0];
                           NSString *addressTxt = [NSString stringWithFormat:@"%@ %@",
                                                   [topResult postalCode],[topResult country]];
                           
                           _MyLocationButton.titleLabel.text = @"";
                           _OriginTextField.text = addressTxt;
                       }
                   }];
}

- (void)addressToCoordinates:(NSString*)address {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_DestinationTextField.text completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            // Process the placemark.
            NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
            NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
            DestinationLatitude = aPlacemark.location.coordinate.latitude;
            DestinationLongitude = aPlacemark.location.coordinate.longitude;
            
            NSLog(@"%@ %@",latDest1,lngDest1);
        }
        if(placemarks>0){
            [self ShowRouteonMap];
        }
    }];
}

- (IBAction)FindRoute:(id)sender {
    [self addressToCoordinates:_OriginTextField.text];
}
-(void)ShowRouteonMap{
    ViewController *RouteViewController = [[ViewController alloc]init];
    [RouteViewController showMapWithOriginLat:locationManager.location.coordinate.latitude andLon1:locationManager.location.coordinate.longitude andDestinationLat:DestinationLatitude andLon2:DestinationLongitude];
    [self.navigationController pushViewController:RouteViewController animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
