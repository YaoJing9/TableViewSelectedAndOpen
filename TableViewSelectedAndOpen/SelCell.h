//
//  SelCell.h
//  SelDemo
//
//  Created by 曼威 on 16/9/19.
//  Copyright © 2016年 yaojing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subSelModel.h"
@protocol CellBtnDelegate <NSObject>

- (void)cellBtnClicked:(NSIndexPath *)indexParh;

@end
@interface SelCell : UITableViewCell
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)subSelModel *model;
@property(nonatomic,assign)id <CellBtnDelegate> delegate;
@end
