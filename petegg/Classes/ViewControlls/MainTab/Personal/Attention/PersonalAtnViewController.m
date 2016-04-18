//
//  PersonalAtnViewController.m
//  petegg
//
//  Created by czx on 16/4/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "PersonalAtnViewController.h"
#import "PersonAttentionTableViewCell.h"
static NSString * cellId = @"personAttentionCeliddd";
@interface PersonalAtnViewController ()

@end

@implementation PersonalAtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.v
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setupView{
    [super setupView];
    self.tableView.frame = CGRectMake(0, 40, self.view.width, self.view.height - NAV_BAR_HEIGHT);
    //  [self.tableView registerClass:[PersonDataTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView registerClass:[PersonAttentionTableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //  [self initRefreshView];
    
}

-(void)setupData{
    [super setupData];
    
}

#pragma mark - TableView的代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*W_Hight_Zoom;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonAttentionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


@end