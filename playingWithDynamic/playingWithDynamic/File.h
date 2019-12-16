//
//  File.h
//  playingWithDynamic
//
//  Created by Igor Chernyshov on 16.12.2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import Foundation;


NS_ASSUME_NONNULL_BEGIN


/**
 A class with dynamic properties.
 It swizzles it properties setters/getters with custom methods.
 These methods translate properties names into NSDictionary keys and run the corresponding selector depening on invocation.
 */
@interface File : NSObject

@property(nonatomic, strong) NSString *ownerName; /**< @dynamic variables. Setters and getters are changed. */
@property(nonatomic, strong) NSString *ownerSurname;

- (void)changeFileOwnerInDictionary; /**< (Test purpose) Changes internal NSDictionary values. */

@end

NS_ASSUME_NONNULL_END
