//
//  NetworkTools.m
//  BMroomSDK
//
//  Created by Han Qing on 14/3/2017.
//  Copyright © 2017 bigmarker. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools


- (void)getConferenceInfo:(NSDictionary *)dictionary  {
    
     NSString* id = dictionary[@"id"];
     NSString* token = dictionary[@"token"];
    
     NSLog(@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb%@", dictionary);
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *urlString = [NSString stringWithFormat: @"https://integration.bigmarker.com/mobile/api/v1/conferences/%@?mobile_token=%@", id, token];

    
    NSLog(@"1111111111111111111111111111%@", urlString);
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable responseData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (responseData && (error == nil)) {
            

            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];

            if (responseObject[@"conference"]) {
                if (responseObject[@"conference"][@"conference_server"]) {
                    dict[@"host"] = responseObject[@"conference"][@"conference_server"];
                }
                if (responseObject[@"conference"][@"conference_datakey"]) {
                    dict[@"authData"] = responseObject[@"conference"][@"conference_datakey"];
                }
                if (responseObject[@"conference"][@"conference_obfuscated_id"]) {
                    dict[@"mcuID"] = responseObject[@"conference"][@"conference_obfuscated_id"];
                }
                if (responseObject[@"conference"][@"user_id"]) {
                    dict[@"userID"] = responseObject[@"conference"][@"user_id"];
                }
                if (responseObject[@"conference"][@"twilio_password"]) {
                    dict[@"twilioPassword"] = responseObject[@"conference"][@"twilio_password"];
                }
                if (responseObject[@"conference"][@"twilio_username"]) {
                    dict[@"twilioUsername"] = responseObject[@"conference"][@"twilio_username"];
                }
                
                dict[@"result"] = @"1";
                [self.networkToolsDelegate returnConferenceInfo: dict];
            }
            
        } else {
            // failed
             NSLog(@"3333333333333333333333333%@", error);
            dict[@"result"] = @"0";
            [self.networkToolsDelegate returnConferenceInfo: dict];
            NSLog(@"error=%@",error);
        }
    }];
    
    [task resume];
    
}

@end
