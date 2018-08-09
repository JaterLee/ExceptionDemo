//
//  ViewController.m
//  NSExceptionDemo
//
//  Created by Jater on 2018/8/9.
//  Copyright © 2018年 Jater. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     今天看了Masonry的源码 发现了
     @throw [NSException exceptionWithName:NSInternalInconsistencyException \
     reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
     userInfo:nil]
     
     发现很陌生啊这个东西,打开了google,了解一下 NSException
     */
    
    //simple usage
    [self simpleUsage];
    
    /*
     实用技巧
     
     1.封装一套SDK, 若要提示哪里出错,那么就可以使用NSException.就像上面NSException的基本用法中的代码一样
     
     2.可以用来捕获异常,防止程序的崩溃.当你意识到某段代码可能存在奔溃的危险, 那么你就可以通过捕获异常来防止程序的崩溃
     [self captureException];
     
     3.最最实用的一个技术点就是利用 分类(category) + runtime + 异常的捕获 来防止 foundation一些常用方法使用不当而导致的崩溃  其原理就是利用category runtime 来交换两个方法 并且在方法中捕获异常进行相应的处理
     
     */
    [self avoidCrash];
    
}

- (void)simpleUsage {
    //异常的名称
    NSString *exceptionName = @"自定义异常";
    //异常的原因
    NSString *exceptionReason = @"程序crash了";
    //异常的信息
    NSDictionary *exceptionUserInfo = nil;
    
    NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:exceptionUserInfo];
    
    NSInteger a = 1;
    
    if (a < 10) {
        //抛异常
        //NSExceptionDemo[38500:2967332] *** Terminating app due to uncaught exception '自定义异常', reason: '程序crash了'
//                @throw exception;
    }
}

- (void)captureException {
    NSString *nilStr = nil;
    NSMutableArray *arrayM = [NSMutableArray array];
    
    @try {
        //如果@try中的代码会导致程序崩溃 就会来到 @catch
        
        //将一个nil插入到可变数组中, 这行代码肯定有问题
        [arrayM addObject:nilStr];
    }
    @catch (NSException *exception) {
        //如果@try中的代码有问题(导致崩溃) 就会来到@catch
        //在这里你可以进行相应的处理操作
        //如果你要抛出异常(让程序崩溃), 就写上@throw exception
        NSLog(@"异常");
        
        //exception -> *** -[__NSArrayM insertObject:atIndex:]: object cannot be nil
    }
    @finally {
        //@finally中的代码是一定会执行的
        NSLog(@"finally");
    }
}

- (void)avoidCrash {
    NSMutableArray *tempArr = [NSMutableArray array];
    [tempArr addObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
