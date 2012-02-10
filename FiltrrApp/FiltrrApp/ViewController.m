//
//  ImageViewController.h
//  FilterTest
//
//  Created by Omid Hashemi & Stefan Klefisch on 2/6/12.
//  Copyright (c) 2012 42dp. All rights reserved.
//  http://www.42dp.com
//

#import "ViewController.h"
#import "ImageViewController.h"
#import "UIImage+FiltrrCompositions.h"

@implementation ViewController

@synthesize tblEffects = _tblEffects;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    arrEffects = [[NSMutableArray alloc] initWithObjects:
                  [NSDictionary dictionaryWithObjectsAndKeys:@"Original",@"title",@"",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E1",@"title",@"e1",@"method", nil], 
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E2",@"title",@"e2",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E3",@"title",@"e3",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E4",@"title",@"e4",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E5",@"title",@"e5",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E6",@"title",@"e6",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E7",@"title",@"e7",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E8",@"title",@"e8",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E9",@"title",@"e9",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"E10",@"title",@"e10",@"method", nil],
                  nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrEffects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"EffectCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [(NSDictionary *)[arrEffects objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageViewController *nextViewController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
    nextViewController.title = [[arrEffects objectAtIndex:indexPath.row] valueForKey:@"title"];
    [self.navigationController pushViewController:nextViewController animated:YES];
    
    if(((NSString *)[[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]).length > 0) {
        
#ifndef TRACKTIME
        
        SEL _selector = NSSelectorFromString([[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]);
        nextViewController.ivPic.image = [nextViewController.ivPic.image performSelector:_selector];
        
#else
        
        SEL _track = NSSelectorFromString(@"trackTime:");
        nextViewController.ivPic.image = [nextViewController.ivPic.image performSelector:_track withObject:[[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]];
        
#endif
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
