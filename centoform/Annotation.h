//
//  Annotation.h
//  centoform
//
//  Created by Studente on 30/10/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;


@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;



-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                            posto:(NSString *)title
                         via:(NSString *)subtitle;




@end
