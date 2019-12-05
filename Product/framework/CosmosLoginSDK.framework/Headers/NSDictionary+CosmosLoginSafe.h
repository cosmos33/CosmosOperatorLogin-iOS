//
//  NSDictionary+XESafe.h
//  XEPinchFace
//
//  Created by MOMO on 2019/11/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (CosmosLoginSafe)

- (id)cos_login_objectForKey:(NSString *)aKey defaultValue:(id)value;
- (NSString *)cos_login_stringForKey:(NSString *)aKey defaultValue:(NSString *)value;
- (NSArray *)cos_login_arrayForKey:(NSString *)aKey defaultValue:(NSArray *)value;
- (NSDictionary *)cos_login_dictionaryForKey:(NSString *)aKey defaultValue:(NSDictionary *)value;
- (NSData *)cos_login_dataForKey:(NSString *)aKey defaultValue:(NSData *)value;
- (NSUInteger)cos_login_unsignedIntegerForKey:(NSString *)aKey defaultValue:(NSUInteger)value;
- (NSInteger)cos_login_integerForKey:(NSString *)aKey defaultValue:(NSInteger)value;
- (float)cos_login_floatForKey:(NSString *)aKey defaultValue:(float)value;
- (double)cos_login_doubleForKey:(NSString *)aKey defaultValue:(double)value;
- (long long)cos_login_longLongValueForKey:(NSString *)aKey defaultValue:(long long)value;
- (BOOL)cos_login_boolForKey:(NSString *)aKey defaultValue:(BOOL)value;
- (NSDate *)cos_login_dateForKey:(NSString *)aKey defaultValue:(NSDate *)value;
- (NSNumber *)cos_login_numberForKey:(NSString *)aKey defaultValue:(NSNumber *)value;
- (int)cos_login_intForKey:(NSString *)aKey defaultValue:(int)value;

@end

NS_ASSUME_NONNULL_END
