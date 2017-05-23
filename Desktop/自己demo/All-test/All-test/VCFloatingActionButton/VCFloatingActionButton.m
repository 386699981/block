//
//  VCFloatingActionButton.m
//  starttrial
//
//  Created by Giridhar on 25/03/15.
//  Copyright (c) 2015 Giridhar. All rights reserved.
//  modify by zwt
//#import "UIView+Extension.h"
#import "VCFloatingActionButton.h"
#import "floatTableViewCell.h"
//#import "Masonry.h"

#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height

CGFloat animationTime = 0.55;
CGFloat rowHeight = 60.f;
NSInteger noOfRows = 0;
NSInteger tappedRow;
CGFloat previousOffset;
CGFloat buttonToScreenHeight;
@implementation VCFloatingActionButton

@synthesize windowView;
//@synthesize hideWhileScrolling;
@synthesize delegate;

@synthesize bgScroller;

-(void)setImageArray:(NSArray *)imageArray{
    _imageArray=imageArray;
    
    [_menuTable setFrame:CGRectMake(CGRectGetMaxX(self.frame)-_buttonView.frame.size.width, CGRectGetMaxY(self.frame)-64*imageArray.count-_buttonView.frame.size.height,64,64*imageArray.count )];
}

-(id)initWithFrame:(CGRect)frame normalImage:(UIImage*)passiveImage andPressedImage:(UIImage*)activeImage withView:(UIView*)scrView
{
    self = [super initWithFrame:frame];
    if (self)
    {
        windowView = scrView;
        _mainWindow = [UIApplication sharedApplication].keyWindow;
        _buttonView = [[UIView alloc]initWithFrame:frame];
        _buttonView.backgroundColor = [UIColor clearColor];
        _buttonView.userInteractionEnabled = YES;
        buttonToScreenHeight = SCREEN_HEIGHT - CGRectGetMaxY(self.frame);
        _menuTable = [UITableView new];
        _menuTable.scrollEnabled = NO;

        _menuTable.delegate = self;
        _menuTable.dataSource = self;
        _menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTable.backgroundColor = [UIColor clearColor];
        _menuTable.transform = CGAffineTransformMakeRotation(-M_PI); //Rotate the table
        previousOffset = scrView.frame.origin.y;
        bgScroller = (UIScrollView *)scrView;

        _pressedImage = activeImage;
        _normalImage = passiveImage;
        [self setupButton];
        
    }
    return self;
}


-(void)setHideWhileScrolling:(BOOL)hideWhileScrolling
{
    if (bgScroller!=nil)
    {
        _hideWhileScrolling = hideWhileScrolling;
        if (hideWhileScrolling)
        {
            [bgScroller addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        }
    }
}



-(void) setupButton
{
    _isMenuVisible = false;
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *buttonTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:buttonTap];
    
    
    UITapGestureRecognizer *buttonTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    
    [_buttonView addGestureRecognizer:buttonTap3];

    _normalImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _normalImageView.userInteractionEnabled = YES;
    _normalImageView.contentMode = UIViewContentModeScaleAspectFit;
    _normalImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    _normalImageView.layer.shadowRadius = 5.f;
    _normalImageView.layer.shadowOffset = CGSizeMake(-10, -10);


    
    _pressedImageView  = [[UIImageView alloc]initWithFrame:self.bounds];
    _pressedImageView.contentMode = UIViewContentModeScaleAspectFit;
    _pressedImageView.userInteractionEnabled = YES;
    
    
    _normalImageView.image = _normalImage;
    _pressedImageView.image = _pressedImage;
    [_buttonView addSubview:_pressedImageView];
    [_buttonView addSubview:_normalImageView];
    [self addSubview:_normalImageView];

}

-(void)handleTap:(id)sender //Show Menu
{

    if (_menuTable.superview==nil) {
        [windowView addSubview:_menuTable];
    }
    if (_isMenuVisible)
    {
        
        [self dismissMenu:nil];
    }
    else
    {
        [windowView addSubview:_bgView];
        [windowView addSubview:_buttonView];
        [self showMenu:nil];
    }
    _isMenuVisible  = !_isMenuVisible;
    
    
}




#pragma mark -- Animations
#pragma mark ---- button tap Animations

