# Super Game Boy in GB Studio
## ✨ Lollie's Notes & Tests ✨ ##
This is a repository for the various notes I've made while testing SBG features and GBVM scripting in GB Studio.

I'm a total hobbyist and only poke and prod at GB dev in my own time. Look towards resources like [GB Dev's Pan Docs](https://gbdev.io/pandocs/SGB_Functions.html) for more comprehensive documentation!

## Contents (sorted by SGB command / GBVM feature) ##
* [**VM\\_SGB\\_TRANSFER.txt**](VM_SGB_TRANSFER.txt)<br>
 — Big catch-all document with personal notes for VM\_SGB\_TRANSFER commands and related GBVM scripts. Loosely organized and formatted for web viewing, but no guarantees that it'll always be easy to read.

* [**Cheat Sheet - 00h PAL01.png**](Cheat Sheet - 00h PAL01.png)<br>
 — 15-Bit RGB to Hexadecimal color cheat sheet, for use with the PAL## commands.

* [**VM\\_LOAD\\_PALETTE.txt**](VM_LOAD_PALETTE.txt)<br>
 — Alternative for loading palettes at runtime, provided by @toxa in the official GB Studio Discord channel. Frankly, way more user-friendly and flexible. Recommend using this instead of VM\_SGB\_TRANSFER when working with GBVM.

 * There's also a GB Studio script by NalaFala, [Set Palette Colors](https://github.com/Y0UR-U5ERNAME/gbs-plugin-collection/blob/main/plugins/setPaletteColorsPlugin/events/eventSetPaletteColors.js), which appears to do the same as the GBVM code above. I've yet to test this, but it looks like it does the trick. 