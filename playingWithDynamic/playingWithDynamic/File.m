//
//  File.m
//  playingWithDynamic
//
//  Created by Igor Chernyshov on 16.12.2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "File.h"


@interface File()

@property (nonatomic, strong) NSMutableDictionary *fileOwner;

@end


@implementation File

@dynamic ownerName, ownerSurname;

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		_fileOwner = [NSMutableDictionary new];
		_fileOwner[@"ownerName"] = @"Igor";
		_fileOwner[@"ownerSurname"] = @"Chernyshov";
	}
	return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
	NSString *sel = NSStringFromSelector(selector);
	if ([sel rangeOfString:@"set"].location == 0) {
		return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
	} else {
		return [NSMethodSignature signatureWithObjCTypes:"@@:"];
	}
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
	NSString *key = NSStringFromSelector([invocation selector]);
	if ([key rangeOfString:@"set"].location == 0) {
		key = [[key substringWithRange:NSMakeRange(3, [key length]-4)] lowercaseString];
		NSString *obj;
		[invocation getArgument:&obj atIndex:2];
		[self.fileOwner setObject:obj forKey:key];
	} else {
		NSString *obj = [self.fileOwner objectForKey:key];
		[invocation setReturnValue:&obj];
	}
}

- (void)changeFileOwnerInDictionary
{
	self.fileOwner[@"ownerName"] = @"Somebody";
	self.fileOwner[@"ownerSurname"] = @"Else";
}

@end
