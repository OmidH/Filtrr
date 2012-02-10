//
//  UIImage+Filtrr.h
//  fltr
//
//  Created by Omid Hashemi & Stefan Klefisch on 2/6/12.
//  Copyright (c) 2012 42dp. All rights reserved.
//  http://www.42dp.com
//
//  Based on Alex Michael's filtrr for Javascript
//  https://github.com/alexmic/filtrr


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

struct anRGBA
{
    unsigned char red;
    unsigned char green;
    unsigned char blue;
    unsigned char alpha;
};

typedef struct anRGBA RGBA;

enum EdgeTypes {
    simple = 0,
    sobel = 1,
    canny = 2
};

typedef enum EdgeTypes EdgeType;

@interface UIImage (Filtrr) 

- (float) safe:(int) i;
- (UIImage *) duplicate;

- (id) applyFiltrr:(RGBA (^)(int r, int g, int b, int a))fn;
- (id) convolve:(NSArray *) kernel;
- (id) edgeDetection:(EdgeType)edgetype;
- (id) adjustRedChannel:(float) rS GreenChannel:(float) gS BlueChannel:(float) bS;
- (id) brightnessByFactor:(float) t;
- (id) fillRedChannel:(float)rF GreenChannel:(float) gF BlueChannel:(float) bF;
- (id) opacityByFactor:(float) o;
- (id) saturationByFactor:(float) t;
- (id) thresholdByFactor:(float) t;
- (id) posterizeByLevel:(float) level;
- (id) gammaByValue:(float) value;
- (id) negative;
- (id) grayScale;
- (id) bump;
- (id) tintWithMinRGB:(RGBA)minRGB MaxRGB:(RGBA)maxRGB;
- (id) maskRedChannel:(int)mR GreenChannel:(int) mG BlueChannel:(int) mB;
- (id) sepia;
- (id) biasByFactor:(float) val;
- (id) contrastByFactor:(float) val;
- (id) blur;
- (id) sharpen;
- (id) gaussianBlur;

- (id) applyBlend:(UIImage *)topImage CallBack: (RGBA (^)(RGBA top, RGBA bottom))fn;
- (id) multiply:(UIImage *)topImage;
- (id) screen:(UIImage *)topFltr;
- (id) overlay:(UIImage *)topFltr;
- (id) difference:(UIImage *)topFltr;
- (id) addition:(UIImage *)topFltr;
- (id) exclusion:(UIImage *)topFltr;
- (id) softLight:(UIImage *)topFltr;

@end
