//
//  ViewController.m
//  All-test
//
//  Created by Soundnet on 16/9/22.
//  Copyright © 2016年 soundnet. All rights reserved.
//

#import "ViewController.h"
#import "LewPopupViewController.h"
#import "PopupView.h"
#import "VCFloatingActionButton.h"

#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                  // 屏幕宽度
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)                 // 屏幕长度


@interface ViewController ()<floatMenuDelegate>

@property (nonatomic, strong) CAReplicatorLayer *loveLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //我就这样子改
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10,200, self.view.bounds.size.width, 100)];
    label3.backgroundColor = [UIColor redColor];
    label3.text =@"噜啦啦噜啦啦噜啦噜啦噜，噜啦噜啦噜啦噜啦噜啦噜~~~";
    [self.view addSubview:label3];
    
    CGRect frame = label3.frame;
    frame.origin.x = -180;
    label3.frame = frame;
    [UIView beginAnimations:@"testAnimation"context:NULL];
    [UIView setAnimationDuration:8.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    frame = label3.frame;
    frame.origin.x =350;
    label3.frame = frame;
    [UIView commitAnimations];
    
  
    
    
    
    
    
    
//    self.view.backgroundColor = [UIColor orangeColor];
//    
//    NSArray *arr = @[@"1",@"2",@"3"];
//    
//    for (NSNumber *aw in arr) {
//        NSLog(@"%@",aw);
//    }
//   
//    
//  
////    PopupView *view = [PopupView defaultPopupView];
////    view.parentVC = self;
////    
////    [self lew_presentPopupView:view animation:[LewPopupViewAnimationFade new] dismissed:^{
////        NSLog(@"动画结束");
////    }];
//
//    //右下角
//    CGRect floatFrame = CGRectMake(SYS_DEVICE_WIDTH - 44 - 20, SYS_DEVICE_HEIGHT- 44 - 20 , 44, 44);
//    VCFloatingActionButton *moreBtn = [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"ic_map_genduo"] andPressedImage:[UIImage imageNamed:@"ic_map_genduo_p"] withView:self.view];
//    moreBtn.tag=0;
//    [self.view addSubview:moreBtn];
//    moreBtn.imageArray = @[@"ic_map_huodong",@"ic_map_youbao",@"ic_map_u+shop"];
//    moreBtn.labelArray = @[@"活动",@"优宝",@"U+SHOP"];
//    moreBtn.hideWhileScrolling=NO;
//    moreBtn.delegate=self;
    
    
}


#pragma mark MOREBTN Delegate
-(void) didSelectMenuOptionAtIndex:(NSInteger)row sender:(VCFloatingActionButton *)btn{
//    if(btn.tag==0){
//        MAPointAnnotation *p=[MAPointAnnotation new];
//        p.title=@"和和";
//        p.subtitle=@"哈哈";
//        p.coordinate=CLLocationCoordinate2DMake(self.mainMapView.userLocation.coordinate.latitude-0.0004, self.mainMapView.userLocation.coordinate.longitude+0.003);
//        [self.mainMapView addAnnotation:p];
//        NSLog(@"%ld",(long)row);
//    }else if (btn.tag==1){
//        
//    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
