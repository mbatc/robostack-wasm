
.PHONY: build

rosdep:
	rosdep install -i --from-path src --rosdistro humble -y

build:
	export CXX=em++; \
	export CC=emcc; \
	colcon build --event-handlers console_direct+

