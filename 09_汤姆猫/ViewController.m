//
//  ViewController.m
//  09_汤姆猫
//
//  Created by APPLE on 15/11/8.
//  Copyright (c) 2015年 big nerd ranch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak,nonatomic) IBOutlet  UIImageView *tomcat;

@end

@implementation ViewController

/*关于图形的实例化
 
 imageNamed：系统推荐的，图像实例化之后的释放由系统来负责
 如果要自己释放图片，不能使用该方法
 使用imageWithContentsOfFile，必须放在supportFiles里
 如果放在xcassets中，则不能使用该方法。
 
 xcassets：经常使用的素材，button等背景图片
 supportFiles:不经常使用的图片，并且比较大的
 
 */


- (IBAction)eat
{
    
    [self AnimationWithName:@"eat" AndCount:40];

}

- (IBAction)konckout
{
    [self AnimationWithName:@"knockout" AndCount:81];
    //传入参数，调用动画方法

}


//代码重构，需要传入的参数有两个，1、图片的数量i 2、图片的开始名字
-(void)AnimationWithName:(NSString *)name AndCount:(NSInteger)count
{
    //序列动画-顺序播放一组图片
    
    //如果正在动画，直接退出(即再调用该方法时直接退出）
    if (self.tomcat.isAnimating) {
        return;
    }
    
    
    //动画图片的数组
    NSMutableArray *arrayM=[NSMutableArray array];
    
    //添加动画播放的图片，从eat00-eat39
    for (int i=0; i<count; i++) {
        //图形名称
        
        NSString *imageName=[NSString stringWithFormat:@"%@_%02d.jpg",name,i];//%02d表示两位数，且位数不够时自动补零
        
        NSString *path=[NSBundle mainBundle] ;//imageName中已经包含扩展名
        
        NSLog(@"%@",path);
        //imageWithContentsOfFile需要全路径
        UIImage *image=[UIImage imageWithContentsOfFile:path]; //根据名称创建image对象
        [arrayM addObject:image];//依次加到array中
        
    }
    
    //设置动画数组
    self.tomcat.animationImages=arrayM;//将图片数组赋值给animationImages数组
    self.tomcat.animationRepeatCount=1; //设置重复次数为1次
    self.tomcat.animationDuration=arrayM.count*0.075;
    //根据数组的长度设置时长
    
    //开始动画
    [self.tomcat startAnimating];
    
//    //动画结束之后，清理动画数组(会导致button没有反应，还没开始就已经执行了nil）
//    self.tomcat.animationImages=nil;
    
    //延迟清理的时间
    //performSelector定义在NSObject类中，此处的self是一个viewcontroller对象
    //也可以用继承自NSObject的任何对象使用该方法，如self.tomCat为一个view对象
    //[self performSelector:@selector(clearup) withObject:nil afterDelay:self.tomcat.animationDuration];
    //在animationDuration之后清理
    
    [self.tomcat performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.tomcat.animationDuration];
    
    //调用animationImages的set方法，传一个nil的参数，即将animationImages数组置空，等同于下面的clearup方法
}

//-(void)clearup
//{
//    self.tomcat.animationImages=nil;
//    //将数组置空，释放缓存
//}
//




@end
