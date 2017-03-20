//
//  NetworkTools.h
//  BMroomSDK
//
//  Created by Han Qing on 14/3/2017.
//  Copyright © 2017 bigmarker. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkToolsDelegate <NSObject>
- (void)returnConferenceInfo: (NSDictionary*)dict;
@end

@interface NetworkTools : NSObject

@property(nonatomic, strong) id<NetworkToolsDelegate> networkToolsDelegate;

@property(nonatomic, copy) NSString* conferenceId;
- (void) getConferenceInfo: (NSDictionary*)dictionary;
@end
