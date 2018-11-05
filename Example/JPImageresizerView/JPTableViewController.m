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
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(50, 0, (40 + 30 + 30 + 10), 0);
    
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
        CGFloat navH = [UIApplication sharedApplication].statusBarFrame.size.height + 44;
        configure.jp_resizeImage([UIImage imageNamed:@"Kobe.jpg"]).
        jp_maskAlpha(0.5).
        jp_strokeColor([UIColor yellowColor]).
        jp_frameType(JPClassicFrameType).
        jp_contentInsets(contentInsets).
        jp_bgColor([UIColor redColor]).
        jp_isClockwiseRotation(YES).
        jp_viewFrame(CGRectMake(0, navH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.tabBarController.tabBar.bounds.size.height)).
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
