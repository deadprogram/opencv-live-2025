/*
How to run

	go run ./demo/videodrone [model] [backend] [target]
*/

package main

func main() {
	go startJoystick()
	startDrone()
}
