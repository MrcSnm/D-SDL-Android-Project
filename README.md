# D SDL Android Project Template
Provides a default/template project for programming with D and SDL on Android
This template for my tutorial about how to get your D code working on Android + SDL on Android

As the purpose of this template is to be beginner friendly, I will try to mantain updated:
- SDL         (2.0.12)
> This is a slightly modified version from SDL source code, the only difference at the path `SDL2/android-project/app/jni`, the folder
**src** was deleted, as there was no need to compile any C code
- SDL_Image    (2.0.5)
- SDL_Mixer    (2.0.4)
- SDL_TTF     (2.0.15)
- SDL_Network  (2.0.1)

## Important notes
This project was made for working on Linux, so, it is untested on Windows, but it should not differ too much
> ldc2 is a command on your console 
> rdmd is a command on your console
>>Get those commands at [Dlang main compilers](https://dlang.org/download.html)
> You should have modified (dlangPath)/(ldc)/etc/ldc2.conf to include your target architectures, check at my other repo [D-Lang On Android](https://github.com/MrcSnm/D-Lang-on-Android)
> You should have defined on your environment the variable "ANDROID_NDK_HOME"
> Execute on a terminal in the current path `rdmd setupsdl.d`
>>If you're on **Windows**, run this command with admin privilleges

## Building
The build system will be a bit different of the main build system for D, which is called `dub`. The reasoning is for simply
keeping your build with some library filtering(for the target Android architectures)
The buid command for this project is `rdmd build.d`
Commands supported on build.d
- --arch -> Receives the target architecture to compile, default is all.
- --help -> Shows every supported architecture.

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
- Arch Folders:
Those are the output folders for each build, default is:
```
	aarch64 --> arm64-v8a
    armv7a  --> armeabi-v7a
    x86_64  --> x86_64
    i686    --> x86
```
- Output path: `./SDL2/android-project/app/main/jniLibs/`

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
