//
//  AFHttpClient+Square.h
//  petegg
//
//  Created by ldp on 16/3/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Square)


/**
 * 描述
 */
-(void)queryFollowSproutpetWithMid:(NSString *)mid
                         pageIndex:(int)pageIndex
                          pageSize:(int)pageSize
                          complete:(void(^)(RecommendListModel *model))completeBlock
                           failure:(void(^)())failureBlock;
    
@end