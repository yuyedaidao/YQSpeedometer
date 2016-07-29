//
//  YQSpeedometer.h
//  YQSpeedometer
//
//  Created by Wang on 16/7/29.
//  Copyright © 2016年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface YQSpeedometer : UIView
@property (assign, nonatomic) IBInspectable CGFloat lineWidth;
/**
 *  最高时速 默认60公里每小时
 */
@property (assign, nonatomic) IBInspectable CGFloat maxSpeed;
@property (assign, nonatomic) IBInspectable CGFloat speed;

/**
 *  设置渐变色 //TODO:渐变色设置方式需要优化
 */
@property (strong, nonatomic) NSArray<UIColor *> *gradientColors;
@end
