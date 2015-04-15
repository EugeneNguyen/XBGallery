//
//  UIImageView+XBGallery.m
//  Pods
//
//  Created by Binh Nguyen Xuan on 4/15/15.
//
//

#import "UIImageView+XBGallery.h"
#import "XBGallery.h"

@implementation UIImageView (XBGallery)

- (void)loadImage:(int)imageId
{
    [self loadImageFromURL:[[XBGallery sharedInstance] urlForID:imageId size:self.frame.size] callBack:@selector(setImage:)];
}

@end
