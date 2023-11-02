This only exists so that I can use the FNL library in a Zig project.
I have a feeling there is a better way to solve the problem I was having, but I could not figure it out (documentation for the Zig build system is not great, and I am pretty new to the language).

The C implementation of FastNoiseLite is just a `.h` file that requires you to define `FNL_IMPL` in a `.c` file somewhere before importing it so that the implementation gets generated.
Including the library as a submodule means we can't modify/add any files in the repo, but we can also just handle this directly in Zig by doing something like this:
```zig
const fnl = @cImport({
    @cDefine("FNL_IMPL", {});
    @cInclude("FastNoiseLite.h");
});
```
Which compiles just fine, but then I ran it and immediately got hit in the face with a `panic: integer overflow`.
It seems like the library does some integer overflowing [intentionally](https://github.com/Auburn/FastNoiseLite/issues/113#issuecomment-1684941829)
but the problem is that Zig (by default) compiles C with some flags that make [undefined behavior cause an illegal instruction](https://github.com/ziglang/zig/wiki/FAQ#why-do-i-get-illegal-instruction-when-using-with-zig-cc-to-build-c-code).
It's normally easy to disable this by passing the `-fno-sanitize=undefined` flag when you pull in the C library in your `build.zig` file, but the implementation is being generated in our Zig file where we put that `@cImport` block instead of an actual `.c` file.
So the easiest way to get around this, I think, is to just fork the library and add a `.c` file that defines `FNL_IMPL`, and instead use this repo as our submodule instead.
