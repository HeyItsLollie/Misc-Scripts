# Metal Gear Solid (PS1, 1.0)
[**You know the one**](https://www.youtube.com/watch?v=52V32mbTIuc).

![](MGSCamExample.gif)

This is a relatively simple free-cam Lua script for Bizhawk, to be used with the original 1.0 US release of Metal Gear Solid on PS1.

Also included is a text file full of assorted memory addresses that I stumbled across while digging around the RAM in Bizhawk. Some are useful, and resulted in the creation of the freecam script. Others aren't very useful at all!!

## Freecam Controls ##

These freecam controls are built for a full-size keyboard, but I have done my best to accommodate keyboards that lack number pads as well. No gamepad controls as of yet.

**` / ~**<br>
Toggle Freecam controls

### Position

**A / D**<br>
— Move X Axis<br>
**W / S**<br>
— Move Z Axis<br>
**G / T**<br>
— Move Y Axis<br>

### Rotation
**Left Arrow / Right Arrow**<br>
— Orbit X Axis around camera target<br>
**Up Arrow / Down Arrow**<br>
— Orbit Y Axis around camera target

### Render Plane
**K / ;** (Semicolon)<br>
— Skew render plane Left / Right<br>
**O / L**<br>
— Skew render plane Up / Down<br>
**P**<br>
— Reset render plane

### Additional Camera Controls
**H / Y** or **2 / 8** (on Number Pad)<br>
— Decrease / Increase distance from camera target<br>
**Z / C** or **4 / 6** (on Number Pad)<br>
— Decrease / Increase camera's field-of-view<br>
**X** or **5** (on Number Pad)<br>
— Reset field-of-view<br>
**- / +** (Minus / Plus, on number row above letter keys)<br>
— Decrease / Increase Camera Move Speed<br>
**N**<br>
— Toggle Dither<br>
**M**<br>
— Toggle Freeze-Game

**Note:** When "Freeze-Game" is enabled, it effectively enables Pause mode without the Pause prompt, which locks all in-game elements, including the camera. In this state, the render plane is the only thing that can be altered.

I would love to alter the Freeze-Game behavior, so that all camera controls are still functional. If anyone knows how, please let me know!