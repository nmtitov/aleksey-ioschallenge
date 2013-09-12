//
//  TestCell.h
//  Challenge
//
//  Created by Alexey on 12.09.13.
//  Copyright (c) 2013 Aleksey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCell : UITableViewCell
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *category;
    IBOutlet UILabel *comments;
    IBOutlet UIImageView *commentImage;
}

@property (nonatomic, strong) NSDictionary *article;

@end
