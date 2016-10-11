//
//  ViewController.m
//  XYWaterProgress
//
//  Created by cyp on 16/1/15.
//  Copyright (c) 2016年 cyp. All rights reserved.
//

#import "ViewController.h"
#import "XYWaterWaveView.h"

@interface ViewController ()
{
    XYWaterWaveView* waterWaveView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    waterWaveView = [[XYWaterWaveView alloc]initWithFrame:self.view.bounds];
    waterWaveView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:waterWaveView];
    [waterWaveView startWave];
    
    //振幅
    UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 60, 40)];
    label1.text = @"振幅";
    [self.view addSubview:label1];
    UISlider* slider1 = [[UISlider alloc]initWithFrame:CGRectMake(40, 20, 280, 40)];
    slider1.minimumValue = 20.0;
    slider1.maximumValue = 40.0;
    slider1.value = 30;
    [slider1 addTarget:self action:@selector(slider1:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider1];
    //周期
    UILabel* label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 60, 40)];
    label2.text = @"周期";
    [self.view addSubview:label2];
    UISlider* slider2 = [[UISlider alloc]initWithFrame:CGRectMake(40, 80, 280, 40)];
    slider2.minimumValue = 100.0;
    slider2.maximumValue = 300.0;
    slider2.value = 200;
    [slider2 addTarget:self action:@selector(slider2:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider2];
    //速度
    UILabel* label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 60, 40)];
    label3.text = @"速度";
    [self.view addSubview:label3];
    UISlider* slider3 = [[UISlider alloc]initWithFrame:CGRectMake(40, 140, 280, 40)];
    slider3.minimumValue = 0.1f;
    slider3.maximumValue = 0.3f;
    slider3.value = 0.2f;
    [slider3 addTarget:self action:@selector(slider3:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider3];
    //高度
    UILabel* label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, 60, 40)];
    label4.text = @"高度";
    [self.view addSubview:label4];
    UISlider* slider4 = [[UISlider alloc]initWithFrame:CGRectMake(40, 200, 280, 40)];
    slider4.minimumValue = 0;
    slider4.maximumValue = self.view.frame.size.height;
    slider4.value = 300;
    [slider4 addTarget:self action:@selector(slider4:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider4];
}
- (void)slider1:(UISlider *)slider{
    waterWaveView.waveAmplitude = slider.value;
}
- (void)slider2:(UISlider *)slider{
    waterWaveView.waveCycle = slider.value;
}
- (void)slider3:(UISlider *)slider{
    waterWaveView.waveSpeed = slider.value;
}
- (void)slider4:(UISlider *)slider{
    waterWaveView.waterWaveHeight = slider.value;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
