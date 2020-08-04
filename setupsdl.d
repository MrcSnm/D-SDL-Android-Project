#!/usr/bin/rdmd
import std;

string SDL_zip = "SDL_deps.zip";
string project_dir = "./SDL2/android-project/app/jni/";
static enum string[string] targetLinks = 
{
    string[string] _;
    _["SDL2"] = "SDL2",
    _["SDL2_image"] = "SDL2_image-2.0.5";
    _["SDL2_mixer"] = "SDL2_mixer-2.0.4";
    _["SDL2_net"] = "SDL2_net-2.0.1";
    _["SDL2_ttf"] = "SDL2_ttf-2.0.15";
    return _;
}();
// char[] stringz(string str)
// {
//     char[] ret = new char[str.length+1];
//     for(ulong i = 0, len = str.length; i < len;i++)
//         ret[i]=str[i];
//     ret[str.length] = 0;
//     return ret;
// }

void portablesymlink(string original, string target)
{
    const(char[])[] cmd;
    version(Windows)
    {
        cmd = ["mklink", "/D", getcwd()~"/"~target, original];
    }
    else
    {
        cmd = ["ln", "-s", getcwd()~"/"~original, target];
    }
    const auto ret = execute(cmd);
    {
        if(ret.status != 0)
            throw new Error("Could not create a symbolic link from " ~ original ~ " to "~target);
    }
}



void main()
{
    auto zip = new ZipArchive(read(SDL_zip));
    ulong count = 0;
    foreach(name, am; zip.directory)
    {
        string mdir = name[0..lastIndexOf(name, "/")+1];
        if(exists(name))
            count++;
        else if(mdir!=name)
        {
            mkdirRecurse(mdir);
            writeln("Extracting "~name);
            std.file.write(name, zip.expand(am));
        }
    }
    if(count != 0)
    {
        writeln("\nSkipped "~to!string(count)~" files");
    }
writeln(r"
--------------------------------------------------
Finished extracting zip, writing symbolic links
-------------------------------------------------");


foreach(linkName, directoryName; targetLinks)
{
    string target = project_dir~linkName;
    if(!exists(target))
    {
        portablesymlink(directoryName, target);
        writeln("Generating Symlink from '"~directoryName~"' to "~target);
    }
    else
    {
        writeln("Symlink '"~linkName~"' already exists");
    }
}

writeln(r"
--------------------------------------------------
Finished generating symbolic links
-------------------------------------------------");

}