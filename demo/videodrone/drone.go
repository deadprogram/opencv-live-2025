package main

import (
	"fmt"
	"net"
	"time"

	"gobot.io/x/gobot/v2"
	"gobot.io/x/gobot/v2/platforms/dji/tello"
)

var (
	robot *gobot.Robot

	// drone
	drone      = tello.NewDriver("8890")
	flightData *tello.FlightData
)

func startDrone() {
	proxy, _ := net.DialUDP("udp", nil, &net.UDPAddr{IP: []byte{127, 0, 0, 1}, Port: 6789, Zone: ""})
	defer proxy.Close()

	drone.On(tello.FlightDataEvent, func(data interface{}) {
		// TODO: protect flight data from race condition
		flightData = data.(*tello.FlightData)
	})

	drone.On(tello.ConnectedEvent, func(data interface{}) {
		fmt.Println("Connected")
		drone.StartVideo()
		drone.SetVideoEncoderRate(tello.VideoBitRateAuto)
		drone.SetExposure(0)
		gobot.Every(100*time.Millisecond, func() {
			drone.StartVideo()
		})
	})

	drone.On(tello.VideoFrameEvent, func(data interface{}) {
		pkt := data.([]byte)
		proxy.Write(pkt)
	})

	robot = gobot.NewRobot("tello",
		[]gobot.Connection{joyAdaptor},
		[]gobot.Device{drone, stick},
	)

	robot.Start()
}