-(void) showMenu:(id)sender
{
    
    self.pressedImageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.pressedImageView.alpha = 0.0; //0.3
    [UIView animateWithDuration:animationTime/2 animations:^
     {
         _menuTable.alpha = 1;
//         [windowView addSubview:_menuTable];
         if (_pressedImage) {
             self.normalImageView.transform = CGAffineTransformMakeRotation(-M_PI);
             self.normalImageView.alpha = 0.0; //0.7
             
             
             self.pressedImageView.transform = CGAffineTransformIdentity;
             self.pressedImageView.alpha = 1;
         }
         
         noOfRows = _labelArray.count;
         [_menuTable reloadData];

     }
         completion:^(BOOL finished)
     {
     }];

}

-(void) dismissMenu:(id) sender

{
    [UIView animateWithDuration:animationTime/2 animations:^
     {
         _menuTable.alpha = 0;
         self.pressedImageView.alpha = 0.f;
         self.pressedImageView.transform = CGAffineTransformMakeRotation(-M_PI);
         self.normalImageView.transform = CGAffineTransformMakeRotation(0);
         self.normalImageView.alpha = 1.f;
     } completion:^(BOOL finished)
     {
         noOfRows = 0;
//         [_menuTable removeFromSuperview];
//         [_mainWindow removeFromSuperview];
         
     }];
}

#pragma mark ---- Scroll animations

-(void) showMenuDuringScroll:(BOOL) shouldShow
{
    if (_hideWhileScrolling)
    {
        
        if (!shouldShow)
        {
            [UIView animateWithDuration:animationTime animations:^
             {
                 self.transform = CGAffineTransformMakeTranslation(0, buttonToScreenHeight*6);
             } completion:nil];
        }
        else
        {
            [UIView animateWithDuration:animationTime/2 animations:^
             {
                 self.transform = CGAffineTransformIdentity;
             } completion:nil];
        }
        
    }
}


-(void) addRows
{
    NSMutableArray *ip = [[NSMutableArray alloc]init];
    for (int i = 0; i< noOfRows; i++)
    {
        [ip addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [_menuTable insertRowsAtIndexPaths:ip withRowAnimation:UITableViewRowAnimationFade];
}




#pragma mark -- Observer for scrolling
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        
        NSLog(@"%f",bgScroller.contentOffset.y);
       
        CGFloat diff = previousOffset - bgScroller.contentOffset.y;
        
        if (ABS(diff) > 15)
        {
            if (bgScroller.contentOffset.y > 0)
            {
                [self showMenuDuringScroll:(previousOffset > bgScroller.contentOffset.y)];
                previousOffset = bgScroller.contentOffset.y;
            }
            else
            {
                [self showMenuDuringScroll:YES];
            }
            
            
        }

    }
}


#pragma mark -- Tableview methods
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return noOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(floatTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    //KeyFrame animation
    
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
//    anim.fromValue = @((indexPath.row+1)*CGRectGetHeight(cell.imgView.frame)*-1);
//    anim.toValue   = @(cell.frame.origin.y);
//    anim.duration  = animationTime/2;
//    anim.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [cell.layer addAnimation:anim forKey:@"position.y"];
    
    
    
    
    double delay = (indexPath.row*indexPath.row) * 0.004;  //Quadratic time function for progressive delay


    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.95, 0.95);
    CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(0,-(indexPath.row+1)*CGRectGetHeight(cell.imgView.frame));
    cell.transform = CGAffineTransformConcat(scaleTransform, translationTransform);
    cell.alpha = 0.f;
    
    [UIView animateWithDuration:animationTime/2 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^
    {
        
        cell.transform = CGAffineTransformIdentity;
        cell.alpha = 1.f;
        
    } completion:^(BOOL finished)
    {
        
    }];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    floatTableViewCell *cell = [_menuTable dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        [_menuTable registerNib:[UINib nibWithNibName:@"floatTableViewCell" bundle:nil]forCellReuseIdentifier:identifier];
        cell = [_menuTable dequeueReusableCellWithIdentifier:identifier];
    }
    if (!cell.isFilter) {
        cell.imgView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    }else{
        cell.imgView.image=[UIImage imageNamed:@"ic_map_huodong_p"];
    }
    cell.title.text    = [_labelArray objectAtIndex:indexPath.row];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"selected CEll: %tu",indexPath.row);
    if ([delegate respondsToSelector:@selector(didSelectMenuOptionAtIndex:sender:)]) {
        [delegate didSelectMenuOptionAtIndex:indexPath.row sender:self];
    }
    floatTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//    cell.imgView.image=[UIImage imageNamed:@"ic_map_huodong_p"];
    if (cell.isFilter) {
        cell.imgView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    }else{
        cell.imgView.image=[UIImage imageNamed:@"ic_map_huodong_p"];
    }
    cell.isFilter=!cell.isFilter;
    
    
}

@end
