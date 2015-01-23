//
//  XBGallery.h
//  Pods
//
//  Created by Binh Nguyen Xuan on 2/4/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^XBGImageUploaded)(NSDictionary * responseData);

@interface XBGallery : NSObject
{
    
}

@property (nonatomic, retain) NSString *host;

+ (XBGallery *)sharedInstance;
- (void)uploadImage:(UIImage *)image withCompletion:(XBGImageUploaded)completeBlock;
- (void)uploadImageURL:(NSString *)url withCompletion:(XBGImageUploaded)completeBlock;

@end
