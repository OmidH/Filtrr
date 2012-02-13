//
//  UIImage+FiltrrCompositions.m
//  FilterTest
//
//  Created by Omid Hashemi & Stefan Klefisch on 2/6/12.
//  Copyright (c) 2012 42dp. All rights reserved.
//  http://www.42dp.com
//  Github: https://github.com/OmidH/Filtrr
//
//  Based on Alex Michael's filtrr for Javascript (thanks for sharing Alex)
//  https://github.com/alexmic/filtrr

#import "UIImage+FiltrrCompositions.h"
#import "UIImage+Filtrr.h"

@implementation UIImage (FiltrrCompositions)

#pragma mark - DebugHelper

-(id) trackTime:(NSString *)method {
    NSDate *startdate = [NSDate date]; 
    
    SEL _selector = NSSelectorFromString(method);
    id retVal = [self performSelector:_selector];
    
    NSDate *enddate = [NSDate date];
    
    NSTimeInterval diff = [enddate timeIntervalSinceDate:startdate];
    NSLog(@"returning new image from %@ with time: %f", method, diff);
    
    return retVal;
}

#pragma mark - Compositions

-(id) e1 {
    
    UIImage *topImage = [self duplicate];
    topImage = [[topImage saturationByFactor:0] blur];
    
    UIImage * newImage = [self multiply:topImage];
    
    RGBA minrgb, maxrgb;
    
    minrgb.red = 60;
    minrgb.green = 35;
    minrgb.blue = 10;
    
    maxrgb.red = 170;
    maxrgb.green = 140;
    maxrgb.blue = 160;
    
    newImage = [[[self tintWithMinRGB:minrgb MaxRGB:maxrgb] contrastByFactor:0.8] brightnessByFactor:10];
    
    return newImage;
    
}

-(id) e2 {
    
    RGBA minrgb, maxrgb;
    
    minrgb.red = 50;
    minrgb.green = 35;
    minrgb.blue = 10;
    
    maxrgb.red = 190;
    maxrgb.green = 190;
    maxrgb.blue = 230;
    
    return [[[self saturationByFactor:0.3] posterizeByLevel:70] tintWithMinRGB:minrgb MaxRGB:maxrgb];
}

-(id) e3 {
    RGBA minrgb, maxrgb;
    
    minrgb.red = 60;
    minrgb.green = 35;
    minrgb.blue = 10;
    
    maxrgb.red = 170;
    maxrgb.green = 170;
    maxrgb.blue = 230;
    
    return [[self tintWithMinRGB:minrgb MaxRGB:maxrgb] contrastByFactor:0.8];
}

-(id) e4 {
    RGBA minrgb, maxrgb;
    
    minrgb.red = 60;
    minrgb.green = 60;
    minrgb.blue = 30;
    
    maxrgb.red = 210;
    maxrgb.green = 210;
    maxrgb.blue = 210;
    
    return [[self grayScale] tintWithMinRGB:minrgb MaxRGB:maxrgb];
}

-(id) e5 {
    RGBA minrgb, maxrgb;
    
    minrgb.red = 30;
    minrgb.green = 40;
    minrgb.blue = 30;
    
    maxrgb.red = 120;
    maxrgb.green = 170;
    maxrgb.blue = 210;
    
    return [[[[[self tintWithMinRGB:minrgb MaxRGB:maxrgb] contrastByFactor:0.75] biasByFactor:1] saturationByFactor:0.6] brightnessByFactor:20];
}

-(id) e6 {
    RGBA minrgb, maxrgb;
    
    minrgb.red = 30;
    minrgb.green = 40;
    minrgb.blue = 30;
    
    maxrgb.red = 120;
    maxrgb.green = 170;
    maxrgb.blue = 210;
    
    return [[[self saturationByFactor:0.4] contrastByFactor:0.75] tintWithMinRGB:minrgb MaxRGB:maxrgb];
}

- (id) e7 { 
    UIImage *topImage = [self duplicate];
    
    RGBA minrgb, maxrgb;
    
    minrgb.red = 20;
    minrgb.green = 35;
    minrgb.blue = 10;
    
    maxrgb.red = 150;
    maxrgb.green = 160;
    maxrgb.blue = 230;
    
    topImage = [[topImage tintWithMinRGB:minrgb MaxRGB:maxrgb] saturationByFactor:0.6];
    
    UIImage *newImage = [[[self adjustRedChannel:0.1 GreenChannel:0.7 BlueChannel:0.4] saturationByFactor:0.6] contrastByFactor:0.8];
    newImage = [newImage multiply:topImage];
    
    return newImage;
}

- (id) e8 { 
    UIImage *topImage1 = [self duplicate];
    UIImage *topImage2 = [self duplicate];
    UIImage *topImage3 = [self duplicate];
    
    topImage3 = [topImage3 fillRedChannel:167 GreenChannel:118 BlueChannel:12];
    topImage2 = [topImage2 gaussianBlur];
    topImage1 = [topImage1 saturationByFactor:0];
    
    return [[[[[self overlay:topImage1] softLight:topImage2] softLight:topImage3] saturationByFactor:0.5] contrastByFactor:0.86];
}

