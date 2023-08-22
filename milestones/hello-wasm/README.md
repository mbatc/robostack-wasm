# Hello WASM

This is the first milestone in the robostack-wasm project. The goal is to compile a simple C++ application to Web Assembly.

## Usage

To build this milestone you will need emscripten sdk installed. You can either do this my running `make get-emsdk` in the robostack-wasm directory, or you can manually install in on your system using the instructions [here](https://emscripten.org/docs/getting_started/downloads.html)

Once emsdk is installed you can build the `Hello WASM` application by running `make hello-wasm` in the `hello-wasm` directory.

This will produce a html, js, and wasm file in build/bin. You can upload these files to a web server and navigate to the page to see the Hello WASM application running in your browser.

> Consider using Live Server Preview extension in Visual Studio Code to make previewing the files easier. For example, Microsofts Live Preview extension.
