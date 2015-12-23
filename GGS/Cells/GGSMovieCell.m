//
//  GGSMovieCell.m
//  GGS
//
//  Created by 高阳 on 15/12/22.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSMovieCell.h"
#import "GGSMovie.h"

@interface GGSMovieCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *boxofficeLabel;

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@end

@implementation GGSMovieCell

- (void)setMovie:(GGSMovie *)movie
{
    _movie = movie;
    self.rankLabel.text = [NSString stringWithFormat:@"%lu",movie.rank+1];
    self.rankLabel.layer.cornerRadius = 10;
    self.rankLabel.layer.masksToBounds = YES;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",movie.name];
    NSString *boxoffice;
    //票房上亿，红色，单位亿，灰色单位百万， 绿色 万
    if (movie.boxoffice/1000000 > 1) {
        boxoffice = [NSString stringWithFormat:@"%0.2f 亿",movie.boxoffice/1000000];
        self.backgroundColor = [UIColor redColor];
    }else if (movie.boxoffice/10000 >1) {
        boxoffice = [NSString stringWithFormat:@"%0.2f 百万",movie.boxoffice/10000];
        self.backgroundColor = [UIColor grayColor];
    }else {
        boxoffice = [NSString stringWithFormat:@"%0.2f 万",movie.boxoffice/100];
        self.backgroundColor = [UIColor greenColor];
    }
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.boxofficeLabel.text = boxoffice;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
