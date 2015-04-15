//
//  XBGallery.m
//  Pods
//
//  Created by Binh Nguyen Xuan on 2/4/15.
//
//

#import "XBGallery.h"
#import "XBCacheRequest.h"

static XBGallery *__sharedXBGallery = nil;

@implementation XBGallery
@synthesize host;

+ (XBGallery *)sharedInstance
{
    if (!__sharedXBGallery)
    {
        __sharedXBGallery = [[XBGallery alloc] init];
    }
    return __sharedXBGallery;
}

- (void)uploadImage:(UIImage *)image withCompletion:(XBGImageUploaded)completeBlock
{
    NSString *url = [NSString stringWithFormat:@"%@/plusgallery/services/addphoto", host];
    XBCacheRequest *request = XBCacheRequest(url);
    [request addFileWithData:UIImageJPEGRepresentation([self fixOrientation:image], 0.7) key:@"uploadimg" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
    request.disableCache = YES;
    [request startAsynchronousWithCallback:^(XBCacheRequest *request, NSString *result, BOOL fromCache, NSError *error, id object) {
        completeBlock(object);
    }];
}

- (void)uploadImageURL:(NSString *)url withCompletion:(XBGImageUploaded)completeBlock
{
    NSString *urlRequest = [NSString stringWithFormat:@"%@/plusgallery/services/addphoto", host];
    XBCacheRequest *request = XBCacheRequest(urlRequest);
    [request setDataPost:[@{@"url": url} mutableCopy]];
    request.disableCache = YES;
    [request startAsynchronousWithCallback:^(XBCacheRequest *request, NSString *result, BOOL fromCache, NSError *error, id object) {
        completeBlock(object);
    }];
}

- (NSURL *)urlForID:(int)imageid isThumbnail:(BOOL)isThumbnail
{
    NSString *path = [NSString stringWithFormat:@"%@/plusgallery/services/showbyid?id=%d", self.host, imageid];
    return [NSURL URLWithString:path];
}

- (NSURL *)urlForID:(int)imageid size:(CGSize)size
{
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    NSString *path = [NSString stringWithFormat:@"%@/plusgallery/services/showbyid?id=%d&width=%f&height=%f", self.host, imageid, size.width * screenScale, size.height * screenScale];
    return [NSURL URLWithString:path];
}

- (void)infomationForID:(int)imageid withCompletion:(XBGImageGetInformation)completeBlock
{
    NSString *path = [NSString stringWithFormat:@"%@/plusgallery/services/showbyid/%d/1/1", host, imageid];
    XBCacheRequest *request = XBCacheRequest(path);
    request.disableCache = YES;
    [request startAsynchronousWithCallback:^(XBCacheRequest *request, NSString *result, BOOL fromCache, NSError *error, id object) {
        completeBlock(object);
    }];
}

- (UIImage *)fixOrientation:(UIImage *)image
{
    
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
