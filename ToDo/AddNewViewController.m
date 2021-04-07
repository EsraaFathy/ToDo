//
//  AddNewViewController.m
//  ToDo
//
//  Created by Esraa on 05/04/2021.
//

#import "AddNewViewController.h"
#import "DataModel.h"
#import <UserNotifications/UserNotifications.h>
@interface AddNewViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *choosedDate;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *desc;
@property (weak, nonatomic) IBOutlet UILabel *periorityLabel;
@property (weak, nonatomic) IBOutlet UIButton *high;
@property (weak, nonatomic) IBOutlet UIButton *medium;
@property (weak, nonatomic) IBOutlet UIButton *low;

@end
static NSMutableArray *dataArray;
@implementation AddNewViewController{
    DataModel *model;
    NSUserDefaults *userDefaults;
//    UILocalNotification* localNotification;
}
-(NSMutableArray*) loadArray{
    if (dataArray == nil) {
        return [NSMutableArray new];
    }else{
        return dataArray;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray=[self loadArray];
    model=[DataModel new];
    _choosedDate.delegate=self;
    [_datePicker setDate:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   dateFormatter.dateFormat = @"dd-MMM-yyyy h:mm a";
   // [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [_choosedDate setInputView:_datePicker];
    userDefaults = [NSUserDefaults standardUserDefaults];
    printf("\ndid load adda task %lu\n",[dataArray count]);
}
- (IBAction)addToDefults:(id)sender {
    model.nameModel=_name.text;
    model.discriptionModel=_desc.text;
    model.perirotyModel=_periorityLabel.text;
    model.remiderDateModel=_choosedDate.text;
    model.progressModel=@"todo";
    
    [dataArray addObject:model];
    printf("add %lu",[dataArray count]);
    NSDate *dataObject=[NSKeyedArchiver archivedDataWithRootObject:dataArray];
    [userDefaults setObject:dataObject forKey:@"data"];
    [userDefaults synchronize];
    [self.calssView update];
    [self showNotification];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)date:(id)sender {
}


-(void)updateTextField:(id)sender {
    UIDatePicker *picker = (UIDatePicker*)_choosedDate.inputView;
    NSDate *dateC=picker.date;
    self.choosedDate.text = [self formatDate:picker.date];
    model.creationDateModel=[self formatDate:picker.date];

}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy h:mm a"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

- (IBAction)setPeriorityAction:(id)sender {
    UIButton * btn=(UIButton*)sender;
    if (btn == _high) {
        [_periorityLabel setText:@"H"];
    }else if (btn == _medium) {
        [_periorityLabel setText:@"M"];
    }else{
        [_periorityLabel setText:@"L"];
    }
}

-(void) showNotification
{
    //if(_isGranted){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
        NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                         components:NSCalendarUnitYear +
                                         NSCalendarUnitMonth + NSCalendarUnitDay +
                                         NSCalendarUnitHour + NSCalendarUnitMinute +
                                         NSCalendarUnitSecond fromDate:[_datePicker date]];
        content.title = @"Reminder for task";
        content.subtitle = _name.text;
        content.body = _desc.text;
        content.badge = [NSNumber numberWithInteger:([UIApplication sharedApplication].applicationIconBadgeNumber + 1)];
        
        content.sound = [UNNotificationSound defaultSound];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:_name.text content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
//}
        
}

@end
