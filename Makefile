.ONESHELL:

showvideo:
	wasmvision run -p hello -logging=error --source 2

clean:
	rm -rf build

builddir:
	mkdir -p build

build/videodrone:
	go build -o ./build/videodrone ./demo/videodrone/

videodrone: builddir build/videodrone
	./build/videodrone

blur:
	wasmvision run -p blur -logging=error

blurrs:
	wasmvision run -p blurrs -logging=error

blurc:
	wasmvision run -p blurc -logging=error

asciify:
	wasmvision run -p asciify -logging=error

mosaic:
	wasmvision run -p mosaic -logging=error

ollama:
#	wasmvision run -p ollama -c model="qnguyen3/nanollava" -logging=error
	wasmvision run -f ./demo/creativecaptions/config.toml

dronestream:
#	wasmvision run -p facedetectyn --capture ffmpeg --source udp://127.0.0.1:6789
	wasmvision run -f ./demo/videodrone/config.toml
