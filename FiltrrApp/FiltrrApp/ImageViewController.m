//
//  ImageViewController.m
//  FilterTest
//
//  Created by Omid Hashemi & Stefan Klefisch on 2/6/12.
//  Copyright (c) 2012 42dp. All rights reserved.
//  http://www.42dp.com
//


#import "ImageViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ImageViewController

@synthesize ivPic = _ivPic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    CALayer * l = [_ivPic layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = save;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) setImage:(UIImage *)img {
    _ivPic.frame = CGRectMake((self.view.frame.size.width - img.size.width)/2, (self.view.frame.size.height - img.size.height)/2, img.size.width, img.size.height);
    _ivPic.image = img;
}

-(void) save {
    UIImageWriteToSavedPhotosAlbum(_ivPic.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
        NSLog(@"Unable to save image to Photo Album.");
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    UIAlertView *alert;
    
    // Unable to save the image  
//    if (error)
//        alert = [[UIAlertView alloc] initWithTitle:@"Error" 
//                                           message:@"Unable to save image to Photo Album." 
//                                          delegate:self cancelButtonTitle:@"Ok" 
//                                 otherButtonTitles:nil];
//    else // All is well
//        alert = [[UIAlertView alloc] initWithTitle:@"Success" 
//                                           message:@"Image saved to Photo Album." 
//                                          delegate:self cancelButtonTitle:@"Ok" 
//                                 otherButtonTitles:nil];
//    [alert show];
}

@end
