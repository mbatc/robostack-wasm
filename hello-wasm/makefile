hello-wasm: make-paths main.o
	emcc build/intermediate/main.o -o build/bin/hello-wasm.js

hello-wasm-html: make-paths main.o
	emcc build/intermediate/main.o -o build/bin/hello-wasm.html

main.o: make-paths
	emcc -c src/main.cpp -o build/intermediate/main.o

make-paths:
	mkdir -p build/bin;\
	mkdir -p build/intermediate
