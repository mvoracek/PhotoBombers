//
//  PhotoController.h
//  PhotoBombers
//
//  Created by Matthew Voracek on 4/9/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoController : NSObject

+(void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;

@end
