//
//  UIImage+FiltrrCompositions.m
//  FilterTest
//
//  Created by Omid Hashemi & Stefan Klefisch on 2/6/12.
//  Copyright (c) 2012 42dp. All rights reserved.
//  http://www.42dp.com
//
//  Based on Alex Michael's filtrr for Javascript
//  https://github.com/alexmic/filtrr

#import "UIImage+FiltrrCompositions.h"
#import "UIImage+Filtrr.h"

@implementation UIImage (FiltrrCompositions)

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
    
    NSLog(@"returning new image");
    
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
    UIImage *topImage1 = [self duplicate];
    UIImage *topImage2 = [self duplicate];
    
    topImage2 = [[topImage2 fillRedChannel:226 GreenChannel:217 BlueChannel:113] saturationByFactor:0.2];
    topImage1 = [[topImage1 gaussianBlur] saturationByFactor:0.2];
    topImage1 = [topImage1 multiply:topImage2];
    
    RGBA minrgb, maxrgb;
    
    minrgb.red = 30;
    minrgb.green = 45;
    minrgb.blue = 40;
    
    maxrgb.red = 110;
    maxrgb.green = 190;
    maxrgb.blue = 110;
    
    return [[[[[[self saturationByFactor:0.2] tintWithMinRGB:minrgb MaxRGB:maxrgb] multiply: topImage1] brightnessByFactor:20] sharpen] contrastByFactor:1.1];
}

- (id) e10 { 
    return [[self sepia] biasByFactor:0.6];
}

@end
