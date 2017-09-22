//
//  SelCell.m
//  SelDemo
//
//  Created by 曼威 on 16/9/19.
//  Copyright © 2016年 yaojing. All rights reserved.
//

#import "SelCell.h"

@implementation SelCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 30, 30)];
        [_btn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [_btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn];
        
        
        
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 200, 30)];
        [self.contentView addSubview:_lab];
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}

- (void)setModel:(subSelModel *)model
{
    _model = model;
    self.btn.selected = model.isSubDisplay;
    self.lab.text = model.TASK_NAME;

}


- (void)btnClicked{
    _btn.selected = !_btn.selected;
    self.model.isSubDisplay = _btn.selected;
    if ([_delegate respondsToSelector:@selector(cellBtnClicked:)]) {
        [_delegate cellBtnClicked:self.indexPath];
    }
}




- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
