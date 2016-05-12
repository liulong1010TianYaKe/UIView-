//
//  ViewController.m
//  UIView+UISnapshotting
//
//  Created by long on 5/12/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    
//    [self testSnapShotting1];
    
    [self testShapShotting2];
    [self testSnapShowtting3];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -------------------
#pragma mark - UISnapshotting

- (void)testSnapShotting1{
    
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    showView.backgroundColor = [UIColor redColor];
    showView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"icon"].CGImage);
    [self.view addSubview:showView];
    // YES 立即生成一个快照  NO 暂时不知道怎么用
    UIView *snap1 = [showView snapshotViewAfterScreenUpdates:NO];
    snap1.center = self.view.center;
    snap1.bounds = CGRectMake(0, 0, 150, 150);
    [self.view addSubview:snap1];
    
    
    [snap1 drawViewHierarchyInRect:CGRectMake(0, 0, 100, 100) afterScreenUpdates:YES];
    
}



- (void)testSnapShowtting3{

    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    showView.backgroundColor = [UIColor redColor];
    showView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"icon"].CGImage);
    [self.view addSubview:showView];
    
    UIView *span3 = [self.imgView resizableSnapshotViewFromRect:CGRectMake(0, 0, 200, 100) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsMake(30, 30, 30, 30)];
    span3.center = self.view.center;
    [self.view addSubview:span3];
}
- (void)testShapShotting2{
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    showView.backgroundColor = [UIColor redColor];
    showView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"icon"].CGImage);
    [self.view addSubview:showView];
    
    
    UIView *span2 = [showView snapshotViewAfterScreenUpdates:YES];
    span2.frame = CGRectMake(100, 350, 100, 100);
    [self.view addSubview:span2];
    
    
    UIImage *image = [self imageFromView:span2];
    
    UIImageView *imgeView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
    imgeView.image = image;
    [self.view addSubview:imgeView];
}




- (UIImage *)imageFromView:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
//    UIGraphicsBeginImageContext(view.bounds.size);
   BOOL isRead =   [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];// 产生一个快照
    
    NSLog(@"spon success %@",isRead ? @"YES":@"NO");
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
