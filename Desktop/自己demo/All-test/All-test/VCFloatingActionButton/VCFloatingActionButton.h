//
//  VCFloatingActionButton.h
//  starttrial
//
//  Created by Giridhar on 25/03/15.
//  Copyright (c) 2015 Giridhar. All rights reserved.
//  modify by zwt


#import <UIKit/UIKit.h>
@class VCFloatingActionButton;
@protocol floatMenuDelegate <NSObject>

@optional
-(void) didSelectMenuOptionAtIndex:(NSInteger)row sender:(VCFloatingActionButton *)btn;
@end


@interface VCFloatingActionButton : UIView <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic)NSArray      *imageArray,*labelArray;
@property UITableView  *menuTable;
@property UIView       *buttonView;
@property id<floatMenuDelegate> delegate;

@property (nonatomic) BOOL hideWhileScrolling;


@property (strong,nonatomic) UIView *bgView;
@property (strong,nonatomic) UIScrollView *bgScroller;
@property (strong,nonatomic) UIImageView *normalImageView,*pressedImageView;
@property (strong,nonatomic) UIWindow *mainWindow;
@property (strong,nonatomic) UIImage *pressedImage, *normalImage;
@property (strong,nonatomic) NSDictionary *menuItemSet;


@property BOOL isMenuVisible;
@property UIView *windowView;

-(id)initWithFrame:(CGRect)frame normalImage:(UIImage*)passiveImage andPressedImage:(UIImage*)activeImage withView:(UIView *)scrView;
//-(void) setupButton;


@end
