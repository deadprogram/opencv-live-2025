.ONESHELL:

hello:
	go run ./demo/hello 2

yolo:
	go run ./demo/yolo-detection 2 /home/ron/models/yolov8s.onnx cuda cuda

clean:
	rm -rf build

builddir:
	mkdir -p build

blur:
	wasmvision run -p blur -logging=error --source 2

blurrs:
	wasmvision run -p blurrs -logging=error --source 2

blurc:
	wasmvision run -p blurc -logging=error --source 2

asciify:
	wasmvision run -p asciify -logging=error --source 2

captions:
	wasmvision run -f ./demo/creativecaptions/config.yaml

showvideo:
	wasmvision run -p hello -logging=error --source 2

build/videodrone:
	go build -o ./build/videodrone ./demo/videodrone/

videodrone: builddir build/videodrone
	./build/videodrone

dronestream:
	export WASMVISION_STORAGE_BOLTDB_FILENAME="facedata.db"
	wasmvision run -f ./demo/videodrone/config.toml

dronedata:
	bbolt keys facedata.db face-counter | xargs -L1 bbolt get facedata.db face-counter

ollama:
	docker start ollama
	docker exec ollama ollama run qnguyen3/nanollava
