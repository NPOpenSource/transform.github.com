//
//  AFfineTransfromViewShow.m
//  CGAffineTransformTest
//
//  Created by 温杰 on 15/8/11.
//  Copyright (c) 2015年 温杰. All rights reserved.
//

#import "AFfineTransfromViewShow.h"


#define pic @"transform.jpg"
@interface AFfineTransfromViewShow()

@property (nonatomic ,strong) NSMutableArray * buttonNameArr;
@property (nonatomic ,strong) UIImageView * transfromView;
@end

@implementation AFfineTransfromViewShow



-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        [self config];
        
        [self createButtonArr];
        [self  createNormalPic];
        
        
    }
    return self;
}

-(void)config
{
    self.buttonNameArr = [NSMutableArray array];
}

-(void)createButtonArr
{
    [self.buttonNameArr addObjectsFromArray:@[@"平移",@"旋转",@"缩放",@"旋转平移缩放",@"验证标准矩阵",@"平移之后再转换",@"旋转之后再转换",@"缩放之后再转换",@"反转",@"矩阵相乘",@"矩阵相同",@"点矩阵转换",@"size矩阵转换",@"rect 矩阵转换",@"复位"]];
    for (int i=0; i<self.buttonNameArr.count; i++) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(0+i%3*110, 60+i/3*40, 100, 30);
        button.layer.borderColor=[UIColor greenColor].CGColor;
        button.titleLabel.font =[UIFont systemFontOfSize:12];
        button.layer.borderWidth = 5;
        button.tag =i;
        [button setTitle:self.buttonNameArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self addSubview:button];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchDown];
        
    }
    
}


///返回标准状态
-(void)guiwei
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transfromView.transform=CGAffineTransformIdentity;
    }];

}

-(void)donghua:(CGAffineTransform )transform
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transfromView.transform=transform;
    }];
}

///平移
-(void)pingyi
{
    [self guiwei];
    CGAffineTransform transform=CGAffineTransformMakeTranslation(40, 40);
    [self donghua:transform];
}

///旋转
-(void)xuanzhuan
{
    [self guiwei];
    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_4);
    [self donghua:transform];

}

///缩放
-(void)suofang
{
    [self guiwei];
    CGAffineTransform transform=CGAffineTransformMakeScale(.3, .3);
    [self donghua:transform];

}

-(void)allTransfomr
{
    [self guiwei];
    CGAffineTransform transform =CGAffineTransformMake(1, 0, 0, 1, 40, 40);
    [self donghua:transform];
}

///判断是否是标准矩阵
-(void)isbiaoZhun
{
    bool isRight=CGAffineTransformIsIdentity(self.transfromView.transform);
    NSString * str=@"不是标准矩阵";
    if (isRight) {
        str=@"是标准矩阵";
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)transfromAfterpingyin
{
    [self guiwei];
    
    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_4);
    transform = CGAffineTransformTranslate(transform, 40, 50);
    [self donghua:transform];

    
}

-(void)transfromAfterXuanZhuan
{

    [self guiwei];

    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_4);
    transform = CGAffineTransformRotate(transform, M_PI_2);
    [self donghua:transform];
}


-(void)transfromAfterSuoFang
{
    [self guiwei];
    
    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_4);
    
    transform = CGAffineTransformScale(transform, .3, .3) ;
    [self donghua:transform];
}


-(void)fanZhuan
{
    [self guiwei];
    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_4);
    transform = CGAffineTransformScale(transform, .8, .8) ;
    transform =CGAffineTransformTranslate(transform, 50, 50);
//    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_2);
    NSLog(@"%@",NSStringFromCGAffineTransform(transform));

    transform = CGAffineTransformInvert(transform) ;
    NSLog(@"%@",NSStringFromCGAffineTransform(transform));

    [self donghua:transform];
}


///矩阵相互做乘法。意思是变换相加
-(void)juzhenXiangCheng
{
    [self guiwei];
    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_4);

 transform=   CGAffineTransformConcat(transform,transform);
    [self donghua:transform];

}

///矩阵相等判断
-(void)juZhenEqual
{
    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_4);

   bool isRight= CGAffineTransformEqualToTransform(transform,self.transfromView.transform);
    NSString * str=@"矩阵不相同";
    if (isRight) {
        str=@"矩阵相同";
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)CGPointTransform
{
    CGPoint point =CGPointMake(100, 100);
    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_2);
  CGPoint  point1 =CGPointApplyAffineTransform(point, transform);
    NSString *str=[NSString stringWithFormat:@"转换前%@  \n转换后%@",NSStringFromCGPoint(point),NSStringFromCGPoint(point1)];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

-(void)CGSizeTransform
{
    CGSize point =CGSizeMake(100, 100);
    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_2);
    CGSize  point1 =CGSizeApplyAffineTransform(point, transform);
    NSString *str=[NSString stringWithFormat:@"转换前%@  \n转换后%@",NSStringFromCGSize(point),NSStringFromCGSize(point1)];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)CGrestTransform
{
    CGRect  point =CGRectMake(100, 100, 100, 100);
    CGAffineTransform transform=CGAffineTransformMakeRotation(M_PI_2);
    CGRect  point1 =CGRectApplyAffineTransform(point, transform);
    NSString *str=[NSString stringWithFormat:@"转换前%@  \n转换后%@",NSStringFromCGRect(point),NSStringFromCGRect(point1)];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];

}

-(void)buttonEvent:(UIButton *)button
{
    switch (button.tag) {
        case 0:
        {
            ///平移
            [self pingyi];
            
        }
            break;
            case 1:
        {
            [self xuanzhuan];
        }
            break;
            case 2:
        {
            [self suofang];
        }
            break;
            case 3:
        {
            [self allTransfomr];
        }
            break;
            case 4:
        {
            [self isbiaoZhun];
        }
            break;
            case 5:
        {
            [self transfromAfterpingyin];
        }
            break;
            case 6:
        {
            [self transfromAfterXuanZhuan];
        }
            break;
            case 7:
        {
            [self transfromAfterSuoFang];
        }
            break;
            case 8:
        {
            [self fanZhuan];
        }
            break;
            case 9:
        {
            [self juzhenXiangCheng];
        }
            break;
            
            case 10:
        {
            [self juZhenEqual];
        }
            break;
            
            case 11:
        {
            [self CGPointTransform];
        }
            break;
            case 12:
        {
            [self CGSizeTransform];
        }
            break;
            case 13:
        {
            [self CGrestTransform];
        }break  ;
            case 14:
        {
            [self guiwei];
            break;
        }
        default:
            break;
    }
}

-(void)createNormalPic
{
    UIImageView * imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 150)];
    imageView1.image =[UIImage imageNamed:pic];
    imageView1.backgroundColor =[UIColor greenColor];
    imageView1.center =self.center;
    [self addSubview:imageView1];
    
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 150)];
    imageView.image =[UIImage imageNamed:pic];
    imageView.backgroundColor =[UIColor greenColor];
    imageView.center =self.center;
    self.transfromView = imageView;
    [self addSubview:imageView];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
