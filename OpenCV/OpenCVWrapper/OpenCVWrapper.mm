//
//  OpenCVWrapper.m
//  OpenCV
//
//  Created by BinaryBoy on 10/24/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

/*
 * add a method convertToMat to UIImage class
 */
@interface UIImage (OpenCVWrapper)
- (void)convertToMat: (cv::Mat *)pMat;
@end

@implementation UIImage (OpenCVWrapper)
- (void)convertToMat: (cv::Mat *)pMat {
    if (self.imageOrientation == UIImageOrientationRight) {
        /*
         * When taking picture in portrait orientation,
         * convert UIImage to OpenCV Matrix in landscape right-side-up orientation,
         * and then rotate OpenCV Matrix to portrait orientation
         */
        UIImageToMat([UIImage imageWithCGImage:self.CGImage scale:1.0 orientation:UIImageOrientationUp], *pMat);
        cv::rotate(*pMat, *pMat, cv::ROTATE_90_CLOCKWISE);
    } else if (self.imageOrientation == UIImageOrientationLeft) {
        /*
         * When taking picture in portrait upside-down orientation,
         * convert UIImage to OpenCV Matrix in landscape right-side-up orientation,
         * and then rotate OpenCV Matrix to portrait upside-down orientation
         */
        UIImageToMat([UIImage imageWithCGImage:self.CGImage scale:1.0 orientation:UIImageOrientationUp], *pMat);
        cv::rotate(*pMat, *pMat, cv::ROTATE_90_COUNTERCLOCKWISE);
    } else {
        /*
         * When taking picture in landscape orientation,
         * convert UIImage to OpenCV Matrix directly,
         * and then ONLY rotate OpenCV Matrix for landscape left-side-up orientation
         */
        UIImageToMat(self, *pMat);
        if (self.imageOrientation == UIImageOrientationDown) {
            cv::rotate(*pMat, *pMat, cv::ROTATE_180);
        }
    }
}
@end


/*
 *  class methods to execute OpenCV operations
 */
@implementation OpenCVWrapper : NSObject

+ (UIImage *)cannyEdgeImage:(UIImage *)image {
    cv::Mat mat;
    [image convertToMat: &mat];
    
    cv::Mat gray, blur, edge;
    if (mat.channels() > 1) {
        cv::cvtColor(mat, gray, CV_RGB2GRAY);
    } else {
        mat.copyTo(gray);
    }
    
    cv::GaussianBlur(gray, blur, cv::Size(5, 5), 3, 3);
    
    cv::Canny(blur, edge, 20, 20 * 3, 3);
    
    UIImage *edgeImg = MatToUIImage(edge);
    return edgeImg;
}

-(NSString*)getVersion{
    return [NSString stringWithFormat:@"%s",CV_VERSION];
}
@end
