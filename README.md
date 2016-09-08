# SBRangeSlider
===========

## Summary
A simple range slider made in Swift.The user can select the images for thumbs as well as selction.


## Use
This control is **IBDesignable** and uses the **target-action** pattern for change values of thumbs.

In order to be notified when either thumb value changes, register for **.ValueChanged**:

## Implementation

- Create a UIView on storyboard/Xib and change its custom class SBRangeSlider.
- On attributes inspector set the values as well as images. 
- Create a function to get the change of values during scroll.
- In case user not give images through attribute inspectable, The images folder in the control provide the default images to project.

## Configuration

The range slider can be customized and information can be accessed through these properties :

+ `minVal` : The minimum possible value of the range
+ `maxVal` : The maximum possible value of the range
+ `selectedMinimumVal` : Initially selected minimum value corresponding to right thumb
+ `selectedMaximumVal` : Initially selected maximum value corresponding to right thumb
+ `trackImg` : The track image with selected portion
+ `trackBgImg` : The image to represent unselected range.
+ `thumbImage`: Image for left and right thumb.
+ `minRange` : The minimum distable required between two thumbs.

## License
SBRangeSlider is available under the MIT License

If you use it and like it, let me know: [@sarishti](sarishti09@gmail.com)

