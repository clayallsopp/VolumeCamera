//
//  VolumeCameraAppDelegate.h
//  VolumeCamera
//
//  Created by Clay Allsopp on 8/12/10.
//  Copyright 2010 Clay Allsopp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VolumeCameraViewController;

@interface VolumeCameraAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    VolumeCameraViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet VolumeCameraViewController *viewController;

@end

