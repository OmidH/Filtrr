//
//  UIImage+Scale.h
//  FiltrrApp
//
//  Created by Omid Hashemi on 2/10/12.
//  Copyright (c) 2012 42dp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

-(UIImage*)scaleToSize:(CGSize)size;
-(UIImage *)crop:(CGRect) cropRect;

@end
