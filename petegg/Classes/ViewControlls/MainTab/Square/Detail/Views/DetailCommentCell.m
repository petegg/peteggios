//
//  DetailCommentCell.m
//  petegg
//
//  Created by ldp on 16/4/8.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "DetailCommentCell.h"

#import "UIImageView+WebCache.h"

@interface DetailCommentCell()

@property (nonatomic, strong) UIImageView* iconIV;
@property (nonatomic, strong) UILabel* nameLB;  //名字
@property (nonatomic, strong) UILabel* timeLB;  //时间
@property (nonatomic, strong) UILabel* typeLB;  //种类
@property (nonatomic, strong) UILabel* genderLB; //性别
@property (nonatomic, strong) UILabel* ageLB; //年龄
@property (nonatomic, strong) UIButton* replyBtn; //回复
@property (nonatomic, strong) UILabel* contentLB; //评论内容

@property (nonatomic, strong) NSMutableArray *commentLabelsArray;

@end

@implementation DetailCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupView{
    
    _iconIV = [[UIImageView alloc] init];
    _iconIV.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_iconIV];
    
    _nameLB = [[UILabel alloc] init];
    _nameLB.font = [UIFont systemFontOfSize:18];
    _nameLB.numberOfLines = 1;
    [self.contentView addSubview:_nameLB];

    _typeLB = [[UILabel alloc] init];
    _typeLB.font = [UIFont systemFontOfSize:13];
    _typeLB.textAlignment = NSTextAlignmentCenter;
    _typeLB.numberOfLines = 1;
    _typeLB.textColor = GREEN_COLOR;
    _typeLB.layer.borderColor = GREEN_COLOR.CGColor;
    _typeLB.layer.borderWidth = 1.f;
    
    _genderLB = [[UILabel alloc] init];
    _genderLB.font = [UIFont systemFontOfSize:13];
    _genderLB.textAlignment = NSTextAlignmentCenter;
    _genderLB.numberOfLines = 1;
    _genderLB.textColor = GREEN_COLOR;
    _genderLB.layer.borderColor = GREEN_COLOR.CGColor;
    _genderLB.layer.borderWidth = 1.f;
    
    _ageLB = [[UILabel alloc] init];
    _ageLB.font = [UIFont systemFontOfSize:13];
    _ageLB.textAlignment = NSTextAlignmentCenter;
    _ageLB.numberOfLines = 1;
    _ageLB.textColor = GREEN_COLOR;
    _ageLB.layer.borderColor = GREEN_COLOR.CGColor;
    _ageLB.layer.borderWidth = 1.f;
    
    _timeLB = [[UILabel alloc] init];
    _timeLB.font = [UIFont systemFontOfSize:12];
    _timeLB.numberOfLines = 1;
    _timeLB.textColor = [UIColor lightGrayColor];
    
    _replyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_replyBtn setTitle:@"回复" forState:UIControlStateNormal];
    _replyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_replyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_replyBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        
        if (self.replyBlock) {
            self.replyBlock();
        }
    }];
    
    
    _contentLB = [UILabel new];
    _contentLB.font = [UIFont systemFontOfSize:15];
    _contentLB.numberOfLines = 0;

    [self.contentView sd_addSubviews:@[_iconIV, _nameLB, _typeLB, _genderLB, _ageLB, _timeLB, _contentLB, _replyBtn]];
    
    UIView *contentView = self.contentView;

    _iconIV.sd_layout.widthIs(50).heightEqualToWidth().leftSpaceToView(contentView, 8).topSpaceToView(contentView, 8);
    _iconIV.sd_cornerRadiusFromWidthRatio = @(0.5);

    _nameLB.sd_layout.leftSpaceToView(_iconIV, 10).topEqualToView(_iconIV).minHeightIs(25);
    [_nameLB setSingleLineAutoResizeWithMaxWidth:contentView.width * 0.5];
    
    _typeLB.sd_layout.leftSpaceToView(_nameLB, 8).centerYEqualToView(_nameLB).widthIs(20).heightIs(20);
    _typeLB.sd_cornerRadiusFromWidthRatio = @(0.5);
   
    _genderLB.sd_layout.leftSpaceToView(_typeLB, 8).centerYEqualToView(_typeLB).widthIs(20).heightIs(20);
    _genderLB.sd_cornerRadiusFromWidthRatio = @(0.5);
   
    _ageLB.sd_layout.leftSpaceToView(_genderLB, 8).centerYEqualToView(_genderLB).widthIs(40).heightIs(20);
    _ageLB.sd_cornerRadiusFromWidthRatio = @(0.28);
    
    _timeLB.sd_layout.leftEqualToView(_nameLB).topSpaceToView(_nameLB, 6).heightIs(30).autoHeightRatio(0);
    [_timeLB setSingleLineAutoResizeWithMaxWidth:contentView.width * 0.5];
    
    _replyBtn.sd_layout.centerYEqualToView(_timeLB).rightSpaceToView(contentView, 8).heightIs(30).widthIs(40);
    
    _contentLB.sd_layout.leftEqualToView(_timeLB).topSpaceToView(_timeLB, 8).rightSpaceToView(contentView, 8).autoHeightRatio(0);
    
}

- (void)setModel:(CommentModel *)model{
    
    _model = model;
    
    self.nameLB.text = model.memname;
    
    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    
    self.typeLB.text = model.race;
    self.timeLB.text = model.opttime;
     
    self.contentLB.text = model.content;
    self.contentLB.sd_layout.maxHeightIs(MAXFLOAT);
    
    self.genderLB.text = [model.sex isEqualToString:@"公"] ? @"♂" : @"♀";
    self.ageLB.text = [NSString stringWithFormat:@"%@岁", model.age];
    
    [self setupAutoHeightWithBottomView:self.contentLB bottomMargin:8];
   
}

@end
