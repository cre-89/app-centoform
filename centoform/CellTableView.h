//
//  CellTableView.h
//  centoform
//
//  Created by Studente on 30/10/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellTableView : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UILabel *descriptionText;
@property (weak, nonatomic) IBOutlet UILabel *titolo;
@property (weak, nonatomic) IBOutlet UILabel *data;


@end
