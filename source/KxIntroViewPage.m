//
//  KxIntroPage.m
//  kxintro project
//  https://github.com/kolyvan/kxintro/
//
//  Created by Kolyvan on 11.04.13.
//

/*
 Copyright (c) 2013 Konstantin Bukreev. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "KxIntroViewPage.h"

@implementation KxIntroViewPage

+ (id) introViewPageWithTitle: (NSString *) title
                   withDetail: (NSString *) detail
                    withImage: (UIImage *) image
{
    KxIntroViewPage *page = [[KxIntroViewPage alloc] initWithFrame:CGRectZero];
    if (title.length) page.titleLabel.text = title;
    if (detail.length) page.detailLabel.text = detail;
    if (image) page.imageView.image = image;
    return page;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        const BOOL isPhone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:isPhone ? 24 : 32];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.opaque = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        //_titleLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        
        const BOOL isPhone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.font = [UIFont systemFontOfSize:isPhone ? 16 : 22];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.numberOfLines = 0;
        _detailLabel.opaque = NO;
        _detailLabel.backgroundColor = [UIColor clearColor];
        //_detailLabel.backgroundColor = [UIColor grayColor];        
        [self addSubview:_detailLabel];        
    }
    return _detailLabel;
}

- (UIImageView *) imageView
{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.clipsToBounds = YES;
        _imageView.opaque = YES;
        _imageView.backgroundColor = [UIColor clearColor];
        //_imageView.backgroundColor = [UIColor greenColor];               
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (void) layoutSubviews
{
    const BOOL isPhone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
        
    const float yPadding = isPhone ? 5.f : 25.f;
    const float xPadding = isPhone ? 10.f : 50.f;
    
    CGSize size = self.bounds.size;
    const float H = size.height - yPadding * 1;
    const float W = size.width - xPadding * 2;
    
    CGSize titleSize = _titleLabel ? [_titleLabel sizeThatFits:CGSizeMake(W, H)] : CGSizeMake(0, 0);
    CGSize detailSize = _detailLabel ? [_detailLabel sizeThatFits:CGSizeMake(W, H)] : CGSizeMake(0, 0);
    
    float Y = yPadding;
    
    if (_titleLabel) {
        _titleLabel.frame = CGRectMake(xPadding, Y, W, titleSize.height);
        Y += titleSize.height + yPadding;
    }
    
    if (_imageView) {
        
        CGSize imageSize = _imageView.image.size;
        
        const float h = H - Y - detailSize.height - yPadding;
        const float imgH = MIN(imageSize.height, h);
        
        _imageView.frame  = CGRectMake(xPadding, Y + (h - imgH) * 0.5f, W, imgH);
        
        Y += h + yPadding;
    }
    
    if (_detailLabel) {
        
        //Y += ((H - Y) - detailSize.height) * 0.5f;
        Y = H - detailSize.height;
        _detailLabel.frame = CGRectMake(xPadding, Y, W, detailSize.height);
    }    
}

@end
