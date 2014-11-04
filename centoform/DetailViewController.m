//
//  DetailViewController.m
//  centoform
//
//  Created by Studente on 28/10/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import "DetailViewController.h"
//@import MapKit;
//#import "Annotation.h"
#import "MapViewController.h"

@interface DetailViewController () //<MKMapViewDelegate, CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UILabel *titolo;
@property (weak, nonatomic) IBOutlet UILabel *durata;
@property (weak, nonatomic) IBOutlet UITextView *descrizione;

@property (weak, nonatomic) IBOutlet UILabel *sedeDetail;
@property (weak, nonatomic) IBOutlet UILabel *viaDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imageLogo;



@end

@implementation DetailViewController







   
    



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.titolo.text = self.detail[@"title"];
    
     NSString *time = [NSString stringWithFormat:@"%@", self.inizioCorso];
    
    self.durata.text = time;
    
    NSString *info =self.detail[@"description"];
    
    if ([info isKindOfClass:[NSString class]]) {
        
       
        NSString *description = [NSString stringWithFormat:@"Descrizione: %@", info ];
        
        self.descrizione.text = description;
        
        
        
    }
    else{
    
        
        self.descrizione.text = [NSString stringWithFormat:@"Descrizione non disponibile"];
   }
    
    
    self.viaDetail.text = self.detail[@"address"];
    self.sedeDetail.text = self.detail[@"location"];
    
       
    
    self.imageLogo.image = self.imageLogo2;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(DetailViewController *)sender

{
    
    
    
    
    MapViewController *controller2 = (MapViewController *)segue.destinationViewController;
    
    controller2.detail2 = self.detail;
    
    
}


    
   
    









@end
