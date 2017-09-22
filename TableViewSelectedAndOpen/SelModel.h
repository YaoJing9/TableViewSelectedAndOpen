//
//  SelModel.h
//  SelDemo
//
//  Created by 曼威 on 16/9/19.
//  Copyright © 2016年 yaojing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "subSelModel.h"
@interface SelModel : NSObject
@property (nonatomic,copy)NSString *PROJECT_NAME;
@property (nonatomic,copy)NSString *PROJECT_ID;
@property (nonatomic,strong)NSMutableArray *GetProjectTaskList;
//@property (nonatomic,strong)NSMutableArray *GetProjectTaskList;
@property(nonatomic,assign)BOOL isDisplay;
@property(nonatomic,assign)BOOL isAllSel;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
