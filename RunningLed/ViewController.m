//
//  ViewController.m
//  RunningLed
//
//  Created by admin on 7/18/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _marginWidth;//> ball radius
    CGFloat _marginHeight;
    int _numberOfBallWidth;
    int _numberOfBallHeight;
    CGFloat _space; // > ball diameter
    CGFloat _ballDiameter;
    //Timer là bộ đếm thời gian, sau một chu kỳ lại gọi một hàm định sẵn.
    NSTimer* _timer; // _indicate instant variable
    int lastOnLED; // store last turn on LED
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _marginWidth = 40.0;
    _marginHeight = 80.0;
    _ballDiameter = 24.0;
    _numberOfBallWidth = 11;
    _numberOfBallHeight = 16;
    lastOnLED = -1;
    
    [self checkSizeOfApp];
    [self numberOfBallSpace];
    [self drawMatrixOfBalls:_numberOfBallWidth and:_numberOfBallHeight];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLED) userInfo:nil repeats:true];
}
- (void) runningLED{
    if (lastOnLED != -1) {
        [self turnOFFLed:lastOnLED];// nếu mà lastOnLED khác -1 thì có nghĩa là vẫn có đèn được bật và ta tắt đèn đó đi.
    }
    // LED chạy từ trái qua phải.
    /*if (lastOnLED != _numberOfBallWidth - 1) {
        lastOnLED++; // nếu mà lastOnLED khác vị trí đèn cuối cùng thì lastOnLED++
    }else{ // Reach the last LED in row, move to first LED
        lastOnLED = 0;
    }*/
    // LED chạy từ phải qua trái.
    if ((lastOnLED == _numberOfBallWidth - 1) || (lastOnLED > 0)){
        lastOnLED--;
    }else{
        lastOnLED = _numberOfBallWidth - 1;
    }
    [self turnONLed:lastOnLED];
}
- (void) turnONLed: (int) index{
    UIView* view = [self.view viewWithTag:index + 1000];
    // kiểm tra view
    if (view && [view isMemberOfClass:[UIImageView class]]) { // trả về kiểu class của UIImageView.
        UIImageView* ball = (UIImageView*) view; // ép kiểu
        ball.image = [UIImage imageNamed:@"green"];
    }
}
- (void) turnOFFLed: (int) index{
    UIView* view = [self.view viewWithTag:index + 1000];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"gray"];
    }
}

- (void) placeGrayBallAtX: (CGFloat) x
                     andY: (CGFloat) y
                  withTag: (int)tag
{
    UIImageView* ball = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gray"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
    
    //NSLog(@"w = %.0f, h = %.0f", ball.bounds.size.width, ball.bounds.size.height );
}

- (void) checkSizeOfApp {
    CGSize size = self.view.bounds.size;
    NSLog(@"width = %.0f, height = %.0f", size.width, size.height);
}
- (CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnown: (int) n {
    return (self.view.bounds.size.width - 2 * _marginWidth) / (n - 1);
}
- (CGFloat) spaceBetweenBallCenterHeight: (int) n {
    return (self.view.bounds.size.height - 2 * _marginHeight) / (n - 1);
}
- (void) numberOfBallSpace {
    bool stop = false;
    int n = 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown: n];
        if (space < _ballDiameter) {
            stop = true;
        }else{
            NSLog(@"Number of ball %d, space between ball center %.0f",n ,space);
        }
        n++;
    }
}
- (void) drawMatrixOfBalls: (int) numberBallWidth and: (int)numberBallHeight{
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown:numberBallWidth];
    //CGFloat space1 = [self spaceBetweenBallCenterHeight:numberBallHeight];
    for (int i = 0; i < numberBallWidth; i++) {
        //for (int j = 0; j < numberBallHeight; j++) {
        //for (int j = 0; j < numberBallHeight; j++) {
        [self placeGrayBallAtX:_marginWidth + i * space
                          andY: 140
                       withTag:i + 1000];
        //}
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
