//
//  NSMutableDictionary+AddNilObject.h
//  LittleGhostCore
//
//  Created by gft  on 13-6-25.
//  Copyright (c) 2013年 gft . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (AddNilObject)

- (void)setNilObject:(NSObject *)object forKey:(NSString *)key;
- (void)setInt:(NSInteger)object forKey:(NSString *)key;

@end
