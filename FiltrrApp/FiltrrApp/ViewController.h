//
//  ImageViewController.h
//  FilterTest
//
//  Created by Omid Hashemi & Stefan Klefisch on 2/6/12.
//  Copyright (c) 2012 42dp. All rights reserved.
//  http://www.42dp.com
//

#import <UIKit/UIKit.h>

@interface ViewController :  UIViewController<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSString *filename;
    NSMutableArray *arrEffects;
    
    UIImagePickerController * imagePicker;
    UIImage *selectedImage, *thumbImage;
    UIImage *minithumbImage;
}

@property (nonatomic, retain) IBOutlet UITableView *tblEffects;

-(void) showCam;

@end
