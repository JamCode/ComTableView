//
//  TestAction.m
//  ComTableViewCtrl
//
//  Created by wang jam on 9/2/15.
//  Copyright (c) 2015 jam wang. All rights reserved.
//

#import "TestAction.h"

@implementation TestAction
{
    NSMutableArray* tableDataList;
}


//- (void)pullUpAction:(pullCompleted)completedBlock
//{
//    NSLog(@"my pull up action");
//    completedBlock();
//}

- (void)pullDownAction:(pullCompleted)completedBlock
{
    NSLog(@"my pull down action");
    
    tableDataList = [[NSMutableArray alloc] init];
    
    for (int i=0; i<20; ++i) {
        [tableDataList addObject:[[NSNumber alloc] initWithInt:i]];
    }
    completedBlock();
    
}

- (UITableViewCell*)generateCell:(UITableView*)tableview indexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseIdentify = @"testActionCell";
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:reuseIdentify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentify];
    }
    
    NSNumber* num = [tableDataList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d",[num intValue]];
    
    return cell;
}

- (NSInteger)rowNum
{
    return [tableDataList count];
}

@end
