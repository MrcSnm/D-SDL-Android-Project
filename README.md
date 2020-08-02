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


## Building
The build system will be a bit different of the main build system for D, which is called `dub`. The reasoning is for simply
keeping your build with some library filtering(for the target Android architectures)