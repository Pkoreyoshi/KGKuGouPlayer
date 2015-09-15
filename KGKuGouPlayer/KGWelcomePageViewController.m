//
//  KGWelcomePageViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGWelcomePageViewController.h"
#import "KGHomePageViewController.h"

#define kstartButtonCenterYRatio 470.f/667.f
#define kPageControlCenterYRatio 617.f/667.f
@interface KGWelcomePageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrowView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation KGWelcomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //ScrowView填充屏幕
    _scrowView.frame=[UIScreen mainScreen].bounds;
    
    //让pageControl处于屏幕的637.f/667.f比例的位置
    _pageControl.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, kPageControlCenterYRatio*[UIScreen mainScreen].bounds.size.height);
    
   //设置ScrowView 包括显示的图片以及contentSize等
    [self setupScrowView];
    //设置pageControll的数量
    _pageControl.numberOfPages=5;
    _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
}

#pragma mark 设置ScrowView 包括显示的图片以及contentSize等
-(void)setupScrowView{
    for (int i=0; i<5; i++) {
        UIImageView*imageView=[[UIImageView alloc]init];
        NSString* imageName=[NSString stringWithFormat:@"introduction_%i",i+1];
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.frame=CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        //添加开启音乐之旅的按钮
        if (i==4) {
            [self addStartButton:imageView];
        }
       
        [_scrowView addSubview:imageView];
    }
    _scrowView.contentSize=CGSizeMake(5*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    _scrowView.pagingEnabled = YES;
    
    _scrowView.bounces=NO;

}
#pragma mark 添加开启音乐之旅的按钮
-(void)addStartButton:(UIImageView*)imageView{
    
    //父控件要接受相应事件，子控件才能接受相应事件
    imageView.userInteractionEnabled = YES;
    
    UIButton*startButton=[[UIButton alloc]init];
//    startButton.frame=CGRectMake(121.5f, 470.f, 122.f, 32.f);
    startButton.bounds=CGRectMake(0, 0, 122.f, 32.f);
    startButton.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5,[UIScreen mainScreen].bounds.size.height*kstartButtonCenterYRatio);
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_nomal"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_press"] forState:UIControlStateHighlighted];
    [imageView addSubview:startButton];
    
    [startButton addTarget:self action:@selector(startMusicChip:) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark 开启音乐之旅
-(void)startMusicChip:(UIButton*)sender{

    //NSLog(@"logon!");
    //直接将主页设置为window的rootViewController 这样就不会返回欢迎页

    UIStoryboard*storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
   KGHomePageViewController*homeVC = [storyBoard instantiateViewControllerWithIdentifier:@"homePage"];
    [UIApplication sharedApplication].keyWindow.rootViewController=homeVC;
}
-(BOOL)prefersStatusBarHidden{
    return YES;

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger number = (NSInteger)_scrowView.contentOffset.x/_scrowView.frame.size.width;
    _pageControl.currentPage = number;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
