//
//  ViewController.m
//  centoform
//
//  Created by Studente on 28/10/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import <STHTTPRequest.h>
#import "CellTableView.h"

@interface ViewController ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buttonPartenza;
@property (nonatomic, strong)NSArray *tipiCorso;
@property (weak, nonatomic) IBOutlet UIImageView *imageLogo;
@property (nonatomic, strong)NSDictionary *jsonData;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    self.buttonPartenza.alpha = 0;

    STHTTPRequest *request = [STHTTPRequest requestWithURLString:@"http://centoscraper.herokuapp.com/courses.json"];
    
    request.completionBlock =^(NSDictionary *header, NSString *body){
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        self.jsonData = jsonData;
    
        NSLog(@"%@", jsonData);
        
        self.buttonPartenza.alpha = 1;
        
        [self.indicator stopAnimating];
    };
    
    request.errorBlock = ^(NSError *error){
        NSLog(@"%@", error);
    };
    
   
    [request startAsynchronous];

}




- (IBAction)actionCorsi:(id)sender {
    
    UIActionSheet *corsiSheet;
    
    corsiSheet = [[UIActionSheet alloc] initWithTitle:@"Seleziona un Corso in Partenza per:"
                                             delegate:self
                                    cancelButtonTitle:@"Annulla"
                               destructiveButtonTitle:nil
                                    otherButtonTitles:nil];
    
    
    // fai il ciclo dei vari titoli del array
    for (NSString *string in [self.jsonData allKeys]){
        
        // aggiungi un pulsante nel action sheet per ogni titolo presente nel array
        [corsiSheet addButtonWithTitle:NSLocalizedString(string,)];
    }
    // fai vedere la sheet nella view corrente
    [corsiSheet showInView:self.view];

    
}

// quando selezione un bottone nel action sheet



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    // perchè l arrai parte da 0 mentre lo sheet parte da uno, lo 0 è annulla
    if (buttonIndex > 0) {
        
        
      
        [self performSegueWithIdentifier:@"segueCorsi" sender:@(buttonIndex -1)];
       }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{


    int index = [sender intValue];
    NSString *key= [self.jsonData allKeys][index];
    
    
     
    TableViewController *controller = (TableViewController *)segue.destinationViewController;
    
    // imposta a (cè set perchè è il setter di) ContentURL il contenuto di url
    [controller setElencoCorsi:self.jsonData[key]];

}



@end



