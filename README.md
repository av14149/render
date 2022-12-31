## README
# Render
### Graphics & Drawing Library: Written in Swift, Built for Swift

`Render`, a Swift library, was built to completely restructure the rendering process. 

## Overview

Render was created as a layer on top of Apple's advanced Quartz drawing engine (which is actually manifested today in the SwiftUI CoreGraphics library). It was built from scratch, and since has remained true to its scrappy foundings: multiple layers of optimizations have allowed it to reach peak efficiency which can render a 1000x1000 frame in less than 10 seconds. (BTW this is pretty amazing since I have no clue about how to add Metal acceleration and have never done so. Also, this rendering process involves compiling 457 lines of code and thousands of floating-point calculations which then passes through the SwiftUI renderer and only then reaches the actual screen. My previous note about calculations was that the 10-second mark was not reached with the production application which meant that it was still recompiling every time I ran it AND the testing was done on a base-spec Intel Macbook [```2020, i5, 8GB RAM```] without any help from Apple Silicon. For me this is mind-blowing 🤯🤯🤯).

### TODO: Add more documentation.