- (id) e9 { 
    
    UIImage *topImage = [self duplicate];
    
    DataField shiftIn = DataFieldMake(2, 3, 0, 1);
    DataField shiftOut = DataFieldMake(3, 0, 1, 2);
    
    topImage = [topImage applyFiltrrByStep:4 
                                   ShiftIn:shiftIn
                                  ShiftOut:shiftOut
                                  Callback:^RGBA (int r, int g, int b, int a) {
        RGBA retVal;
        int t = 0;
        float avg = (r + g + b) / 3.0;
        
        retVal.red = [topImage safe:avg + t * (r - avg)];
        retVal.green = [topImage safe:avg + t * (g - avg)];
        retVal.blue = [topImage safe:avg + t * (b - avg)];
        retVal.alpha = a;
        
        return retVal;
    }];
    
    topImage = [topImage blur];
    
    UIImage * newImage = [self multiply:topImage];
    
    RGBA minrgb, maxrgb;
    
    minrgb.red = 60;
    minrgb.green = 35;
    minrgb.blue = 10;
    
    maxrgb.red = 170;
    maxrgb.green = 140;
    maxrgb.blue = 160;
    
    newImage = [newImage applyFiltrrByStep:4 
                                   ShiftIn:shiftIn
                                  ShiftOut:shiftOut
                                  Callback:^RGBA (int r, int g, int b, int a) {
        RGBA retVal;
        
        retVal.red = [newImage safe:(r - minrgb.red) * (255.0 / (maxrgb.red - minrgb.red))];
        retVal.green = [newImage safe:(g - minrgb.green) * (255.0 / (maxrgb.green - minrgb.green))];
        retVal.blue = [newImage safe:(b - minrgb.blue) * (255.0 / (maxrgb.blue - minrgb.blue))];
        retVal.alpha = a;
        
        return retVal;
    }];
    
    newImage = [newImage applyFiltrrByStep:4 
                                   ShiftIn:shiftIn
                                  ShiftOut:shiftOut
                                  Callback:^RGBA (int r, int g, int b, int a) {
        RGBA retVal;
        float val = 0.8;
        
        retVal.red = [newImage safe:(255.0 * [newImage calc_contrast:(r / 255.0) contrast:val])];
        retVal.green = [newImage safe:(255.0 * [newImage calc_contrast:(g / 255.0) contrast:val])];
        retVal.blue = [newImage safe:(255.0 * [newImage calc_contrast:(b / 255.0) contrast:val])];
        retVal.alpha = a;
        
        return retVal;
    }];
    
    newImage = [newImage applyFiltrrByStep:4 
                                   ShiftIn:shiftIn
                                  ShiftOut:shiftOut
                                  Callback:^RGBA (int r, int g, int b, int a) {
        RGBA retVal;
        float t = 10.0; 
        retVal.red = [newImage safe:r + t];
        retVal.green = [newImage safe:g + t];
        retVal.blue = [newImage safe:b + t];
        retVal.alpha = a;
        
        return retVal;
    }];
    
    return newImage;
    
}

- (id) e10 { 
    return [[self sepia] biasByFactor:0.6];
}


- (id) e11 { 
    
    UIImage *topImage = [self duplicate];
    
    DataField shiftIn = DataFieldMake(1, 2, 3, 0);
    DataField shiftOut = DataFieldMake(1, 1, 1, 2);
    
    topImage = [topImage applyFiltrrByStep:4 
                                   ShiftIn:shiftIn
                                  ShiftOut:shiftOut
                                  Callback:^RGBA (int r, int g, int b, int a) {
                                      RGBA retVal;
                                      int t = 0;
                                      float avg = (r + g + b) / 3.0;
                                      
                                      retVal.red = [topImage safe:avg + t * (r - avg)];
                                      retVal.green = [topImage safe:avg + t * (g - avg)];
                                      retVal.blue = [topImage safe:avg + t * (b - avg)];
                                      retVal.alpha = a;
                                      
                                      return retVal;
                                  }];
    
    topImage = [topImage blur];
    
    UIImage * newImage = [self multiply:topImage];
    
    RGBA minrgb, maxrgb;
    
    minrgb = RGBAMake(60, 35, 10, 255);    
    maxrgb = RGBAMake(170, 140, 160, 255);
    
    newImage = [newImage applyFiltrrByStep:4 
                                   ShiftIn:shiftIn
                                  ShiftOut:shiftOut
                                  Callback:^RGBA (int r, int g, int b, int a) {
                                      RGBA retVal;
                                      
                                      retVal.red = [newImage safe:(r - minrgb.red) * (255.0 / (maxrgb.red - minrgb.red))];
                                      retVal.green = [newImage safe:(g - minrgb.green) * (255.0 / (maxrgb.green - minrgb.green))];
                                      retVal.blue = [newImage safe:(b - minrgb.blue) * (255.0 / (maxrgb.blue - minrgb.blue))];
                                      retVal.alpha = a;
                                      
                                      return retVal;
                                  }];
    
    newImage = [newImage applyFiltrrByStep:4 
                                   ShiftIn:shiftIn
                                  ShiftOut:shiftOut
                                  Callback:^RGBA (int r, int g, int b, int a) {
                                      RGBA retVal;
                                      float val = 0.8;
                                      
                                      retVal.red = [newImage safe:(255.0 * [newImage calc_contrast:(r / 255.0) contrast:val])];
                                      retVal.green = [newImage safe:(255.0 * [newImage calc_contrast:(g / 255.0) contrast:val])];
                                      retVal.blue = [newImage safe:(255.0 * [newImage calc_contrast:(b / 255.0) contrast:val])];
                                      retVal.alpha = a;
                                      
                                      return retVal;
                                  }];
    
    newImage = [newImage applyFiltrrByStep:4 
                                   ShiftIn:shiftIn
                                  ShiftOut:shiftOut
                                  Callback:^RGBA (int r, int g, int b, int a) {
                                      RGBA retVal;
                                      float t = 10.0; 
                                      retVal.red = [newImage safe:r + t];
                                      retVal.green = [newImage safe:g + t];
                                      retVal.blue = [newImage safe:b + t];
                                      retVal.alpha = a;
                                      
                                      return retVal;
                                  }];
    
    return newImage;
    
}

@end
