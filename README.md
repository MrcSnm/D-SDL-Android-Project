# D SDL Android Project Template
Provides a default/template project for programming with D and SDL on Android
This template for my tutorial about how to get your D code working on Android + SDL on Android

As the purpose of this template is to be beginner friendly, I will try to mantain updated:
- SDL
- SDL_Image
- SDL_Mixer
- SDL_TTF
- SDL_Network

## Important notes
This project was made for working on Linux, so, it is untested on Windows, but it should not differ too much
> ldc2 is a command on your console
> You should have modified (dlangPath)/(ldc)/etc/ldc2.conf to include your target architectures
> You should have defined on your environment the variable "ANDROID_NDK_HOME"

## Building
The build system will be a bit different of the main build system for D, which is called `dub`. The reasoning is for simply
keeping your build with some library filtering(for the target Android architectures)

### Modifying build.d
If you need to modify the main build system, it is quite simple to add your own things to it
There are arrays definitions for each thing:
- Architectures to output, default is:
```
[
    "aarch64",
    "armv7a",
    "x86_64",
    "i686"
];
```
- Sources for compile, default is:
```
[
    "source/",
	"bindbc-loader/source",
	"bindbc-sdl/source"
];
```
- Arch Folders
- Dependencies, default is:
```
[
	"BindBC-Loader", 
	"BindBC-SDL"
];
```
- Versions for the compiler, default is:
```
[
	"SDL_2012",
	"BindSDL_Mixer", 
	"BindSDL_TTF", 
	"BindSDL_Image"
];
```
- Debug, default is: `[]`
- Libraries, those are what libraries will be imported from android ndk, default is:
```
[
    "log"
];
```
- TripleSystem, this is where you will need to change if you're working on Windows on Mac, default is:
`enum tripleSystem = "-linux-android";`

## Acknowledgements

- LDC team for making the compiler, this project would not be anything without them
- https://www.libsdl.org/ for providing SDL
- @mdparker for providing BindBC-SDL and helping me on things about compiling
- @Joakim for making the initial jni.d  lib
- @Vild for converting my script into a *.d file
