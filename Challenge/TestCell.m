//
//  TestCell.m
//  Challenge
//
//  Created by Alexey on 12.09.13.
//  Copyright (c) 2013 Aleksey. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }

    return self;
}

- (void)setArticle:(NSDictionary *)article
{
    _article = article;
    
    NSNumber *unixtime = _article[@"posted_time"];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:unixtime.intValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    timeLabel.text = [formatter stringFromDate:date];
    
    NSNumber *main = article[@"main"];
    if ([main boolValue]) [titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    titleLabel.text = _article[@"title"];
    
    NSNumber *categoryID = article[@"category_id"];
    if ([categoryID intValue] == 208) category.text = @"Футбол";
    [category sizeToFit];
    
    NSNumber *commentsCount = article[@"comment_count"];
    if ([commentsCount intValue] != 0){
        comments.text = [commentsCount stringValue];
    } else {
        commentImage.hidden = YES;
        comments.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
