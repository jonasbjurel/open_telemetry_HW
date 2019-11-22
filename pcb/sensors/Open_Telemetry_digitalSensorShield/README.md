# OFT001v1 Inertial navigation board 
The OFT001v1 Inertial navigation board captures navigational data, such as GPS positioning, 3D acceleration data, 3D Gyroscopic data, 3D Magnetic data, Barometric pressure, Temperature and Humidity. Those data are provided to the ESP32 processor card (and any other shield cards) through I2C and RS232. The data will be filtered, processed and transferred by the ESP32 card and the OFT System card FPGA. It is still to be seen if we can/will implement a high-performance Inertial navigation fuse fixed point Kalman filter in the FPGA, or if it is better done in SW?

![OFT001v1 Inertial navigation card overview](https://github.com/jonasbjurel/open_telemetry_HW/blob/master/pcb/sensors/Open_Telemetry_digitalSensorShield/Documentation/Pictures/digitalSensorShieldOverview.JPG)
 
**Figure 5:** OFT001v1 Inertial navigation card overview

The OFT001v1 card has an L80-M39 GPS with a built-in patch antenna, and an optional connector for an external 50 Ohm active antenna; an MP-9250 3D axis for each of: Accelerometer, Gyroscope and Magnetometer; and a BMP280 Barometric pressure- humidity- and temperature sensor. Note that the axise's for the acelerometers and Gyrometers differs from those of the manetometers (x swaped with y, and neative Z), clearly marked on the board. The communication with these sensors have been segmented so that the MPU runs on its own high speed I2C channel, allowing fast updates, Kalman filtering-, integration- and Quaternion calculation cycles by the CPU (and possibly later offloaded by the OFT System card FPGA); the BMP280 is less latency critical, and shares an I2C channel with potentially other devices in the stack; while the GPS communication happens over an RS232 serial channel using extensions of the NMEA protocol.

There is one green LED indicator for GPS lock, one orange LED indictor for External GPS antenna use, and an RGB LED for generic system status indication driven from the ESP32 CPU board. There are also two push buttons: one which is connected to the overall system reset, and another multi-purpose push button intended for system calibration activities.

It is important that OFT001v1 sits on the top of the mother-daughter board stack (unless an external GPS antenna is used) in order to achieve a good GPS signal.
Cupper layers have been kept out from ESP32 Bluetooth and WIFI PCB antennas to not deteriorate the signal strength from those.

![OFT001v1](https://github.com/jonasbjurel/open_telemetry_HW/blob/master/pcb/sensors/Open_Telemetry_digitalSensorShield/Documentation/Pictures/Open_Telemetry_digitalSensorShield-front1.jpg)

**Figure 6:** OFT001v1

?
## OFT001v1 shield pin-out

| OFT001 12 pin header (J2) | ESP32 HUZZAH 12 pin header (JP3) | ESP32 silicon | Comments               |
|---------------------------|----------------------------------|---------------|------------------------|
| 1 - N/C                   | VBAT                             | -             | N/C                    |
| 2 - N/C                   | EN                               | -             | N/C                    |
| 3 - N/C                   | VBUS                             | -             | N/C                    |
| 4 – RED LED               | IO13_A12                         | 13 - IO13/A2_6| Red system status led  |
| 5 – BLUE LED              | IO12_A11                         | 14 – IO12/A2_5| Blue system status led |
| 6 – GREEN LED             | IO27_A10                         | 12 – IO27/A2_7| Green system status led|
| 7 - N/C                   | IO33_A9                          | 9 - IO33/A1_5 | N/C                    |
| 8 - N/C                   | IO15_A8                          | 23 – IO15/A2_3| N/C                    |
| 9 - N/C                   | IO32_A7                          | 8 – IO32/A1_4 | N/C                    |
| 10 - N/C                  | IO14_A6                          | 13 – IO14/A2_6| N/C                    |
| 11 - I2C_0_SCL_3V         | SCL                              | 36 – IO22     | Common non-critical I2C|
| 12 - I2C_0_SDA_3V         | SDA                              | 37 – IO23     | Common non-critical I2C|

**Table 1:** J2 shield pin connector
 
 

| OFT001 16 pin header (J3) | ESP32 HUZZAH 16 pin header (JP1) | ESP32 silicon |Comments                   |
|---------------------------|----------------------------------|---------------|---------------------------|
| 1 – INT_0                 | IO21                             | 33 - IO21     | Interrupt from MPU9250    |
| 2 - I2C_1_SDA_3V          | IO17                             | 28 - IO17     | Critical MPU I2C          |
| 3 - I2C_1_SCL_3V          | IO16                             | 27 - IO16     | Critical MPU I2C          |
| 4 - N/C                   | MISO                             | 31 - IO19     | N/C                       |
| 5 - N/C                   | MOSI                             | 30 - IO18     | N/C                       |
| 6 - N/C                   | SCK                              | 29 - IO5      | N/C                       |
| 7 - CALIB                 | A5_IO4                           | 26 - IO4/A2_2 | System calibration button |
| 8 - UART_1_CLIENT_RXD     | A4_IO36                          | 4 - IO36/A1_0 | L8-M39 GPS UART (NMEA)    |
| 9 - UART_1_CLIENT_TXD     | A3_I39                           | 5 – IO39/A1_3 | L8-M39 GPS UART (NMEA)    |
| 10 – N/C                  | A2_I34                           | 6 – I34/A1_6  | N/C                       |
| 11 – N/C                  | A1_DAC1                          | 10 – IO25/DAC1/A2_8| N/C                  |
| 12 – N/C                  | A0_DAC2                          | 11 – IO26/DAC2/A2_9| N/C                  |
| 13 - GND                  | GND                              | -	       | GND from ESP32 motherboard|
| 14 – N/C                  | N/C                              | -             | N/C                       |
| 15 - +3.3V (VDD)          | +3.3V                            | -             | 3.3V max 120 mA from ESP32 motherboard (rated for max ???)|
| 16 - RESET                | RESET                            | 3 - EN        | 2-Way reset               |

**Table 2:** J3 shield pin connector
 
 

| OFT001 Ext GPS Ant. (J1) | Comments                                                              |
|--------------------------|-----------------------------------------------------------------------|
| 1 – AGND                 | External active GPS antenna ground                                    |
| 2 – EXTANT               | External active GPS antenna signal with VDD DC applied for power feed |

**Table 3:** J1 External PS Antenna

## OFT001v1 addressing

| I2CBus | Addr	           | Function | Comments |
|--------|-----------------|----------|----------|
| 0	 | 0x77(0x761) (1) | BME280   | -        |
| 1      | 0x68(0x692) (2) | MPU9250  | -        |

1)	Alternative address if NULL resistor R4 is mounted (not default)
2)	Alternative address if NULL resistor R7 is mounted (not default)

