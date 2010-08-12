//
//  VolumeCameraViewController.h
//  VolumeCamera
//
//  Created by Clay Allsopp on 8/12/10.
//  Copyright 2010 Clay Allsopp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VolumeDelegate.h"

@interface VolumeCameraViewController : UIViewController <VolumeDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	UIImagePickerController *camera;
	
	VolumeNotifications *notifier;
}

@property (nonatomic, retain) UIImagePickerController *camera;

- (IBAction)showCamera:(id)sender;

@end

