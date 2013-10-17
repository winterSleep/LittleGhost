//
//  NSMutableDictionary+AddNilObject.m
//  LittleGhostCore
//
//  Created by gft  on 13-6-25.
//  Copyright (c) 2013年 gft . All rights reserved.
//

#import "NSMutableDictionary+AddNilObject.h"

@implementation NSMutableDictionary (AddNilObject)

- (void)setNilObject:(NSObject *)object forKey:(NSString *)key{
    if (object) {
        [self setObject:object forKey:key];
    }else{
        [self setObject:@"" forKey:key];
    }
}

- (void)setInt:(NSInteger)object forKey:(NSString *)key{
    NSString *objectStr = [NSString stringWithFormat:@"%i", object];
    [self setObject:objectStr forKey:key];
}

@end
