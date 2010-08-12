//
//  VolumeDelegate.m
//  VolumeCamera
//
//  Created by Clay Allsopp on 8/12/10.
//  Copyright 2010 Clay Allsopp. All rights reserved.
//

#import "VolumeDelegate.h"
#import <AudioToolbox/AudioToolbox.h>


@implementation VolumeNotifications

@synthesize delegate;

void audioVolumeChangeListenerCallback (
                                         void                      *inUserData,
                                         AudioSessionPropertyID    inID,
                                         UInt32                    inDataSize,
                                         const void                *inData)
{	
	VolumeNotifications *self = (VolumeNotifications *)inUserData;
	
 	Float32 newGain = *(Float32 *)inData;
	
	if (self.delegate&&[(NSObject *)self.delegate respondsToSelector:@selector(volumeDidChange:)])
		{
			[self.delegate volumeDidChange:newGain];
		}
}


- (id) initWithDelegate:(id<VolumeDelegate>)aDelegate
{
	delegate = aDelegate;
	
	// need to initialize a session so that everything below works
	AudioSessionInitialize(NULL, NULL, NULL, NULL);
	
	// register the property change listener;
	AudioSessionAddPropertyListener (kAudioSessionProperty_CurrentHardwareOutputVolume,audioVolumeChangeListenerCallback,self);	
	AudioSessionSetActive(true);
	volume = kAudioSessionProperty_CurrentHardwareOutputVolume;
	
	return self;
}

- (Float32)currentVolume {
	return volume;
}


@end
