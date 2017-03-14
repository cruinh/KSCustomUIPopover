Notes on this fork:
There are a few display options available in KSCustomPopoverMainViewController.m  

With these settings:
  #define CUSTOM_POPOVER_BACKGROUND NO
  #define USE_DIM_BACKGROUND_VIEW YES
  #define BLUR_DIM_BACKGROUND NO
You'll get this:
<img src="KSCustomPopover/dimview_only.png" width="188">

With these settings:
  #define CUSTOM_POPOVER_BACKGROUND YES
  #define USE_DIM_BACKGROUND_VIEW NO
  #define BLUR_DIM_BACKGROUND NO
You'll get this:
<img src="KSCustomPopover/customBackgroundOnly.png" width="188">

With these settings:
  #define CUSTOM_POPOVER_BACKGROUND YES
  #define USE_DIM_BACKGROUND_VIEW YES
  #define BLUR_DIM_BACKGROUND NO
You'll get this:
<img src="KSCustomPopover/bothBackgroundOptions.png" width="188">

With these settings:
  #define CUSTOM_POPOVER_BACKGROUND NO
  #define USE_DIM_BACKGROUND_VIEW YES
  #define BLUR_DIM_BACKGROUND YES
You'll get this:
<img src="KSCustomPopover/blurBackground.png" width="188">

(original readme:)
KSCustomPopover is an example project for my article: http://www.scianski.com/customizing-uipopover-with-uipopoverbackgroundview/. It shows how to customize UIPopover with images. Project is simple Utility Application template with additional KSCustomPopoverBackgroundView subclass of UIPopoverBackgroundView. This project uses features only available in iOS SDK 5.0 and later.
