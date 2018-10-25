//
//  OpenCVWrapper.h
//  OpenCV
//
//  Created by BinaryBoy on 10/24/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject
- (NSString*)getVersion;
+ (UIImage *)cannyEdgeImage:(UIImage *)image;
@end
