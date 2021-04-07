//
//  DataModel.m
//  ToDo
//
//  Created by Esraa on 02/04/2021.
//

#import "DataModel.h"

@implementation DataModel
-(instancetype)initWithCoder:(NSCoder *)coder{
    self.nameModel=[coder decodeObjectForKey:@"nameModel"];
    self.perirotyModel=[coder decodeObjectForKey:@"perirotyModel"];
    self.progressModel=[coder decodeObjectForKey:@"progressModel"];
    self.creationDateModel=[coder decodeObjectForKey:@"creationDateModel"];
    self.remiderDateModel=[coder decodeObjectForKey:@"remiderDateModel"];
    self.discriptionModel=[coder decodeObjectForKey:@"discriptionModel"];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.nameModel forKey:@"nameModel"];
    [coder encodeObject:self.perirotyModel forKey:@"perirotyModel"];
    [coder encodeObject:self.progressModel forKey:@"progressModel"];
    [coder encodeObject:self.creationDateModel forKey:@"creationDateModel"];
    [coder encodeObject:self.remiderDateModel forKey:@"remiderDateModel"];
    [coder encodeObject:self.discriptionModel forKey:@"discriptionModel"];
}
@end
