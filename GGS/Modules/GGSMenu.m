//
//  GGSMenu.m
//  GGS
//
//  Created by 高阳 on 15/12/21.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSMenu.h"
#import <MJExtension/MJExtension.h>

@implementation GGSMenu

- (NSString *)description
{
    return [NSString stringWithFormat:@"title =%@, tags = %@, intro = %@, ingredients = %@, burden = %@, albums = %@, steps = %@",self.title,self.tags,self.intro,self.ingredients,self.burden,self.albums,self.steps];
}

+ (NSMutableArray<GGSMenu *> *)modelArrFromJSONArr:(NSArray *)jsonArr
{
    NSMutableArray *models = [NSMutableArray array];
    for (id i in jsonArr) {
        GGSMenu *menu = [[GGSMenu alloc] init];
        
        menu.id = [i[@"id"] integerValue];
        menu.title = i[@"title"];
        menu.ingredients = i[@"ingredients"];
        menu.albums = i[@"albums"];
//        menu.intro = i[@"intro"];
        menu.burden = i[@"burden"];
//        menu.tags = i[@"tags"];
        menu.steps = [GGSMenuStep mj_objectArrayWithKeyValuesArray:i[@"steps"]];
        [models addObject:menu];
    }
    return models;
}
@end
