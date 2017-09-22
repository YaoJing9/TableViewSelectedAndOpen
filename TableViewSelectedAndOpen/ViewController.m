//
//  ViewController.m
//  SelDemo
//
//  Created by 曼威 on 16/9/19.
//  Copyright © 2016年 zwxie. All rights reserved.
//

#import "ViewController.h"
#import "SelModel.h"
#import "SelCell.h"
#import "subSelModel.h"
#define kWidth            [UIScreen mainScreen].bounds.size.width
#define kHeight           [UIScreen mainScreen].bounds.size.height

//随机色
#define RGBRandom [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource, CellBtnDelegate>

@property(nonatomic, strong)UITableView      *tabelView;
@property(nonatomic, strong)NSMutableArray   *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择";
    self.dataArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self addSubView];
    
}
//本地json
- (void)initData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TextInfo" ofType:@"json"];
    NSString *jsonData = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if (jsonData != nil) {
        NSData *dat = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:&err];
        NSArray *tet = [dic objectForKey:@"data"];

        for (NSDictionary *di in tet) {
            SelModel *model = [[SelModel alloc] initWithDict:di];
            if (model)
            {
                [self.dataArr addObject:model];
            }
        }
        [self.tabelView reloadData];
        if(err){
            NSLog(@"json解析失败：%@",err);
        }
    }
}
//初始化tableView
- (void)addSubView
{
    self.tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20,kWidth,kHeight - 20) style:UITableViewStylePlain];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    self.tabelView.tableFooterView  = [UIView new];
    self.tabelView.rowHeight = 30;

    [self.view addSubview:self.tabelView];
}

#pragma mark - 代理
//section数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
//row数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SelModel *model = self.dataArr[section];
    //根据bool值
    return  model.isDisplay ?[model.GetProjectTaskList count] : 0;
}
//头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
//header视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 60)];
    vie.backgroundColor = RGBRandom;
    
    //全选button
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 30, 30)];
    btn.tag = section + 100;
    [btn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%d",  [self.dataArr[section] isAllSel]);
    btn.selected = [self.dataArr[section] isAllSel];
    [vie addSubview:btn];
    
    //展开button
    UIButton *openBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 50, 15, 30, 30)];
    openBtn.tag = section + 1000;
    [openBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [openBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [openBtn addTarget:self action:@selector(openBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%d",  [self.dataArr[section] isDisplay]);
    openBtn.selected = [self.dataArr[section] isDisplay];
    [vie addSubview:openBtn];

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 300, 40)];
    SelModel *model = self.dataArr[section];
    lab.text = model.PROJECT_NAME;
    [vie addSubview:lab];
    
    return vie;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    SelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.model = [self.dataArr[indexPath.section] GetProjectTaskList][indexPath.row];
    return cell;
    
}
//头视图button全选
-(void)btnAction:(UIButton *)btn{
    SelModel *model = self.dataArr[btn.tag - 100];
    btn.selected = !btn.selected;
    model.isAllSel = btn.selected;
    for (subSelModel *subModel in model.GetProjectTaskList) {
        subModel.isSubDisplay = model.isAllSel;
    }
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:btn.tag-100];
    [self.tabelView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

//头视图按钮事件展开
-(void)openBtnClicked:(UIButton *)btn{
    SelModel *model = self.dataArr[btn.tag - 1000];
    btn.selected = !btn.selected;
    model.isDisplay = btn.selected;
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:btn.tag-1000];
    [self.tabelView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - cell代理
- (void)cellBtnClicked:(NSIndexPath *)indexParh{
    //点击一个cell头部选中;
    UIButton *button = [self.view viewWithTag:indexParh.section + 100];
    SelModel *model = self.dataArr[indexParh.section];
    NSMutableArray *boolAry = [NSMutableArray array];
    for (subSelModel *subModel in [self.dataArr[indexParh.section] GetProjectTaskList]) {
        [boolAry addObject:[NSString stringWithFormat:@"%d", subModel.isSubDisplay]];
    }
    if ([boolAry containsObject:@"1"]) {
        button.selected = YES;
        model.isAllSel = YES;
        
    }else{
        button.selected = NO;
        model.isAllSel = NO;
    }
}
@end
