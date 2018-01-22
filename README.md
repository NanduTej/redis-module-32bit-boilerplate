# redis-module-32bit-boilerplate
Simple boilerplate code to develop 32bit Redis modules using Docker and Make.

## Requirements
 * Make (tested on GNU Make 4.1)
 * Docker (tested on 17.09.0 CE)

## Usage
A simple Makefile and hello world module (`src/mymodule.c`) are provided as
starting points for developing your new Redis module. 

As is, the Makefile is set to compile `src/mymodule.c` as a Redis 4.0.6 
module in `build/redis_module.so`. To run it, just run `make`.

You can customise the source file path and redis versions by changing the 
`MODULE_SOURCE` and `REDIS_VERSION` variables in the Makefile.

## Rationale
While there are many usage scenarios where 32bit Redis makes sense, it can
be a pain to set up a consistent cross-compiling environment between 
developer machines and CI environments (which usually run 64bit OSes).

To avoid such problems, this project uses [Dockcross](https://github.com/dockcross/dockcross) 
as a stable 32-bit GCC build environment and provides a commented Makefile
as reference for new modules :-)
