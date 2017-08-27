//
//  NSArray+WZX.m
//  WZXArchitecture
//
//  Created by wuzhuoxuan on 2017/7/21.
//  Copyright © 2017年 wuzhuoxuan. All rights reserved.
//

#import "NSArray+WZX.h"
#import <objc/runtime.h>

@implementation NSArray (WZX)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 替换不可变数组中的方法
        [self exchangeOriginalMethod:class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:)) withNewMethod:class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(wzx_objectAtIndex:))];
        // 替换可变数组中的方法
        [self exchangeOriginalMethod:class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:)) withNewMethod:class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(wzx_mutableObjectAtIndex:))];
        [self exchangeOriginalMethod:class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(replaceObjectAtIndex:withObject:)) withNewMethod:class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(wzx_replaceObjectAtIndex:withObject:))];
        [self exchangeOriginalMethod:class_getInstanceMethod(objc_getClass("__NSArrayM"),@selector(addObject:)) withNewMethod:class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(wzx_addObject:))];
        [self exchangeOriginalMethod:class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:)) withNewMethod:class_getInstanceMethod(objc_getClass("__NSArrayM"),@selector(wzx_insertObject:atIndex:))];
        
    });
    
}

- (id)wzx_objectAtIndex:(NSUInteger)index{
    
    if(index > self.count - 1 || !self.count){
        @try{
            return [self wzx_objectAtIndex:index];
        } @catch(NSException *exception){
            // _throwOutException  抛出异常
            NSLog(@"-------- %s 数组越界 %s -------\n",class_getName(self.class),__func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally{
            
        }
    }else{
        return [self wzx_objectAtIndex:index];
    }
}

- (id)wzx_mutableObjectAtIndex:(NSUInteger)index{
    if(index > self.count -1 || !self.count){
        @try{
            return [self wzx_mutableObjectAtIndex:index];
        } @catch (NSException *exception){
            NSLog(@"-------- %s 可变数组越界 %s -------\n",class_getName(self.class),__func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally{
            
        }
    }else{
        return [self wzx_mutableObjectAtIndex:index];
    }
}

- (void)wzx_addObject:(id)anObject
{
    if (!anObject)
    {
        NSLog(@"[%@ %@], NIL object.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    [self wzx_addObject:anObject];
}

- (void)wzx_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index >= self.count)
    {
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
                NSStringFromClass([self class]),
                NSStringFromSelector(_cmd),
                (unsigned long)index,
                MAX((unsigned long)self.count - 1, 0));
        return;
    }
    
    if (!anObject)
    {
        NSLog(@"[%@ %@] NIL object.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    
    [self wzx_replaceObjectAtIndex:index withObject:anObject];
}


- (void)wzx_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (index > self.count)
    {
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
                NSStringFromClass([self class]),
                NSStringFromSelector(_cmd),
                (unsigned long)index,
                MAX((unsigned long)self.count - 1, 0));
        return;
    }
    
    if (!anObject)
    {
        NSLog(@"[%@ %@] NIL object.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    
    [self wzx_insertObject:anObject atIndex:index];
}

+ (void)exchangeOriginalMethod:(Method)originalMethod withNewMethod:(Method)newMethod
{
    method_exchangeImplementations(originalMethod, newMethod);
}

@end
