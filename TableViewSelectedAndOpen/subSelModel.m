//
//  subSelModel.m
//  指望
//
//  Created by Eurlion on 16/9/20.
//  Copyright © 2016年 yaojing. All rights reserved.
//

#import "subSelModel.h"

@implementation subSelModel
- (instancetype)initWithSubDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.PROJECT_TASK_ID = [dict objectForKey:@"PROJECT_TASK_ID"];
        self.TASK_NAME = [dict objectForKey:@"TASK_NAME"];
        _isSubDisplay = NO;
    }
    return self;
}

@end
