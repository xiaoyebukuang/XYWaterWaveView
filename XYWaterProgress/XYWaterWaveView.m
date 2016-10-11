//
//  XYWaterWaveView.m
//  XYWaterProgress
//
//  Created by cyp on 16/1/15.
//  Copyright (c) 2016年 cyp. All rights reserved.
//

#import "XYWaterWaveView.h"
@interface XYWaterWaveView()
{
    CGFloat _height;
    CGFloat _width;
}
/**
 *  波纹偏移
 */
@property (nonatomic ,assign) CGFloat offsetX;
/**
 *  波纹频率 
 */
@property (nonatomic ,assign) CGFloat waveRate;
/**
 *  定时器
 */
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
/**
 *  波纹图层
 */
@property (nonatomic, strong) CAShapeLayer *waveLayer;
/**
 *  背景图层
 */
@property (nonatomic, strong) CAShapeLayer *backLayer;
/**
 *  介绍
 */
@property (nonatomic, strong) CATextLayer *textLayer;
@end
@implementation XYWaterWaveView
#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}
- (void)initData{
    /**
     Asin（rt + x）+ h
     A：waveAmplitude
     r：waveRate
     x：offsetX
     */
    //振幅
    self.waveAmplitude = 30.0f;
    //周期
    self.waveCycle = 200.0f;
    //频率
    self.waveRate = 2*M_PI/self.waveCycle;
    //偏移
    self.offsetX = 0.0f;
    //高度
    self.waterWaveHeight = 300.0f;
    //速度
    self.waveSpeed = 0.2f;
    //颜色
    self.waveColor = [UIColor redColor];
    _height = self.frame.size.height;
    _width = self.frame.size.width;
}
#pragma mark - set
- (void)setWaveAmplitude:(CGFloat)waveAmplitude{
    _waveAmplitude = waveAmplitude;
}
- (void)setWaveCycle:(CGFloat)waveCycle{
    _waveCycle = waveCycle;
    _waveRate = 2*M_PI/_waveCycle;
}
- (void)setWaterWaveHeight:(CGFloat)waterWaveHeight{
    _waterWaveHeight = waterWaveHeight;
    NSString *text = [NSString stringWithFormat:@"%.2f%@",_waterWaveHeight/_height*100,@"%"];
    _textLayer.string = text;
}
- (void)setWaveSpeed:(CGFloat)waveSpeed{
    _waveSpeed = waveSpeed;
}

#pragma mark -- 开始
- (void)startWave{
    if (_waveDisplaylink) {
        return;
    }
    if (self.waveLayer == nil) {
        // 创建第一个波浪Layer
        _waveLayer = [CAShapeLayer layer];
        _waveLayer.fillColor = self.waveColor.CGColor;
        [self.layer addSublayer:_waveLayer];
    }
    if (self.backLayer == nil) {
        _backLayer = [CAShapeLayer layer];
        _backLayer.frame = self.bounds;
        _backLayer.fillColor = [UIColor yellowColor].CGColor;
        _backLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:_backLayer];
    }
    if (self.textLayer == nil) {
        _textLayer = [CATextLayer layer];
        _textLayer.foregroundColor = [UIColor blackColor].CGColor;
        _textLayer.alignmentMode =kCAAlignmentJustified;
        _textLayer.wrapped =YES;
        _textLayer.frame = CGRectMake((_width - 150)/2, (_height - 40)/2, 150, 40);
        UIFont *font = [UIFont systemFontOfSize:40];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef =CGFontCreateWithFontName(fontName);
        _textLayer.font = fontRef;
        _textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        NSString *text = [NSString stringWithFormat:@"%.2f%@",_waterWaveHeight/_height*100,@"%"];
        _textLayer.string = text;
        _textLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:_textLayer];
        [_backLayer setMask:_textLayer];
    }
    // 启动定时调用
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)getCurrentWave:(CADisplayLink *)dicplayLink{
    // 波浪位移
    self.offsetX += self.waveSpeed;
    if (self.waterWaveHeight > _height - self.waveAmplitude) {
        self.waterWaveHeight = _height - self.waveAmplitude;
    }
    [self setCurrentWaveLayerPath];
}
- (void)setCurrentWaveLayerPath{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat currentWavePointY = _height - self.waterWaveHeight;
    CGPathMoveToPoint(path, nil, 0, currentWavePointY);
    for (float x = 0.0f; x <= _width ; x++) {
        // 正弦波浪公式
        CGFloat y = self.waveAmplitude * sin(self.waveRate * x + self.offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, _width, _height);
    CGPathAddLineToPoint(path, nil, 0, _height);
    CGPathCloseSubpath(path);
    self.waveLayer.path = path;
    CGMutablePathRef backPath = CGPathCreateMutableCopy(path);
    self.backLayer.path = backPath;
    CGPathRelease(backPath);
    CGPathRelease(path);
}
#pragma mark -- 停止
- (void)reset
{
    [self stopWave];
    [_waveLayer removeFromSuperlayer];
    _waveLayer = nil;
}
- (void)stopWave{
    [_waveDisplaylink invalidate];
    _waveDisplaylink = nil;
}
- (void)dealloc{
    [self reset];
}
@end
