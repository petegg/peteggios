//
//  BaseCollectionViewController.m
//  petegg
//
//  Created by yulei on 16/4/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super  viewWillAppear:animated];
    
}

- (void)setupView
{
    [super setupView];
    UICollectionViewFlowLayout * fl=[[UICollectionViewFlowLayout alloc] init];
    fl.scrollDirection=UICollectionViewScrollDirectionVertical;
    self.collection =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:fl];
    self.collection.dataSource = self;
    self.collection.delegate = self;
    self.collection.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.collection];
    
}

- (void)setupData
{
    [super setupData];
    _dataSource =[[NSMutableArray alloc]init];

}

- (void)updateData
{
    
    [self.collection.header beginRefreshing];
    
}


- (void)initRefreshView:(NSString *)stateNu
{
     __typeof (&*self) __weak weakSelf = self;
    self.collection.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         weakSelf.stateNum = stateNu;
        [weakSelf data:weakSelf.stateNum];
        
    }];
    self.collection.footer.hidden = YES;
    [self.collection.header beginRefreshing];
}

-(void)handleEndRefresh{
    [self.collection.header endRefreshing];
    [self.collection.footer endRefreshing];
    
    
}

- (void)data:(NSString *)stateNum
{
    
    
}

#pragma Mrak ---UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
    
}



@end
