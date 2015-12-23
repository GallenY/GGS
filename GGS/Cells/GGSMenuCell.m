//
//  GGSMenuCell.m
//  GGS
//
//  Created by 高阳 on 15/12/21.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSMenuCell.h"
#import <UIImageView+WebCache.h>
#import "GGSMenu.h"

@interface GGSMenuCell ()

@property (weak, nonatomic) IBOutlet UIImageView *albumsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsLabel;


@end

@implementation GGSMenuCell

- (void)setMenu:(GGSMenu *)menu
{
    _menu = menu;
    self.titleLabel.text = menu.title;
    self.stepsCountLabel.text = [NSString stringWithFormat:@"%lu 步",menu.steps.count];
    
    NSString *str;
    if (menu.ingredients.length >= 22) {
        str = [NSString stringWithFormat:@"材料：%@...",[menu.ingredients substringToIndex:22]];
    }else {
        str = [NSString stringWithFormat:@"材料：%@",menu.ingredients];
    }
    self.ingredientsLabel.text = str;

    [self.albumsImageView sd_setImageWithURL:[NSURL URLWithString:menu.albums]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
