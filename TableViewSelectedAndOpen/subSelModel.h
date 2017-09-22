//
//  subSelModel.h
//  指望
//
//  Created by Eurlion on 16/9/20.
//  Copyright © 2016年 yaojing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface subSelModel : NSObject
@property (nonatomic,copy)NSString *PROJECT_TASK_ID;
@property (nonatomic,copy)NSString *TASK_NAME;
@property(nonatomic,assign)BOOL isSubDisplay;
- (instancetype)initWithSubDict:(NSDictionary *)dict;

@end
