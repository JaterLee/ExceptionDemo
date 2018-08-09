//
//  NSMutableArray+Extension.m
//  NSExceptionDemo
//
//  Created by Jater on 2018/8/9.
//  Copyright © 2018年 Jater. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Extension)

+ (void)load {
    Class class = NSClassFromString(@"__NSArrayM");
    Method originalMethod = class_getInstanceMethod(class, @selector(addObject:));
    Method avoidCrashMethod = class_getInstanceMethod(self, @selector(exceptionAddObject:));
    method_exchangeImplementations(originalMethod, avoidCrashMethod);
}

- (void)exceptionAddObject:(id)object {
    @try {
        [self exceptionAddObject:object];
    }
    @catch (NSException *exception) {
        NSLog(@"异常名称:%@  异常原因:%@", exception.name, exception.reason);
    }
    @finally {
        //这个调用的也太频繁了....
    }
}


@end
