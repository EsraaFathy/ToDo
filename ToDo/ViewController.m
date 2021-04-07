//
//  ViewController.m
//  ToDo
//
//  Created by Esraa on 02/04/2021.
//

#import "ViewController.h"
#import "DataModel.h"
#import "AddNewViewController.h"
#import "DetailsViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController{
    NSArray *dataArray;
    NSMutableArray *dataFilterArray;
    Boolean isFilered;
    BOOL isGrantedNotificationAccess;

}

-(void) notificationAuth
{
    isGrantedNotificationAccess = NO;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionSound+UNAuthorizationOptionAlert;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        isGrantedNotificationAccess = granted;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isFilered=NO;
    _searchBar.delegate=self;
    _tabelView.delegate=self;
    _tabelView.dataSource=self;
    _tabelView.allowsMultipleSelectionDuringEditing = NO;
    dataArray=[NSArray new];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *data=[userDefaults objectForKey:@"data"];
    dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    printf("did load %lu\n",[dataArray count]);
    self.notificationAuth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label=[cell viewWithTag:1];
    UIImageView *image=[cell viewWithTag:2];
    if (isFilered == YES) {
        label.text=[[dataFilterArray objectAtIndex:indexPath.row]nameModel];
        printf("dmdkdf %lu",[dataArray count]);
        if ([[[dataFilterArray objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"H"]) {        image.image=[UIImage imageNamed:@"h"];
        } else if ([[[dataFilterArray objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"M"]){
            image.image=[UIImage imageNamed:@"m"];
        }else{
            image.image=[UIImage imageNamed:@"l"];
        }
    }else{
    label.text=[[dataArray objectAtIndex:indexPath.row]nameModel];
    printf("dmdkdf %lu",[dataArray count]);
    if ([[[dataArray objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"H"]) {        image.image=[UIImage imageNamed:@"h"];
    } else if ([[[dataArray objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"M"]){
        image.image=[UIImage imageNamed:@"m"];
    }else{
        image.image=[UIImage imageNamed:@"l"];
    }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    printf("%ld", [dataArray count]);
    if (isFilered == YES) {
        return dataFilterArray.count;
    }
    return [dataArray count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (IBAction)insert:(id)sender {
    AddNewViewController *add= [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewViewController"];
    add.calssView=self;
    add.isGranted=isGrantedNotificationAccess;
     [self.navigationController pushViewController:add animated:YES];
    
}

//- (IBAction)reload:(id)sender {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSDate *data=[userDefaults objectForKey:@"data"];
//    dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    printf("reload %lu",[dataArray count]);
//    [self.tabelView reloadData];
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *add= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    add.dataarray=dataArray;
    add.index=indexPath.row;
    add.data=[dataArray objectAtIndex:indexPath.row];
     [self.navigationController pushViewController:add animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        NSMutableArray *arr= [dataArray mutableCopy];
        [arr removeObjectAtIndex:indexPath.row];
        dataArray=arr;
        [self.tabelView reloadData];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDate *dataObject=[NSKeyedArchiver archivedDataWithRootObject:dataArray];
        [userDefaults setObject:dataObject forKey:@"data"];
        [userDefaults synchronize];
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSMutableArray *data=[NSMutableArray new];
    for (int i=0; i<dataArray.count; i++) {
        [data addObject:[[dataArray objectAtIndex:i] nameModel]];
        printf("%s",[[[dataArray objectAtIndex:i] nameModel] UTF8String]);
    }

    if (searchText.length==0) {
        isFilered=NO;
        [self.tabelView reloadData];
    }else{
        isFilered=YES;
        dataFilterArray=[NSMutableArray new];
        for (int i=0;i<data.count;i++) {
            NSRange range=[[data objectAtIndex:i] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [dataFilterArray addObject:[dataArray objectAtIndex:i]];
            }
        }
    [self.tabelView reloadData];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_tabelView resignFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isFilered=NO;
    [_tabelView reloadData];
}
- (void)update{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *data=[userDefaults objectForKey:@"data"];
    dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    printf("reload %lu",[dataArray count]);
    [self.tabelView reloadData];
}
@end
