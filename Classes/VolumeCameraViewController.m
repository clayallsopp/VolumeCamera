//
//  VolumeCameraViewController.m
//  VolumeCamera
//
//  Created by Clay Allsopp on 8/12/10.
//  Copyright 2010 Clay Allsopp. All rights reserved.
//

#import "VolumeCameraViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@implementation VolumeCameraViewController
@synthesize camera;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[UIApplication sharedApplication].statusBarHidden = YES;
	
	notifier = [[VolumeNotifications alloc] initWithDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		camera = [[UIImagePickerController alloc] init];
		camera.delegate = self;
		camera.allowsEditing = YES;
		camera.sourceType = UIImagePickerControllerSourceTypeCamera;
		camera.showsCameraControls = YES;
		
		// UNCOMMENT TO ENABLE VIDEO RECORDING - Doesn't work yet.
		//camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
		
		[self presentModalViewController:camera animated:YES];
		[camera release];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error accessing photo library" message:@"Device does not support camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}


- (void)dealloc {
	// [volumeLabel release];
	[camera release];
    [super dealloc];
}

#pragma mark -
#pragma mark VolumeDelegate Methods

- (void)volumeDidChange:(Float32)volume {
	if (camera) {
		NSLog(@"TAKING PICTURE");
		[camera takePicture];
	}
}

- (IBAction)showCamera:(id)sender {
	
}

#pragma mark -
#pragma mark UIImagePickerController delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
 
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if (CFStringCompare((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {               
        UIImage* picture = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!picture)
			picture = [info objectForKey:UIImagePickerControllerOriginalImage];             
		UIImageWriteToSavedPhotosAlbum(picture,nil,nil,nil);
    }
	else {
		// TODO: Save movies
		NSLog(@"MOVIE");
		NSLog(@"%@",[info objectForKey:UIImagePickerControllerMediaURL]);
		UISaveVideoAtPathToSavedPhotosAlbum([info objectForKey:UIImagePickerControllerMediaURL],self,@selector(video:didFinishSavingWithError: contextInfo:),nil);
	}
	[self dismissModalViewControllerAnimated:YES]; 

}

- (void) video: (NSString *) videoPath
    didFinishSavingWithError: (NSError *) error
    contextInfo: (void *) contextInfo {
  NSLog(@"Finished saving video with error: %@", error);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker 
{ 
    [self dismissModalViewControllerAnimated:YES]; 
}

@end
