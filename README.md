# open_telemetry_HW

![](https://github.com/jonasbjurel/open_telemetry_HW/blob/master/pcb/logos/OpenFlyTelemetry%20-%20Scale.jpg)

![](https://upload.wikimedia.org/wikipedia/commons/1/16/CC-BY_icon.svg)

**Licenses:**

The official OpenFly Telemetry project(s) are all open source. The licensing may vary from GPL 2, GPL 3, Apache, or Creative Commons. As with many other hardware projects – OpenFly Telemetry comes with the Creative Commons - CC BY 2.0 license.


**Disclaimers:**

The use of any HW, SW or instructions from the OpenFly Telemetry open source project, or any references to other art - is at your own risk. No warranties, or legal obligations shall be assumed from the creators – in any way. Flying model planes, drones or other remotely controlled vehicles always impose danger to the surroundings – make all necessary precautions to make sure that no one is in danger even in case the control of your model is lost for whatever reason.

# OpenFly Telemetry overview
OpenFly Telemetry is an open source project aiming to provide telemetry and navigation capabilities for model airplanes and drones through open source hardware and software. It uses various on-board sensor capabilities such as GPS, Accelerometers, Gyroscopes, Magnetometers, Pitot tubes, temperature sensors, battery voltage and current sensors, RPM sensors, etc. to provide the operator or algorithms with data for manual or automated corrective actions. The algorithms are some time autonomous and resides in the model, are sometimes on ground with the receiver or nearby connected devices or are sometimes even in distant clouds.
The OFT modules can also be placed in the module bay of the transmitter to enrich the transmitter awareness, e.g. Position, direction and additional communication capabilities such as Bluetooth and WIFI conectivity.
 
![OpenFly Telemetry basic idea](https://github.com/jonasbjurel/open_telemetry_HW/blob/master/pcb/documentation/SystemOverview.JPG)

**Figure 1:** OpenFly Telemetry basic idea

# OpenFly Telemetry (OFT) system description
OFT has two basic components: the Ada fruit ESP32 Huzzah feather processor board and the OFT system board. The ESP32 processor board obviously holds the software and algorithms for telemetry and navigation. The system board interfaces with the radio receiver and its telemetry and servo busses. The system is modular, and you can compose your choice of capabilities by stacking various OFT sensor boards on top of each other.

![OpenFly Telemetry system view](https://github.com/jonasbjurel/open_telemetry_HW/blob/master/pcb/documentation/ComponentOverview.JPG)

**Figure 2:** OpenFly Telemetry system view

OFT is based out of the Ada fruit ESP32 Huzzah feather processor board. This board hosts an ESP32 processor with two 32-bit general processor cores, 2 float processors and one ultra-low-power co-processor from Espressif (https://www.espressif.com/). Furthermore, the ESP32 board provides wireless connectivity through Bluetooth and WIFI as well as ensuring continuous power supply through an optional 2S designated LIPO, which could temporarily feed the servos and the receiver- should the main supply drain.
The ESP32 mother board connects to several telemetry acquisition boards in mother-daughter board/shield configurations.

![Ada fruit ESP32 Huzzah feather board](https://cdn-shop.adafruit.com/1200x900/3405-06.jpg)

**Figure 3:** Ada fruit ESP32 Huzzah feather board

For the on-board use cases (as opposed to the TX bay use case), the bottom most shield in the stack holds the OFT System board. The system board has an FPGA that connects to the radio receiver through the S.PORT for telemetry data, and the SBUS for servo output. The FPGA will allow the ESP32 processor to mix in servo corrections from the processor, transmitting upstream telemetry data, as well as receiving upstream telemetry and servo information from the transmitter. 
The system board interconnects with the radio control receiver through its S.PORT and SBUS.

![Frsky XR4](https://github.com/jonasbjurel/open_telemetry_HW/blob/master/pcb/sensors/Open_Telemetry_digitalSensorShield/Documentation/Pictures/XR4.JPG)

**Figure 4:** Frsky XR4 2.4 GHz MIMO CDMA receiver with S.PORT- (telemetry) and SBUS (Servos) connections

# OpenFly Telemetry resources
## OpenFly Telemetry repositories
[OpenFly Telemetry main applications repository](https://github.com/jonasbjurel/open_telemetry)
This repository provides the application software repository for the OpenFly Telemetry project.

[OpenFly Telemetry hardware repository](https://github.com/jonasbjurel/open_telemetry_HW)
The repository for this project - providing HW blue-prints and designs for OpenFly Telemetry.

##  OpenFly Telemetry Dependencies
[ESP32 Arduino](https://github.com/espressif/arduino-esp32)
The Arduino port of Espressif ESP32.

[ESP32 FreeRTOS port documentation](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/system/freertos.html) FreeRTOS APIs and methods available for ESP32

[High availability- and embedded system FreeRTOS  shim layer](https://github.com/jonasbjurel/coreNoStopRTOS)
System initialization, process monitoring, memory management, system bus arbitration, inter process communication, and much more..
