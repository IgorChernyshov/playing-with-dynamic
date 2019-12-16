//
//  DynamicClass.m
//  playingWithDynamic
//
//  Created by Igor Chernyshov on 16.12.2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "DynamicClass.h"
@import ObjectiveC.runtime;


Class Notepad;

NSNumber *pageGetter(id self, SEL _cmd)
{
	Ivar ivar = class_getInstanceVariable(Notepad, "_page");
	return object_getIvar(self, ivar);
}

void pageSetter(id self, SEL _cmd, NSNumber* newCount)
{
	Ivar ivar = class_getInstanceVariable(Notepad, "_page");
	id oldCount = object_getIvar(self, ivar);
	if (oldCount != newCount) object_setIvar(self, ivar, [newCount copy]);
}


@implementation DynamicClass

- (void)createDynamicClass
{
	// Creates a class at runtime

	// @interface Notepad: NSObject
	// @end
	Notepad = objc_allocateClassPair([NSObject class], "Notepad", 0);

	// @property(nonatomic, strong) NSNumber *page;
	class_addIvar(Notepad, "_page", sizeof(NSNumber *), log2(sizeof(NSNumber *)), @encode(NSNumber *));
	objc_property_attribute_t type = { "T", "@\"NSNumber\"" };
	objc_property_attribute_t backingvar = { "V", "_page" };
	objc_property_attribute_t attrs[] = { type, backingvar };
	class_addProperty(Notepad, "page", attrs, 2);
	class_addMethod(Notepad, @selector(page), (IMP)pageGetter, "@@:");
	class_addMethod(Notepad, @selector(setPage:), (IMP)pageSetter, "v@:@");

	// Finalize the class creation process
	objc_registerClassPair(Notepad);

	// Create an instance of the class and call both setter and getter to test
	id notepad = [Notepad new];
	[notepad performSelector:@selector(setPage:) withObject:@5];
	NSLog(@"%@", [notepad performSelector:@selector(page)]);
}

@end
