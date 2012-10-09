/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import <Accounts/Accounts.h>
@interface DeMarcelpociotSocialModule : TiModule 
{
    KrollCallback *successCallback;
    KrollCallback *cancelCallback;
    KrollCallback *errorCallback;
    
    ACAccountStore *accountStore;
    KrollCallback *loadCallback;
    KrollCallback *accessErrorCallback;
    
    KrollCallback *requestSuccessCallback;
    KrollCallback *requestErrorCallback;
}

@end
