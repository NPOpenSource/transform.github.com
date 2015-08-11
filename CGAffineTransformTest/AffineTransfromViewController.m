//
//  AffineTransfromViewController.m
//  CGAffineTransformTest
//
//  Created by 温杰 on 15/8/11.
//  Copyright (c) 2015年 温杰. All rights reserved.
//

#import "AffineTransfromViewController.h"

@interface AffineTransfromViewController ()

@end

@implementation AffineTransfromViewController



-(void)createAffineTransfromView
{
    UIView * view=[[NSClassFromString(@"AFfineTransfromViewShow") alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.title = @"AffineTransfrom";
    
    
    [self createAffineTransfromView];
    
    
    
    [self PrintConst];
    
    
    // Do any additional setup after loading the view.
}

-(void)PrintConst
{
    int x=50;
    int y=50;
    int a =3;
    int b = 3;
    int c =3;
    int d =3;
    ///获取一个标准矩阵。没有变化的矩阵
    CGAffineTransform transform=  CGAffineTransformIdentity;
    NSLog(@"CGAffineTransformIdentity 数值%@" , NSStringFromCGAffineTransform(transform));
    
    ///获取一个变幻矩阵 这个函数可以平移旋转和缩放
    /* Return the transform [ a b c d tx ty ]. */
  transform=  CGAffineTransformMake(a, b, c, d,x,y);
    
    ///获取一个只做平移的矩阵
    //        t' = [ 1 0 0 1 tx ty ]
 transform=   CGAffineTransformMakeTranslation(x, y);
    
    ///获取一个缩放矩阵
    //         t' = [ sx 0 0 sy 0 0 ] 
  transform=  CGAffineTransformMakeScale(a,c);

    //获取一个旋转矩阵
    /* Return a transform which rotates by `angle' radians:
     t' = [ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ] */
  transform=  CGAffineTransformMakeRotation(3);
    
    ///验证是否是标准矩阵
  BOOL isTrue =  CGAffineTransformIsIdentity(transform);
    
    
    ///这个是矩阵之间的换算了
    /* Translate `t' by `(tx, ty)' and return the result:
     t' = [ 1 0 0 1 tx ty ] * t */
    /// 说的很明确 用只有平移的矩阵和 t 矩阵相乘 t*t' 意思是在t'的基础上做t 变幻（例如平移旋转等等）
    transform=   CGAffineTransformTranslate(transform,x,y);

    ///矩阵先缩放再transform
    /* Scale `t' by `(sx, sy)' and return the result:
     t' = [ sx 0 0 sy 0 0 ] * t */
  transform=  CGAffineTransformScale(transform,a,c);
    
    ///矩阵先旋转再transform
    /* Rotate `t' by `angle' radians and return the result:
     t' =  [ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ] * t */
    transform = CGAffineTransformRotate(transform,3);
    
    
    NSLog(@"CGAffineTransformInvert前 数值%@" , NSStringFromCGAffineTransform(transform));
    /// 获取 反转矩阵  看不出效果。做图看看  可以仔细研究下
    ///我看着就是沿着y轴做了一个对称变换 （不见得对）
    transform =   CGAffineTransformInvert(transform);
    NSLog(@"CGAffineTransformInvert后 数值%@" , NSStringFromCGAffineTransform(transform));
    
    
    ///矩阵相乘
    /* Concatenate `t2' to `t1' and return the result:
     t' = t1 * t2 */
   transform = CGAffineTransformConcat(transform,transform);

    ///判断两个矩阵是否相等
    /* Return true if `t1' and `t2' are equal, false otherwise. */
    isTrue =CGAffineTransformEqualToTransform(transform,transform);
    
    ///获取一个点矩阵变幻另一个点的位置
    /* Transform `point' by `t' and return the result:
     p' = p * t
     where p = [ x y 1 ]. */
  CGPoint point=  CGPointApplyAffineTransform(CGPointMake(30, 30), transform);
    
    ///获取一个矩形矩形变换的大小
    /* Transform `size' by `t' and return the result:
     s' = s * t
     where s = [ width height 0 ]. */
    CGSize size= CGSizeApplyAffineTransform(CGSizeMake(30, 30),transform);
    
    ///获取矩形位置变幻后的位置
     CGRect rect=CGRectApplyAffineTransform(CGRectMake(0, 0, 30, 30),transform);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
