//
//  TableViewController.m
//  centoform
//
//  Created by Studente on 28/10/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"
#import "CellTableView.h"


@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;


@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.elencoCorsi.count;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellTableView *cell;
    cell= [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.titolo.text = self.elencoCorsi[indexPath.row][@"title"];
   
    
    NSString *descrizione = self.elencoCorsi[indexPath.row][@"description"];
    
    
    if ([descrizione isKindOfClass:[NSString class]]) {
        cell.descriptionText.text = descrizione ;
    }
    
    
    
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    
    
    NSString *tempo = self.elencoCorsi[indexPath.row][@"starts_at"];
    
    NSDate * date = [formatter dateFromString:tempo];
    
    [formatter setDateFormat:@"dd MMMM yyyy"];
    
    NSLog(@"date: %@", [formatter stringFromDate:date]);
    
    NSString *times = [NSString stringWithFormat:@"Data inizio: %@", [formatter stringFromDate:date]];
    
    cell.data.text = times;
    
    NSString *immagine =self.elencoCorsi[indexPath.row][@"image_url"];
    
    
    
    NSURL *url = [NSURL URLWithString:immagine];
    
    
    // passiamo l url alla request ad es richiesta di una pagine web
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // creo un oggetto di configurazione di default
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    // creo una sessione web
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    
    // metodo che esegui il download
    
    // in ingresso request e in uscita la posizione dei file sul disco come dati
    
    NSURLSessionDownloadTask *task;
    task = [session downloadTaskWithRequest:request
                          completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                              // location è l url dell immagine scaricata già salvata sul disco
                              
                              if (error) {
                                  // errore
                                  return;
                              }
                              // va a pescare i dati byte del contenuto del url presenti sul disco
                              NSData *rawData = [NSData dataWithContentsOfURL:location];
                              
                              // prende una stringa di byte grezzi e lo trasforma in un oggetto immagine
                              UIImage *image = [UIImage imageWithData:rawData];
                              
                              
                              //metto l istruzione nella coda del main e non in backgroung come le istruzioni precedenti per poterla vedere
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  
                             
                                  
                                  
                                  // imposto l immagine nella mia view
                                  cell.images.image = image;
                              });
                              
                              
                          }];
    
    // server per avviare il task
    [task resume];
    
    
    
    
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(CellTableView *)sender

{
    NSIndexPath *index = [self.table indexPathForCell:sender];
    DetailViewController *controller = (DetailViewController *)segue.destinationViewController;
    
    controller.inizioCorso = sender.data.text;
    controller.detail = self.elencoCorsi[index.row];
    controller.imageLogo2 = sender.images.image;
    
    

}







@end
