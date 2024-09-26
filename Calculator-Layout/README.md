# Calculator Layout Boss Challenge

## Overview

This project implements a calculator UI using Auto Layout and Stack Views in both portrait and landscape orientations. The challenge was to create a responsive layout that adheres to specific design requirements while utilizing constraints effectively.

## Features

- **Portrait and Landscape Support:** The calculator UI adjusts dynamically based on the device orientation.
- **Safe Area Constraints:** The layout is constrained to the safe areas, ensuring proper spacing from the edges of the screen.
- **Button Layout:** The "0" button is designed to take up twice the width of the "." and "=" buttons.
- **Label Indentation:** The label displaying the current input has a 20px distance from the right edge of the screen.

## Layout Details

### Portrait Mode

In portrait mode, the UI features:
- A vertical stack view containing the display label at the top.
- A series of horizontal stack views for number and operator buttons, organized for easy access.

### Landscape Mode

In landscape mode, the UI adjusts:
- The display label and buttons rearrange themselves to maintain usability and aesthetics while using available horizontal space.

## Implementation Steps

1. **Setup Auto Layout:**
   - Used vertical and horizontal stack views to structure the layout.
   - Applied constraints to ensure the UI is responsive to screen size and orientation.

2. **Safe Area Constraints:**
   - Used the safe area layout guides to ensure the UI respects the device's edges.

3. **Button Width Adjustments:**
   - Set the "0" button's width to be twice that of the "." and "=" buttons using layout constraints.

4. **Label Indentation:**
   - Applied right padding to the label to maintain a 20px distance from the right edge.

## Technologies Used

- **Swift**
- **UIKit**
- **Auto Layout**
- **Xcode**

## Screenshots

### Portrait Mode

![Portrait](Documentation/Portrait.png)

### Landscape Mode

![Landscape](Documentation/Landscape.png)

## Conclusion

This challenge successfully demonstrates the use of Auto Layout and Stack Views to create a responsive calculator UI. The implementation considers user experience by maintaining an organized layout across different orientations. 

## Acknowledgements

This project is a part of The App Brewery's Complete App Development Bootcamp. For more information, visit [www.appbrewery.co](https://www.appbrewery.co).
