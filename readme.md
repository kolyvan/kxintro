KxIntro is a small set of objective-c classes for showing of introduction in iOS app
===========================================

![intro](https://raw.github.com/kolyvan/kxintro/master/screenshots/intro.gif "Intro")

### Usage

1. Drop files from kxintro/source folder in your project.
2. Add frameworks: QuartzCore.framework and CoreGraphics.framework

Sample code:

	KxIntroViewController *vc;
	vc = [[KxIntroViewController alloc] initWithPages:@[
          [KxIntroViewPage introViewPageWithTitle: @"Lorem Ipsum passage"
                                       withDetail: @"Lorem ipsum dolor sit amet, consectetur.."
                                        withImage: nil],
          ]];
	[vc presentInViewController:self.window.rootViewController fullScreenLayout:YES];


Look at kxIntroExample demo project as sample of using.

### Requirements

at least iOS 5.1 and Xcode 4.5.0

### Feedback

Tweet me — [@kolyvan_ru](http://twitter.com/kolyvan_ru).