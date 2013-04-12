//
//  KxIntroView.m
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

#import "KxIntroView.h"
#import <QuartzCore/QuartzCore.h>

static float addDegrees(float delta, float deg)
{
    deg += delta;
    if (deg > 360.f)
        return deg - 360.f;
    if (deg < 0.f)
        return -deg;
    return deg;
}

@interface KxIntroView()  <UIScrollViewDelegate>
@end

@implementation KxIntroView {    

    UIView *_tailView;
}

- (void) setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView != backgroundView) {
        
        if (_backgroundView)
            [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        if (_backgroundView) {
            [self insertSubview:_backgroundView atIndex:0];
            self.backgroundColor = [UIColor clearColor];
        }
    }
}

- (void) setIntroHeader:(UIView *)introHeader
{
    if (_introHeader != introHeader) {
        
        if (_introHeader)
            [_introHeader removeFromSuperview];
        _introHeader = introHeader;
        if (_introHeader)
            [self addSubview:_introHeader];
    }
}

- (void) setIntroFooter:(UIView *)introFooter
{
    if (_introFooter != introFooter) {
        
        if (_introFooter)
            [_introFooter removeFromSuperview];
        _introFooter = introFooter;
        if (_introFooter)
            [self addSubview:_introFooter];
    }
}

- (id)initWithPages: (NSArray *) pages
{
    NSAssert(pages.count, @"empty pages");
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        const BOOL isPhone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
        
        _pages = pages;
        
        self.backgroundColor = [UIColor colorWithRed:47/255.f green:112/255.f blue:225/255.f alpha:1.f];
        self.opaque = YES;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;        
        [self addSubview:_scrollView];
        
        for (UIView *page in _pages)
            [_scrollView addSubview:page];
        _tailView = [[UIView alloc] initWithFrame:CGRectZero];
        [_scrollView addSubview:_tailView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.numberOfPages = _pages.count;
        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
        
        _closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:isPhone ? 16 : 20];
        [_closeButton setTitle:NSLocalizedString(@"Close", nil) forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeIntro) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
        
        //_scrollView.backgroundColor = [UIColor redColor];
        //_closeButton.backgroundColor = [UIColor yellowColor];
        //_pageControl.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void) layoutSubviews
{   
    const CGSize mySize = self.bounds.size;
    const float H = mySize.height;
    const float W = mySize.width;
        
    const BOOL isPhone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    const float margin = isPhone ? 10.f : 50.f;
    
    float Y = 0;
    float dH = 0;
    
    if (_introHeader) {
        
        CGSize size = [_introHeader sizeThatFits:CGSizeMake(W, H * .2f)];
        _introHeader.frame = CGRectMake(0, 0, W, size.height);
        Y += size.height;
        dH += size.height;
    }
    
    if (_introFooter) {
        
        CGSize size = [_introFooter sizeThatFits:CGSizeMake(W, H * .2f)];
        _introFooter.frame = CGRectMake(0, H - size.height, W, size.height);
        dH += size.height;
    }
        
    [_pageControl sizeToFit];
    const CGSize pageSize = _pageControl.bounds.size;
    const float pageWidth = W * 0.5;
    
    [_closeButton sizeToFit];
    const CGSize buttonSize = _closeButton.bounds.size;
    
    const float bH = MAX(pageSize.height, buttonSize.height);
    const float sH = H - bH - dH - margin;
    
    _scrollView.frame = CGRectMake(0, Y, W, sH);
    
    Y += sH;
    
    _pageControl.frame = CGRectMake((W - pageWidth) * 0.5,
                                    Y,
                                    pageWidth,
                                    bH);
    
    _closeButton.frame  = CGRectMake(W - buttonSize.width - margin,
                                     Y,
                                     buttonSize.width,
                                     bH);

    float X = 0;
    for (UIView *page in _pages) {
        
        page.frame = CGRectMake(X, 0, W, sH);
        if (X > 0 && _animatePageChanges) page.alpha = 0;
        X += W;
    }
    
    _tailView.frame = CGRectMake(X, 0, W, sH);
    X += W;
    
    _scrollView.contentSize = CGSizeMake(X, sH);
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    if (_backgroundView)
        _backgroundView.frame = CGRectMake(0, 0, W, H);
    
    if (_gradientBackground)
        [self mkGradientBackround];
}

- (void) closeIntro
{
    [self fireComplete:NO];
}

- (void) fireComplete: (BOOL) finished
{    
    __strong id <KxIntroViewDelegate> delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(introView:didComplete:)]) {
        [delegate introView:self didComplete:finished];
    }
}

