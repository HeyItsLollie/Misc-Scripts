# Super Game Boy in GB Studio
## ✨ Lollie's Notes & Tests ✨ ##
This is a repository for the various notes I've made while testing SBG features and GBVM scripting in GB Studio.

I'm a total hobbyist and only poke and prod at GB dev in my own time.

## Useful References ##
* [**GB Dev: Pan Docs (SGB Functions)**](https://gbdev.io/pandocs/SGB_Functions.html)<br>
 — Pan Docs are a compilation of reversed-engineered documentation about developing for the Game Boy. This category specifically covers Super Game Boy functions. 
* [**chrismaltby: gbvm/vm.i**](https://github.com/chrismaltby/gbvm/blob/master/include/vm.i)<br>
 — This effectively acts as a complete list of every available GBVM command supported by GB Studio. This _isn't_ reference documentation, so see below for more.
* [**chrismaltby: gbvm/examples/**](https://github.com/chrismaltby/gbvm/tree/master/examples)<br>
 — A collection of various GBVM example scripts.
* [**pau-tomas: GBVM.md**](https://gist.github.com/pau-tomas/92b0ad77506088d184a654af226f5b7d)<br>
 — WIP, incomplete reference documentation for GBVM commands.

## Folder Contents <sup><sub>(ordered by SGB command / GBVM feature)</sub></sup> ##
* [**VM\_SGB\_TRANSFER.txt**](VM_SGB_TRANSFER.txt)<br>
 — Big catch-all document with personal notes for `VM_SGB_TRANSFER` commands and related GBVM scripts. Loosely organized and formatted for web viewing, but no guarantees that it'll always be easy to read.

* [**Cheat Sheet - 00h PAL01.png**](Cheat%20Sheet%20-%2000h%20PAL01.png)<br>
 — 15-Bit RGB to Hexadecimal color cheat sheet, for use with `00h-03h PAL##` commands. IMO this is already functionally obsolete, I recommend using `VM_LOAD_PALETTE` instead whenever possible, linked below.

* [**VM\_LOAD\_PALETTE.txt**](VM_LOAD_PALETTE.txt)<br>
 — Alternative for loading palettes at runtime, provided by @toxa in the official GB Studio Discord channel. Frankly, way more user-friendly and flexible. Recommend using this instead of `00h-03h PAL##` commands when working with GBVM.
