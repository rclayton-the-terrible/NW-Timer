# NW-Timer

This is a free timer application built on Node-Webkit.

## Purpose

I use a timer to keep track of how much time I spend on a task, or in extreme cases, when the kids get in trouble (for "timeouts").  I have the "Classic Timer" application for OSX, which is pretty good, but it lacks a couple of tiny features I wanted.  More importantly, it's not portable (my wife wanted a copy as well, and she has a PC).

## Build & Run

1.  Install [Node.js](http://nodejs.org/).
2.  Install [Node-Webkit](https://github.com/rogerwang/node-webkit).
3.  Clone the repo.
4.  Move into the repo directory: `cd NW-Timer`.
5.  Build the project: `sh build.sh` (this simply zips the directory's contents).
6.  Run.  On OSX, either double-click `Timer.nw` or execute `open Timer.nw` from the shell.

## License

Copyright 2013 Richard Clayton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.