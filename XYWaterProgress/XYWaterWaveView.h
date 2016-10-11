//
//  XYWaterWaveView.h
//  XYWaterProgress
//
//  Created by cyp on 16/1/15.
//  Copyright (c) 2016年 cyp. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XYWaterWaveView : UIView
/**
 *  波纹振幅 默认30
 */
@property (nonatomic ,assign) CGFloat waveAmplitude;
/**
 *  振幅周期 默认200
 */
@property (nonatomic ,assign) CGFloat waveCycle;
/**
 *  波纹速度 默认 0.2
 */
@property (nonatomic ,assign) CGFloat waveSpeed;
/**
 *  波纹高度 默认为300
 */
@property (nonatomic ,assign) CGFloat waterWaveHeight;
/**
 *  波纹颜色 默认红色
 */
@property (nonatomic, strong) UIColor* waveColor;
/**
 *  开始
 */
- (void)startWave;
@end
