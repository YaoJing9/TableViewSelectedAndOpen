//
//  SelModel.m
//  SelDemo
//
//  Created by 曼威 on 16/9/19.
//  Copyright © 2016年 yaojing. All rights reserved.
//

#import "SelModel.h"
#import "subSelModel.h"

@implementation SelModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.PROJECT_NAME = [dict objectForKey:@"PROJECT_NAME"];
        self.PROJECT_ID = [dict objectForKey:@"PROJECT_ID"];
        self.GetProjectTaskList = [NSMutableArray array];
        for (int i = 0; i < [[dict objectForKey:@"GetProjectTaskList"] count]; i++) {
            subSelModel *model = [[subSelModel alloc] initWithSubDict:[dict objectForKey:@"GetProjectTaskList"][i]];
            [self.GetProjectTaskList addObject:model];
        }
        _isDisplay = NO;
        _isAllSel = NO;
    }
    return self;
}
@end
