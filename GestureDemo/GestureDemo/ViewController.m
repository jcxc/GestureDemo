//
//  ViewController.m
//  GestureDemo
//
//  Created by Apple on 16/11/24.
//  Copyright © 2016年 nova. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *myView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UILongPressGestureRecognizer *longGesture;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic, strong) UIRotationGestureRecognizer *rotationGesture;

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgeGesture;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _myView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    _myView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_myView];
    
    //1.单击手势
//    [self addTapGesture];
    
    //2.拖动手势
//    [self addPanGesture];
    
    //3.轻扫手势
//    [self addSwipeGesture];
    
    //4.长按手势
//    [self addLongGesture];
    
    //5.缩放手势
//    [self addPinchGesture];
    
    //6.旋转手势
//    [self addRotationGesture];
    
    //7.边缘手势
    [self addScreenEdgeGesture];
}

#pragma mark - tap

- (void)addTapGesture
{
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    _tapGesture.numberOfTouchesRequired = 1;
    _tapGesture.numberOfTapsRequired = 2;
    [_myView addGestureRecognizer:_tapGesture];
}

- (void)tapAction:(UITapGestureRecognizer *)gesture
{
    [self alertWithMessage:@"Tap Gesure"];
}

#pragma mark - pan

- (void)addPanGesture
{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [_myView addGestureRecognizer:_panGesture];
}

- (void)panAction:(UIPanGestureRecognizer *)gesture
{
    CGPoint transPoint = [gesture translationInView:self.view];
    NSLog(@"拖动的偏移量是－－－%@", NSStringFromCGPoint(transPoint));
    _myView.center = CGPointMake(_myView.center.x + transPoint.x, _myView.center.y + transPoint.y);
    [gesture setTranslation:CGPointZero inView:self.view];
}

#pragma mark - swipe

- (void)addSwipeGesture
{
    _swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    _swipeGesture.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [_myView addGestureRecognizer:_swipeGesture];
}

- (void)swipeAction:(UISwipeGestureRecognizer *)gesture
{
    [self alertWithMessage:@"Swipe Gesture"];
}

#pragma mark - Long presee

- (void)addLongGesture
{
    _longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//    _longGesture.minimumPressDuration = 3;
//    _longGesture.allowableMovement = 100;
    [_myView addGestureRecognizer:_longGesture];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        [self alertWithMessage:@"Long Press"];
    }
}

#pragma mark - pinch

- (void)addPinchGesture
{
    _pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [_myView addGestureRecognizer:_pinchGesture];
}

- (void)pinchAction:(UIPinchGestureRecognizer *)gesture
{
    _myView.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
}

#pragma mark - rotation

- (void)addRotationGesture
{
    _rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    [_myView addGestureRecognizer:_rotationGesture];
}

- (void)rotationAction:(UIRotationGestureRecognizer *)gesture
{
    _myView.transform = CGAffineTransformMakeRotation(gesture.rotation);
}

#pragma mark - screen edge

- (void)addScreenEdgeGesture
{
    _edgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgeAction:)];
    _edgeGesture.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:_edgeGesture];
}

- (void)edgeAction:(UIScreenEdgePanGestureRecognizer *)gesture
{
    CGPoint transPoint = [gesture translationInView:self.view];
    _myView.center = CGPointMake(_myView.center.x - transPoint.x, _myView.center.y);
    
    [gesture setTranslation:CGPointZero inView:self.view];
}

#pragma mark - Public Method

- (void)alertWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press
{
    return YES;
}

@end
