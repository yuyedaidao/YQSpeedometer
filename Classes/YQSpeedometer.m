//
//  YQSpeedometer.m
//  YQSpeedometer
//
//  Created by Wang on 16/7/29.
//  Copyright © 2016年 Wang. All rights reserved.
//

#import "YQSpeedometer.h"

@interface YQSpeedometer () {
    CGFloat  R_Rate;
}
//@property (strong, nonatomic) CAShapeLayer *bottomLayer;
@property (strong, nonatomic) CAShapeLayer *maskLayer;
@property (strong, nonatomic) CAGradientLayer *leftLayer;
@property (strong, nonatomic) CAGradientLayer *rightLayer;
@end

@implementation YQSpeedometer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit {
    R_Rate = sqrt(2) / 2 + 1;
    _lineWidth = 8;
    _maxSpeed = 60;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat side = MIN(rect.size.width, rect.size.height);
    CGFloat radius = floor((side - _lineWidth - _lineWidth) / R_Rate);
    CGContextRef cont = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(cont, _lineWidth);
    CGContextSetLineCap(cont, kCGLineCapButt);
    CGFloat lengths[] = {6,6};
    CGContextSetLineDash(cont, 0, lengths, 2);
    CGContextAddArc(cont, CGRectGetMidX(rect),  radius + _lineWidth, radius, M_PI_4 * 3, M_PI_4, 0);
    CGContextStrokePath(cont);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.leftLayer.frame = self.bounds;
    self.rightLayer.frame = CGRectMake(CGRectGetMidX(self.bounds), 0, CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds));
    self.maskLayer.frame = self.bounds;
}
#pragma mark set&get
- (void)setSpeed:(CGFloat)speed {
    if (_speed != speed) {
        _speed = MIN(speed, _maxSpeed);
        self.maskLayer.strokeEnd = speed / _maxSpeed;
    }
}

- (void)setGradientColors:(NSArray<UIColor *> *)gradientColors {
    NSAssert(gradientColors.count % 2 == 1, @"渐变色颜色个数请设置奇数个");
    if (_gradientColors != gradientColors) {
        _gradientColors = gradientColors;
        if (_maskLayer) {
            [self updateGradientColors:gradientColors];
        }
    }
}
- (void)updateGradientColors:(NSArray<UIColor *> *)gradientColors {
    NSInteger mid = gradientColors.count/2;
    NSMutableArray *leftColorArray = @[].mutableCopy;
    for (NSInteger i = mid; i >= 0; i--) {
        [leftColorArray addObject:(__bridge id)gradientColors[i].CGColor];
    }
    NSMutableArray *rightColorArray = @[].mutableCopy;
    for (NSInteger i = mid; i < gradientColors.count; i++) {
        [rightColorArray addObject:(__bridge id)gradientColors[i].CGColor];
    }
    self.leftLayer.colors = leftColorArray;
    self.rightLayer.colors = rightColorArray;
}
- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _leftLayer = [CAGradientLayer layer];
        _leftLayer.frame = self.bounds;
//        _leftLayer.startPoint = CGPointMake(0.5, 0.2);
//        _leftLayer.endPoint = CGPointMake(0.5, 0.5);
        [self.layer addSublayer:_leftLayer];
        _rightLayer = [CAGradientLayer layer];
        _rightLayer.frame = CGRectMake(CGRectGetMidX(self.bounds), 0, CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds));
//        _rightLayer.startPoint = CGPointMake(0.5, 0.2);
//        _rightLayer.endPoint = CGPointMake(0.5, 0.5);
        [_leftLayer addSublayer:_rightLayer];
        
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.frame = self.bounds;
        _maskLayer.lineWidth = _lineWidth;
        _maskLayer.lineCap = kCALineCapButt;
        _maskLayer.lineDashPhase = 0;
        _maskLayer.lineDashPattern = @[@(6),@(6)];
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.strokeColor = [UIColor orangeColor].CGColor;
        CGFloat side = MIN(self.bounds.size.width, self.bounds.size.height);
        CGFloat radius = floor((side - _lineWidth - _lineWidth) / R_Rate);
        _maskLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), radius + _lineWidth) radius:radius startAngle:M_PI_4 * 3 endAngle:M_PI_4 clockwise:1].CGPath;
        _leftLayer.mask = _maskLayer;
        if (self.gradientColors.count) {
            [self updateGradientColors:_gradientColors];
        }
    }
    return _maskLayer;
}


@end
