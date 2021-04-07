//
//  DetailsViewController.m
//  ToDo
//
//  Created by Esraa on 05/04/2021.
//

#import "DetailsViewController.h"
#import "EditViewController.h"
@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *periority;
@property (weak, nonatomic) IBOutlet UILabel *dateRemider;
@property (weak, nonatomic) IBOutlet UILabel *ceariationDate;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _name.text= self.data.nameModel;
    _desc.text= self.data.discriptionModel;
    _periority.text= self.data.perirotyModel;
    _dateRemider.text= self.data.remiderDateModel;
    _ceariationDate.text= self.data.creationDateModel;
}
- (IBAction)edit:(id)sender {
    EditViewController *add= [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    add.dataarray=_dataarray;
    add.index=_index;
    add.data=_data;
     [self.navigationController pushViewController:add animated:YES];
}


@end