- (void) didChangePageAtIndex: (NSInteger)index
{
    if (_animatePageChanges) {
        
        NSArray *pages = _pages;
        [UIView animateWithDuration:0.2
                         animations:^
         {
             NSUInteger n = 0;
             for (UIView *page in pages) {
                 
                 if (n++ == index) {
                     page.alpha = 1.f;
                 } else  if (page.alpha > 0.f) {
                     page.alpha = 0.f;
                 }
             }
         }];
    }
}

- (void) pageChanged: (id) sender
{    
    const NSUInteger currentPage = _pageControl.currentPage;
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * currentPage, 0)
                         animated:!_animatePageChanges];
    [self didChangePageAtIndex:currentPage];
}

- (void) mkGradientBackround
{
    CGSize size = self.bounds.size;
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:frame];
        [self insertSubview:_backgroundView atIndex:0];
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // the code for creation analogues colors taken from
    // https://github.com/bennyguitar/Colours-for-iOS
    // Copyright (c) 2013 Ben Gordon. All rights reserved.
    
    float h, s, b, a;
    [self.backgroundColor getHue:&h saturation:&s brightness:&b alpha:&a];
    h *= 360.f; s *= 100.f; b *= 100.f;
    
    UIColor *color1 = [UIColor colorWithHue:addDegrees(15,h)/360.f
                                 saturation:(s-5.f)/100.f
                                 brightness:(b-5.f)/100.f
                                      alpha:a];
    
    UIColor *color2 = [UIColor colorWithHue:addDegrees(30,h)/360.f
                                 saturation:(s-5.f)/100.f
                                 brightness:(b-10.f)/100.f
                                      alpha:a];
    
    UIColor *color3 = [UIColor colorWithHue:addDegrees(-15, h)/360.f
                                 saturation:(s-5.f)/100.f
                                 brightness:(b-5.f)/100.f
                                      alpha:a];
    
    UIColor *color4 = [UIColor colorWithHue:addDegrees(-30, h)/360.f
                                 saturation:(s-5.f)/100.f
                                 brightness:(b-10.f)/100.f
                                      alpha:a];
    
    ////////////////////////////////////////////////////////////////////////////
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    gradient.masksToBounds = YES;
    
    gradient.colors = @[
                        (id)color4.CGColor,
                        (id)color3.CGColor,
                        (id)self.backgroundColor.CGColor,
                        (id)color2.CGColor,
                        (id)color1.CGColor,
                        ];
    
    gradient.locations = @[
                           @(0.f),
                           @(0.2f),
                           @(0.4f),
                           @(0.8f),
                           @(1.0f),
                           ];
    
    [_backgroundView.layer addSublayer:gradient];
}

#pragma mark - UIScrollView Delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    const NSUInteger currentPage =  scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (currentPage == _pageControl.numberOfPages) {
        
        [self fireComplete:YES];
        
    } else {
        
        _pageControl.currentPage = currentPage;
        [self didChangePageAtIndex:currentPage];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_pageControl.currentPage == (_pageControl.numberOfPages - 1)) {
    
        const float W = _scrollView.frame.size.width;
        const float alpha = (W * _pages.count - _scrollView.contentOffset.x) / W;
        self.alpha = alpha;
    }
}

@end
