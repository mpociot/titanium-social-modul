/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "DeMarcelpociotSocialModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import <Social/Social.h>

@implementation DeMarcelpociotSocialModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"61aa3517-3020-4af2-a0d3-8928f3009ba8";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"de.marcelpociot.social";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs


-(void)showSheet:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    NSString*   message          = [args objectForKey:@"message"];
    NSString*   service          = [args objectForKey:@"service"];
    NSArray*    imageArray       = [args objectForKey:@"images"];
    NSArray*    urlArray         = [args objectForKey:@"urls"];
    NSString*   serviceType      = SLServiceTypeFacebook;
    
    if( [[service lowercaseString] isEqualToString:@"facebook"] ){
        serviceType      = SLServiceTypeFacebook;
    } else if ([[service lowercaseString] isEqualToString:@"twitter"] ){
        serviceType      = SLServiceTypeTwitter;
    } else if ([[service lowercaseString] isEqualToString:@"sinaweibo"] ){
        serviceType      = SLServiceTypeSinaWeibo;
    } else {
        serviceType      = NULL;
        NSArray *postItems = @[message];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                                initWithActivityItems:postItems
                                                applicationActivities:nil];
        [[TiApp app] showModalController:activityVC animated:YES];
        return;
    }
    
    id success      = [args objectForKey:@"success"];
    id cancel       = [args objectForKey:@"cancel"];
    id error        = [args objectForKey:@"error"];
    RELEASE_TO_NIL(successCallback);
    RELEASE_TO_NIL(cancelCallback);
    RELEASE_TO_NIL(errorCallback);
    successCallback = [success retain];
    cancelCallback  = [cancel retain];
    errorCallback   = [error retain];
    
    if ([SLComposeViewController isAvailableForServiceType:serviceType])
    {
        SLComposeViewController *sheet = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        
        sheet.completionHandler = ^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultDone) {
                if (successCallback!=nil)
                {
                    [self _fireEventToListener:@"success" withObject:nil listener:successCallback thisObject:nil];
                }
            } else if (result == SLComposeViewControllerResultCancelled) {
                if (cancelCallback!=nil)
                {
                    [self _fireEventToListener:@"cancel" withObject:nil listener:cancelCallback thisObject:nil];
                }
            }
            [[TiApp app] hideModalController:sheet animated:YES];
        };
        
        [sheet setInitialText:message];
        if( [imageArray count] > 0 ){
            for(id image in imageArray )
            {
                [sheet addImage:[TiUtils toImage:image proxy:nil]];
            }
        }
        if( [urlArray count] > 0 )
        {
            for(NSString* url in urlArray )
            {
                [sheet addURL:[TiUtils toURL:url proxy:nil]];
            }
        }
        [[TiApp app] showModalController:sheet animated:YES];
    } else
    {
        if (errorCallback!=nil)
        {
            [self _fireEventToListener:@"error" withObject:nil listener:errorCallback thisObject:nil];
        }
    }
}

@end
