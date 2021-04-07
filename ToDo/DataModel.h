//
//  DataModel.h
//  ToDo
//
//  Created by Esraa on 02/04/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject <NSCoding>
@property NSString *nameModel;
@property NSString *perirotyModel;
@property NSString *discriptionModel;
@property NSString *remiderDateModel;
@property NSString *progressModel;
@property NSString *creationDateModel;
@end

NS_ASSUME_NONNULL_END
