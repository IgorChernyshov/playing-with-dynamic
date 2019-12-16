//
//  DynamicClass.h
//  playingWithDynamic
//
//  Created by Igor Chernyshov on 16.12.2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import Foundation;


NS_ASSUME_NONNULL_BEGIN


/**
 Objects of this class can create a new class at runtime.
 */
@interface DynamicClass : NSObject

- (void)createDynamicClass; /**< Creates a class at runtime. */

@end

NS_ASSUME_NONNULL_END
