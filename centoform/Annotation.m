//
//  Annotation.m
//  centoform
//
//  Created by Studente on 30/10/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation


-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate

                            posto:(NSString *)title
                         via:(NSString *)subtitle;

{

    self = [super init];
    if (self) {
        _subtitle = subtitle;
        _title = title;
        _coordinate = coordinate;
    }

    return self;
    
}




@end