**Table 4:** OFT001v1 I2C addressing


## OFT001 v1 operating specifications
### Operational conditions:

| Parameter          | Nom    | Max     | Min      |
|--------------------|--------|---------|----------|
| Voltage            | 3.3 V  | 3.6 V   | 3.0 V    |
| Current            | 30 mA  | 120 mA  | -        |
| Power dissipation  | 100 mW | 400 mW  | -        |
| Ambient temp       | -      | 85 degC | -40 degC |

**Table 5:** OFT001v1 Operational conditions

### GPS antenna operational conditions:
The built in GPS patch antenna provides the following characteristics:

![GPS antenna characteristics](https://github.com/jonasbjurel/open_telemetry_HW/blob/master/pcb/sensors/Open_Telemetry_digitalSensorShield/Documentation/Pictures/L80PatchAntennaCharacteristics.JPG)

**Figure 7:** OFT001v1 Built in L80-M39 path GPS antenna characteristics

External GPS antenna operational requirements:

| Parameter            | Value          |
|----------------------|----------------|
| DC feed:             | 3.6V – 2.5V    |
| DC current (max):    | <???           |
| Center frequency:    | 1575.42MHz     |
| Band width:          | >5MHz          |
| VSWR:                | <2 (Typ.)      |
| Polarization:        | RHCP or Linear |
| Noise figure:        | <1.5dB         |
| Gain (antenna):      | >-2dBi         |
| Gain (embedded LNA): | 20dB (Typ.)    |
| Total gain:          | >18dBi (Typ.)  |

**Table 6:** OFT001v1 External operational conditions

## OFT001v1 schematics

![OFT001v1 schematics](https://github.com/jonasbjurel/open_telemetry_HW/blob/master/pcb/sensors/Open_Telemetry_digitalSensorShield/Documentation/Pictures/Schematics.JPG)
 
**Figure 8:** OFT001v1 schematics

## OFT001v1 - third party data sheets

[L80-M39 GPS receiver](http://docs-emea.rs-online.com/webdocs/147d/0900766b8147dbf2.pdf)

[BME280 Barometric pressure sensor](https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280-DS002.pdf)

[MPU9250 9-Axis Accelerometer, Gyroscope and Magenetometer](http://43zrtwysvxb2gf29r5o0athu-wpengine.netdna-ssl.com/wp-content/uploads/2015/02/PS-MPU-9250A-01-v1.1.pdf)