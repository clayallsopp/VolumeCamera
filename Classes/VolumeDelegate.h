//
//  VolumeDelegate.h
//  VolumeCamera
//
//  Created by Clay Allsopp on 8/12/10.
//  Copyright 2010 Clay Allsopp. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VolumeDelegate

- (void)volumeDidChange:(Float32)volume;

@end

@interface VolumeNotifications : NSObject
{
	id<VolumeDelegate> delegate;
	Float32 volume;
}

@property (nonatomic, assign) id<VolumeDelegate> delegate;

- (id)initWithDelegate:(id<VolumeDelegate>)aDelegate;
- (Float32)currentVolume;

@end

