//
//  UIImage+Scale.m
//  FiltrrApp
//
//  Created by Omid Hashemi on 2/10/12.
//  Copyright (c) 2012 42dp. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

-(UIImage*)scaleToSize:(CGSize)size {
    // Create a bitmap graphics context
    // This will also set it as the current context
    UIGraphicsBeginImageContext(size);
    // Draw the scaled image in the current context
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // Create a new image from current context
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // Pop the current context from the stack
    UIGraphicsEndImageContext();
    // Return our new scaled image
    return scaledImage;
}

-(UIImage *) crop:(CGRect) cropRect {
//    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
//    // or use the UIImage wherever you like
//    UIImage *retImage = [UIImage imageWithCGImage:imageRef]; 
//    CGImageRelease(imageRef);
    
    if (self.scale > 1.0f) {
        cropRect = CGRectMake(cropRect.origin.x * self.scale,
                          cropRect.origin.y * self.scale,
                          cropRect.size.width * self.scale,
                          cropRect.size.height * self.scale);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    UIImage *retImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return retImage;
}

@end
