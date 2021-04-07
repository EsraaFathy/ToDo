//
//  EditViewController.m
//  ToDo
//
//  Created by Esraa on 05/04/2021.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameL;
@property (weak, nonatomic) IBOutlet UILabel *periorityL;
@property (weak, nonatomic) IBOutlet UIButton *heightB;
@property (weak, nonatomic) IBOutlet UITextField *descL;
@property (weak, nonatomic) IBOutlet UIButton *medumL;
@property (weak, nonatomic) IBOutlet UIButton *lowL;
@property (weak, nonatomic) IBOutlet UIButton *todoBtn;
@property (weak, nonatomic) IBOutlet UIButton *progressBtn;
@property (weak, nonatomic) IBOutlet UIButton *doneBTN;
@property (weak, nonatomic) IBOutlet UILabel *_progressLabel;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameL.text=_data.nameModel;
    _descL.text=_data.discriptionModel;
    _periorityL.text=_data.perirotyModel;
    __progressLabel.text=_data.progressModel;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *data=[userDefaults objectForKey:@"data"];
    _dataarray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
- (IBAction)saveBTN:(id)sender {
    _data.nameModel=_nameL.text;
    _data.perirotyModel=_periorityL.text;
    _data.discriptionModel=_descL.text;
    _data.progressModel=__progressLabel.text;
    NSMutableArray *arr=[_dataarray mutableCopy];
    [arr removeObjectAtIndex:_index];
    //[arr addObject:_data];
    printf("%lu",_index);
    [arr insertObject:_data atIndex:_index];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *dataObject=[NSKeyedArchiver archivedDataWithRootObject:arr];
    [userDefaults setObject:dataObject forKey:@"data"];
    [userDefaults synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)progressAction:(id)sender {
    UIButton * btn=(UIButton*)sender;
    if (btn == _todoBtn) {
        __progressLabel.text=@"todo";
    }else if (btn == _progressBtn) {
        __progressLabel.text=@"progress";
    }else{
        __progressLabel.text=@"done";
    }
}
- (IBAction)periority:(id)sender {
    UIButton * btn=(UIButton*)sender;
    if (btn == _heightB) {
        _periorityL.text=@"H";
    }else if (btn == _medumL) {
        _periorityL.text=@"M";
    }else{
        _periorityL.text=@"L";
    }
}

@end
