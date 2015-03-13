//
//  KxIntroView.h
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

#import <UIKit/UIKit.h>

@class KxIntroView;

@protocol KxIntroViewDelegate <NSObject>
@optional
- (void)introView:(KxIntroView *)view didComplete:(BOOL)finished;
@end

@interface KxIntroView : UIView

@property (readonly, nonatomic, strong) UIScrollView *scrollView;
@property (readonly, nonatomic, strong) UIPageControl *pageControl;
@property (readonly, nonatomic, strong) UIButton *closeButton;
@property (readonly, nonatomic, strong) NSArray *pages;

@property (readwrite, nonatomic, strong) UIView *introHeader;
@property (readwrite, nonatomic, strong) UIView *introFooter;
@property (readwrite, nonatomic, strong) UIView *backgroundView;

@property (readwrite, nonatomic) BOOL animatePageChanges;
@property (readwrite, nonatomic) BOOL gradientBackground;

@property (readwrite, nonatomic, weak) id <KxIntroViewDelegate> delegate;

- (instancetype)initWithPages: (NSArray *) pages NS_DESIGNATED_INITIALIZER;

@end
