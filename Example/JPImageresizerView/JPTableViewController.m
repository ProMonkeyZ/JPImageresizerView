//
//  JPTableViewController.m
//  JPImageresizerView_Example
//
//  Created by 周健平 on 2017/12/25.
//  Copyright © 2017年 ZhouJianPing. All rights reserved.
//

#import "JPTableViewController.h"
#import "JPViewController.h"

@interface JPTableViewController ()
@property (nonatomic, copy) NSArray *configures;
@end

@implementation JPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Example";
    
    UIImage *image = [UIImage imageNamed:@"Girl.jpg"];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, (40 + 30 + 30 + 10) + 50, 0);
    
    NSString *title1 = @"默认样式";
    JPImageresizerConfigure *configure1 = [JPImageresizerConfigure defaultConfigureWithResizeImage:image make:^(JPImageresizerConfigure *configure) {
        configure.jp_contentInsets(contentInsets);
    }];
    
    NSString *title2 = @"深色毛玻璃遮罩";
    JPImageresizerConfigure *configure2 = [JPImageresizerConfigure blurMaskTypeConfigureWithResizeImage:image isLight:NO make:^(JPImageresizerConfigure *configure) {
        configure.jp_contentInsets(contentInsets).jp_strokeColor([UIColor redColor]);
    }];
    
    NSString *title3 = @"浅色毛玻璃遮罩";
    JPImageresizerConfigure *configure3 = [JPImageresizerConfigure blurMaskTypeConfigureWithResizeImage:image isLight:YES make:^(JPImageresizerConfigure *configure) {
        configure.jp_contentInsets(contentInsets).jp_strokeColor([UIColor blueColor]).jp_resizeImage([UIImage imageNamed:@"Lotus.jpg"]);
    }];
    
    NSString *title4 = @"其他样式";
    JPImageresizerConfigure *configure4 = [JPImageresizerConfigure defaultConfigureWithResizeImage:image make:^(JPImageresizerConfigure *configure) {
        CGFloat statusBarH = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat bottomHeight = 113; // 应该加上X的下巴高度.
        configure.jp_resizeImage([UIImage imageNamed:@"Kobe.jpg"]).
        jp_maskAlpha(0.5).
        jp_strokeColor([UIColor yellowColor]).
        jp_lineStrokeColor([UIColor blackColor]).
        jp_frameType(JPClassicFrameType).
        jp_contentInsets(UIEdgeInsetsMake(statusBarH, 38, bottomHeight, 38)).
        jp_bgColor([UIColor redColor]).
        jp_isClockwiseRotation(YES).
//        jp_viewFrame(CGRectMake(0, navH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.tabBarController.tabBar.bounds.size.height - 170.f)).
        jp_animationCurve(JPAnimationCurveEaseOut);
    }];
    
    self.configures = @[@{@"title": title1, @"configure": configure1},
                        @{@"title": title2, @"configure": configure2},
                        @{@"title": title3, @"configure": configure3},
                        @{@"title": title4, @"configure": configure4}];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.configures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *dic = self.configures[indexPath.row];
    
    cell.textLabel.text = dic[@"title"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JPViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JPViewController"];
    NSDictionary *dic = self.configures[indexPath.row];
    vc.configure = dic[@"configure"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
