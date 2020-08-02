#!/usr/bin/rdmd
import std;
/**
*	This will probably not change any soon
**/
string compiler = "ldc2";
/**
*	If you need to add a new architecture to output
**/
string[] archs = 
[
	"aarch64",
	"armv7a",
	"x86_64",
	"i686"
];
string[string] archFolders;
archFolders["aarch64"] = "arm64-v8a";
archFolders["armv7a"] = "armeabi-v7a";
archFolders["x86_64"] = "x86_64";
archFolders["i686"] = "x86";
/**
*	If you need to add a new source
**/
string[] sourcePaths = 
[
	"source/",
	"jni/",
	"bindbc-loader/source",
	"bindbc-sdl/source"
];
string[] dependencies = 
[
	"BindBC-Loader", 
	"BindBC-SDL"
];
/**
*	Versions for the ldc compiler
**/
string[] versions = 
[
	"SDL_2012",
	"BindSDL_Mixer", 
	"BindSDL_TTF", 
	"BindSDL_Image"
];
/**
*	Debug options
**/
string[] debugs = 
[

];

/**
*	Android libraries taken from NDK
**/
string[] libraries = 
[
	"log"
];

/**
*	NDK Api Level, the first number(major) on the Android/Sdk/ndk/(major.minor)
**/
enum ndkApiLevel = 21;
/**
*	If you're compiling it from windows or Mac, you will need to change this tripleSystem
**/
enum tripleSystem = "-linux-android";

string[] getSources(string path) 
{
	string[] files;
	foreach (DirEntry e; path.dirEntries(SpanMode.depth).filter!(f => f.name.endsWith(".d")))
		files ~= e.name;
	return files;
}

void buildProgram(string arch, string[] sources) {
	string[] command = [compiler];

	foreach (sourcePath; sourcePaths)
		command ~= format!"-I%s"(sourcePath);

	foreach (version_; versions)
		command ~= format!"-d-version=%s"(version_);
	foreach (debug_; debugs)
		command ~= format!"-d-debug=%s"(debug_);
	foreach (library; libraries)
		command ~= format!"-L=-l%s"(library); //-L= for using GNU Linker(ld)

	command ~= format!"-mtriple=%s-%s"(arch, tripleSystem);
	command ~= "--shared";
	command ~= format!"--of=%s/libmain.so"(archFolders[arch]);

	string androidLibs = format!"%s/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/%s%s/%s/"(environment["ANDROID_NDK_HOME"], arch, tripleSystem, ndkApiLevel);
	command ~= format!"-L=-L%s"(androidLibs)~" ";

	foreach(source; sources)
	{
		command~= source;
	}

	// Pid pid = spawnProcess("/bin/echo" ~ command);
	Pid pid = spawnProcess(command);
	pid.wait;
}

void main(string[] args) 
{
	// For debuging
	try
	{
		environment["ANDROID_NDK_HOME"];
	}
	catch(Exception e)
	{
		throw new Error("You must define on your environment the variable ANDROID_NDK_HOME");
	}
	writeln("Getting NDK from: " ~ environment["ANDROID_NDK_HOME"]~"/");

	string[] sources;
	foreach (sourcePath; sourcePaths)
		sources ~= sourcePath.getSources;

	foreach (arch; archs)
		buildProgram(arch, sources);
}