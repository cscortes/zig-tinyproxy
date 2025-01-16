# Zig-Tinyproxy

## My version of TinyProxy that is compiled with Zig

* learn zig on a project that isn't trivial
* see how hard it would be
* just for fun


## [x] Phase 1: Compile with Zig
* Created a file with defines to "force full compile"

## [x] Phase 2: Create a library of TinyProxy Code
* Mostly had to work with the build.zig file
* The reason: to be able to test and switch out zig files for c files with some testing mechanism.
*
## [o] Phase 3: Create a test case runner for a particular module
* conf-tokens.c and h seem simple
* practice exposing c to zig for testing
* Simple test runner
  * build.zig has to be flexible enough to handle it

