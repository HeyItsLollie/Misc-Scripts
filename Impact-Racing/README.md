# Impact Racing
This is [a racing/combat game for the Sony PlayStation](https://www.youtube.com/watch?v=fVFx03RZmkw) (and Sega Saturn) released in 1996. Though the game itself can be easily overlooked for its simple gameplay, it has a killer soundtrack, and a cool bonus visualizer that can be used with regular music CDs.

Game data is plainly stored on the CD with zero compression, and its file formats are relatively human-readable in a Hex editor. My assumption that this makes the game a great candidate for learning how to reverse image and model formats for the first time — and to some extent, this has been true!

**File: Impact Racing File Formats.txt**<br>
A plain-text description of the main file formats in the game. Currently, this is limited to the .3DE file format, specifically its texture/image data. I would love to know how the model data works, but I haven't been able to figure out how it stores vertex coordinates.

**File: IR-3DE.bt**<br>
Binary Template for [010 Editor](https://www.sweetscape.com/010editor/), made to make it easier to identify/visualize game data, and to hopefully allow for conversion of game data into modern formats in the future. (Providing I can figure out how to make 010 do that!!)

**Folder: Samples**<br>
Sample files and manually-converted examples from the game:

* MINE.3DE and MINE\_T.3DE<br>
  — The in-game model and texture for landmines.
* AVUS.3DE and AVUS\_TE.3DE<br>
  — The "Blue Car" model and texture pack.
* AVUS\_TE-ALL.PNG and AVUS\_TE-SIDE.PNG<br>
  — Examples of converted texture files.<br>
  — "ALL" shows every texture in the pack, without index colors applied.<br>
  — "SIDE" is the car's side texture in full color, above a screenshot of its appearance in-game.
