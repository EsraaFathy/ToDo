//
//  AddNewViewController.h
//  ToDo
//
//  Created by Esraa on 05/04/2021.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddNewViewController : UIViewController <UITextFieldDelegate>
@property ViewController* calssView;
@property BOOL isGranted;
@end

NS_ASSUME_NONNULL_END
