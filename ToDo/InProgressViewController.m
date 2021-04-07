//
//  InProgressViewController.m
//  ToDo
//
//  Created by Esraa on 02/04/2021.
//

#import "InProgressViewController.h"
#import "DataModel.h"
@interface InProgressViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sort;

@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@end

@implementation InProgressViewController{
    NSArray *dataArray;
    NSMutableArray *done;
    NSMutableArray *todo;
    NSMutableArray *progress;
    NSInteger i;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    i=1;
    NSDate *data=[userDefaults objectForKey:@"data"];
    dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    done= [NSMutableArray new];
    todo= [NSMutableArray new];
    progress= [NSMutableArray new];
    for (int i=0;i<dataArray.count;i++) {
        if ([[[dataArray objectAtIndex:i]progressModel ]  isEqual: @"done"]) {
            [done addObject:[dataArray objectAtIndex:i]];
        }else if ([[[dataArray objectAtIndex:i]progressModel ]  isEqual: @"progress"]){
            [todo addObject:[dataArray objectAtIndex:i]];
        }else{
            [progress addObject:[dataArray objectAtIndex:i]];
        }
    }
    printf("dmdkdf %lu",[dataArray count]);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label=[cell viewWithTag:1];
    UIImageView *image=[cell viewWithTag:2];
    if (i==3) {
        switch (indexPath.section) {
            case 0:
                label.text=[[done objectAtIndex:indexPath.row]nameModel];
                printf("\ndone\n %lu",indexPath.row);
                if ([[[done objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"H"]) {        image.image=[UIImage imageNamed:@"h"];
                } else if ([[[done objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"M"]){
                    image.image=[UIImage imageNamed:@"m"];
                }else{
                    image.image=[UIImage imageNamed:@"l"];
                }
                return cell;
                break;
            case 1:
                label.text=[[todo objectAtIndex:indexPath.row]nameModel];
                printf("\ndone\n %lu",indexPath.row);
                if ([[[todo objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"H"]) {        image.image=[UIImage imageNamed:@"h"];
                } else if ([[[todo objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"M"]){
                    image.image=[UIImage imageNamed:@"m"];
                }else{
                    image.image=[UIImage imageNamed:@"l"];
                }
                return cell;
                break;
            case 3:
                label.text=[[progress objectAtIndex:indexPath.row]nameModel];
                printf("\ndone\n %lu",indexPath.row);
                if ([[[progress objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"H"]) {        image.image=[UIImage imageNamed:@"h"];
                } else if ([[[progress objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"M"]){
                    image.image=[UIImage imageNamed:@"m"];
                }else{
                    image.image=[UIImage imageNamed:@"l"];
                }
                return cell;
                break;
            default:
                break;
        }
    }else{
        UILabel *label=[cell viewWithTag:1];
        UIImageView *image=[cell viewWithTag:2];
        label.text=[[dataArray objectAtIndex:indexPath.row]nameModel];
        printf("dmdkdf %lu",[dataArray count]);

        if ([[[dataArray objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"H"]) {        image.image=[UIImage imageNamed:@"h"];
        } else if ([[[dataArray objectAtIndex:indexPath.row]perirotyModel]  isEqual:@"M"]){
            image.image=[UIImage imageNamed:@"m"];
        }else{
            image.image=[UIImage imageNamed:@"l"];
        }
        return cell;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (i==1) {
        return dataArray.count;
    }else{
        switch (section) {
            case 0:
                return done.count;
               break;
            case 1:
                return todo.count;
               break;
            case 2:
                return progress.count;
               break;
            default:
                return  0;
                break;
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return i;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (i==1) {
                 return @"All";
             }else{
        switch (section) {
        case 0:
            return @"done";
            break;
        case 1:
            return @"todo";
            break;
        case 2:
            return @"Prigress";
            break;
        default:
            return @"";
            break;
    }
    }
}




- (IBAction)sortAction:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *data=[userDefaults objectForKey:@"data"];
    dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    done= [NSMutableArray new];
    todo= [NSMutableArray new];
    progress= [NSMutableArray new];
    for (int i=0;i<dataArray.count;i++) {
        if ([[[dataArray objectAtIndex:i]progressModel ]  isEqual: @"done"]) {
            [done addObject:[dataArray objectAtIndex:i]];
        }else if ([[[dataArray objectAtIndex:i]progressModel ]  isEqual: @"todo"]){
            [todo addObject:[dataArray objectAtIndex:i]];
        }else{
            [progress addObject:[dataArray objectAtIndex:i]];
        }
    }
    if (i==1) {
        i=3;
    }else{
        i=1;
    }
    [self.tabelView reloadData];
}

@end
