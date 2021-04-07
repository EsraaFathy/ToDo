//
//  DetailsViewController.h
//  ToDo
//
//  Created by Esraa on 05/04/2021.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property DataModel *data;
@property NSArray *dataarray;
@property long index;
@end

NS_ASSUME_NONNULL_END
