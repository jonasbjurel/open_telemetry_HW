/* ************************************************************************************************* *
 * (c) Copyright 2020 Jonas Bjurel (jonasbjurel@hotmail.com)                                         *
 *                                                                                                   *
 * Licensed under the Apache License, Version 2.0 (the "License");                                   *
 * you may not use this file except in compliance with the License.                                  *
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0                *
 *                                                                                                   *
 * Unless required by applicable law or agreed to in writing, software distributed under the License *
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express- *
 * or implied.                                                                                       *
 * See the License for the specific language governing permissions and limitations under the         *
 * licence.                                                                                          *
 *                                                                                                   *
 * ************************************************************************************************* */

 /* ************************************************************************************************* *
  * Project:		    openTelemetryHW - https://github.com/jonasbjurel/open_telemetry_HW            *
  * Name:				OFT001V1 P1A BIST (Built in Self test program)                                *
  * Created:			2020-01-18                                                                    *
  * Originator:			Jonas Bjurel (jonasbjurel@hotmail.com)                                        *
  * Short description:	Provides a Built in self-test program for the OFT 001 V1 P1A board:           *
  *                     Following features are provided:                                              * 
  *                     o Discovery and callibration of all board functions such as                   *
  *                        - Buttons                                                                  *
  *                        - LED Luminances                                                               *
  *                        - BMP280 Barometic and temperature data                                    *
  *                        - MPU9250 9-axis intertial navigation sensor                               *
  *                        - L80-M39 GPS receiver                                                     *
  *                    o Sample streaming of navigational data to part Kalman filtered, such as:      *
  *                        - Euler angels and Euler angles change rates                               *
  *                        - Barometic pressure and Barometic vaiometering (bar alt change rates)     *
  *                   	   - GPS positioning, hight and GPS variometer (GPS alt change rates)         *
  *                        - Magnetic fields-, heading-, inclination-, heading chage-rate, etc...     *
  *																									  *
  *                   THIS CODE IS ONLY FOR SELF TEST OF THE OFT001v1 MODULE, and as reference what   *
  *                   you may be doing wth that module, it is not a good practice of production code, *
  *                   it is not a beuiuty well structured code - but it works for what it was built   *
  *                   for .....                                                                       *
  * Resources:        https://github.com/jonasbjurel/open_telemetry_HW                                                           *
  * ************************************************************************************************* */

/* ****************************************************************************************************
   Libray inclutions                                                                                  *
You need to follow this instruction to get needed libraries included to your project                  *
***************************************************************************************************** */
#include <EEPROM.h>
#include <BLEDevice.h>
#include <dummy.h>
#include "Arduino.h"
#include <math.h> 
#include <stdio.h>
#include <Wire.h>
#include <SPI.h>
#include <Adafruit_BMP280.h>
#include <MPU9250.h>
#include <Adafruit_GPS.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include <string.h>
#include <math.h>
#include <stdio.h>
#include "esp_attr.h"
//#include <SoftwareSerial.h> //maybe we should use Soft serial for the GPS as other more critical 
                              // task may need the few HW serials available - more likely we will use
                              // a I2C for S.Port and SmartPort?
/* End Libray inclutions                                                                              *
***************************************************************************************************** */

/* ****************************************************************************************************
   ESP32 Huzza Feather PIN definitions (ESP32 Wroom)                                                  *
***************************************************************************************************** */
#define CALIB_PIN  4
#define RED_LED_PIN 13
#define BLUE_LED_PIN 12
#define GREEN_LED_PIN 27
#define I2C_0_SCL_PIN 22
#define I2C_0_SDA_PIN 23
#define I2C_1_SCL_PIN 16
#define I2C_1_SDA_PIN 17
#define GPS_SERIAL_TXD_PIN 25
#define GPS_SERIAL_RXD_PIN 39
#define MPU_INTERRUPT_PIN 21
/* End ESP32 Huzza Feather PIN definitions                                                            *
***************************************************************************************************** */

/* ****************************************************************************************************
   I/F and device object definitions                                                                  *
***************************************************************************************************** */
#define BMP280_ADDR 0x77
#define BMP280_CID 0x58
#define MPU9250_ADDR 0x68
TwoWire I2C_0 = TwoWire(0); // I2C_0, Common non-critical I2C
TwoWire I2C_1 = TwoWire(1); // I2C_0, MPU dedicated critical I2C
#define GPSSerial Serial2
Adafruit_BMP280 bmp(&I2C_0);
MPU9250 mpu;
Adafruit_GPS GPS(&GPSSerial);
/* End I/F and device object definitions                                                              *
***************************************************************************************************** */

/* ****************************************************************************************************
   Register addresses and common register contents                                                    *
***************************************************************************************************** */

#define MPU9250_INT_PIN_CFG_ADDR 0x37
/* MPU9250_INT_PIN_CFG Register description
Bit-wise functions [7]MSB, [0]LSB
[7] ACTL
    1  The logic level for INT pin is active low.
    0  The logic level for INT pin is active high.
[6] OPEN
    1  INT pin is configured as open drain.
    0  INT pin is configured as push - pull.
[5] LATCH_INT_EN
    1  INT pin level held until interrupt status is cleared.
    0  INT pin indicates interrupt pulses is width 50us.
[4] INT_ANYRD_2CLEAR
    1  Interrupt status is cleared if any read operation is performed.
    0  Interrupt status is cleared only by reading INT_STATUS register
[3] ACTL_FSYNC
    1  The logic level for the FSYNC pin as an interrupt is active low.
	0  The logic level for the FSYNC pin as an interrupt is active high.
[2] FSYNC_INT_MODE_EN
    1  This enables the FSYNC pin to be used as an interrupt. A transition to the active level described by the ACTL_FSYNC bit 
	    will cause an interrupt. The status of the interrupt is read in the I2 C Master Status register PASS_THROUGH bit.
	0  This disables the FSYNC pin from causing an interrupt.
[1] BYPASS_EN
    1 - When asserted, the i2c_master interface pins(ES_CL and ES_DA) will go into bypass mode when the i2c master interface is
	    disabled.The pins will float high due to the internal pull - up if not enabled and the i2c master interface is disabled.
[0] RESERVED
*/

#define MPU9250_INT_PIN_CFG_DRAIN_HIGH_LATCH 0x60 //0110 0000
#define MPU9250_INT_PIN_CFG_DRAIN_LOW_LATCH 0xE0  //1110 0000
#define MPU9250_INT_PIN_CFG_DEFAULT 0x00

#define MPU9250_INT_ENABLE_ADDR 0x38
/* MPU9250_INT_ENABLE Register description
Bit-wise functions [7]MSB, [0]LSB
[7] RESERVED
[6] WOM_EN
    1  Enable interrupt for wake on motion to propagate to interrupt pin.
	0  function is disabled.
[5] RESERVED
[4] FIFO_OVERFLOW_EN
    1  Enable interrupt for fifo overflow to propagate to interrupt pin.
	0  function is disabled.
[3] FSYNC_INT_EN
    1  Enable Fsync interrupt to propagate to interrupt pin.
	0  function is disabled. 
[2] RESERVED
[1] RESERVED
[0] RAW_RDY_EN
    1  Enable Raw Sensor Data Ready interrupt to propagate to interrupt pin.
	    The timing of the interrupt can vary depending on the setting in register 36 I2C_MST_CTRL, bit [6] WAIT_FOR_ES.
	0  function is disabled.
*/
#define MPU9250_INT_EN_DATA_READY 0x01 //00000001
#define MPU9250_INT_DISABLE 0x00

#define MPU9250_INT_STATUS 0x3A
/* MPU9250_INT_STATUS Register description
Bit-wise functions [7]MSB, [0]LSB
[7] Reserved
[6] WOM_INT
    1  Wake on motion interrupt occurred.
[5] Reserved
[4] FIFO_OVERFLOW_INT
    1  Fifo Overflow interrupt occurred.  Note that the oldest data is has been dropped from the fifo. 
[3] FSYNC_INT 
    1  Fsync interrupt occurred. 
[2] Reserved
[1] Reserved
[0] RAW_DATA_RDY_INT
    1  Sensor Register Raw Data sensors are updated and Ready to be read. The timing of the interrupt can vary depending on the setting in register 36
	   I2C_MST_CTRL, bit [6] WAIT_FOR_ES. 
*/
#define RAW_DATA_RDY_INT_SRC_MASK 0x01 //00000001
#define RAW_DATA_RDY(INT_STATUS) (INT_STATUS & RAW_DATA_RDY_INT_SRC_MASK)
/* END - Register addresses and common register contents                                              *
***************************************************************************************************** */

/* ****************************************************************************************************
   BIST testphases and reult codes                                                                    *
***************************************************************************************************** */ 
//Major BIST test phases
#define START_TEST 0
#define CALIB_BUTTON_TEST 1
#define STATUS_LED_TEST 2
#define BMP280_TEST 3
#define MPU9250_TEST 4
#define L80M39_TEST 5
#define SUCCESS_TEST 253
#define STREAM_SENSORDATA_TEST 254
#define FAIL_TEST 255
int testPhase = START_TEST;
int subTestPhase = 0;

//BIST Fault codes
#define BIST_FC_SUCCESS 0
#define BIST_FC_CALIB_BUTTON_FAIL 1
#define BIST_FC_STATUS_LED_FAIL 2
#define BIST_FC_BPM280_NO_DETECT_FAIL 3
#define BIST_FC_BPM280_DETECT_BUT_NO_FUNCTION_FAIL 4
#define BIST_FC_L80M39_NO_DETECT_FAIL 5
#define BIST_FC_L80M39_DETECT_BUT_NO_FUNCTION_FAIL 6
#define BIST_FC_GPS_NO_1PSS_LOCK_FAIL 7
#define BIST_FC_NO_EXT_ANT_DETECT_FAIL 8
#define BIST_FC_MPU9250_NO_DETECT_FAIL 9
#define BIST_FC_AK8963_NO_DETECT_FAIL 10
#define BIST_FC_MPU9250_DETECT_BUT_NO_FUNCTION_FAIL 10
#define BIST_FC_MPU9250_INTERUPT_LINE_OPEN 11
#define BIST_FC_MPU9250_NO_INTERUPT 12
int bistFc = BIST_FC_SUCCESS;
char calibTextVal[10];
uint8_t mpuInterruptReceived = 0;

/* End BIST testphases and reult codes                                                                *
***************************************************************************************************** */

/* ****************************************************************************************************
   Callib button and Status led definitions                                                           *
***************************************************************************************************** */
//Needs to be refactores - unstructured defininitions below...
unsigned long timeout = 0;
int statusLedPhase = 0;
int ledColorCalib = 0;
int ledTestDelay = 2000;
int ledTestCnt = 0;
const int freq = 5000;
const int resolution = 12;
const int RED_LED_CH = 0;
const int BLUE_LED_CH = 1;
const int GREEN_LED_CH = 2;
int ledRedLuminance = 41; //1% of max is safe
int ledBlueLuminance = 41;
int ledGreenLuminance = 41;
int calibDebounce = 0;

/* ****************************************************************************************************
   BMP280 Barometic and Temp definitions                                                              *
***************************************************************************************************** */
//Calibration data

//Output Variables
float temp;
float barPres;
float barPresCalib;
float barAlt;
float barVar;

//Output Txt presentation
char barPresTxt[10] = "----.-";
char barAltTxt[10] = "+--.-";
char barVarTxt[10] = "+--.-";
char tempTxt[10] = "+--.-";

//Helper variables
unsigned long barVarDt = 20;
unsigned long prevTime = 0;
float dBarVar;
int dTTot;
uint8_t barVarFilterIndex = 0;
float barAltFiltVector[20] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
int barDtFiltVector[20] = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
float barVarFiltVector[20] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
/* End BMP280 Barometic and Temp definitions                                                          *
***************************************************************************************************** */

/* ****************************************************************************************************
   MPU9250 .... definitions                                                                           *
***************************************************************************************************** */
//MPU Definitions
#define MPU_READING_INTERVALL 20 //ms
#define MX 0
#define MY 1
#define MZ 2
#define AX 0
#define AY 1
#define AZ 2
#define GX 0
#define GY 1
#define GZ 2

//MPU Callibration data
float mcalibx;
float mcaliby;
float mcalibz;

//MPU and Kalman Output data
float magX;
float magY;
float magZ;
float magXYZ;
float magField;
float magIncl;
float magHdg;
float magHdgRate;
float roll;
float rollRate;
float pitch;
float pitchRate;
float yaw;
float yawRate;
float accX;
float accY;
float accZ;
float accXYZ;

//Output Txt presentation
char rollTxt[10] = "+---.-";
char pitchTxt[10] = "+---.-";
char yawTxt[10] = "+---.-";
char rollRateTxt[10] = "+---.-";
char pitchRateTxt[10] = "+---.-";
char yawRateTxt[10] = "+---.-";
char accXYZTxt[5] = "-.-";
char magHdgTxt[5] = "---";
char magHdgRateTxt[10] = "+---.-";
char magXYZTxt[10] = "------";
char magInclTxt[5] = "--";

//Helper variables
float prevYaw;
long int mpuReadingTime = 0;
uint8_t mpuFilterIndex = 0;
float accXFiltVector[10] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
float accYFiltVector[10] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
float accZFiltVector[10] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
float mXFiltVector[10] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
float mYFiltVector[10] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
float mZFiltVector[10] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
long int mpuInterruptTimeout;
/* End MPU9250 .... definitions                                                                       *
***************************************************************************************************** */

/* ****************************************************************************************************
   L80 - M39 GPS  .... definitions                                                                    *
***************************************************************************************************** */
//Definitions
#define GPS_NOLCK 0
#define GPS_ACC 1
#define DGPS_ACC 2
#define GPS3D_ACC 3
#define DGPS3D_ACC 4

//Interrupt timer
hw_timer_t* gpsTimer = NULL;

//GPS Callibration data
float GPSAltCalib;

//Output Txt presentation
char GPSYearTxt[5] = "--";
char GPSMonthTxt[5] = "--";
char GPSDayTxt[5] = "--";
char GPSHourTxt[5] = "--";
char GPSMinuteTxt[5] = "--";
char GPSSecondsTxt[5] = "--";
char GPSStatusTxt[10] = "NO_LCK";
char GPSLatTxt[15] = "--.------ -";
char GPSLonTxt[15] = "--.------ -";
char GPSSpeedTxt[10] = "--.-";
char GPSAngleTxt[5] = "---";
char GPSAltitudeTxt[10] = "+---.-";
char GPSVarTxt[10] = "+--.-";
char GPSSatellitesTxt[5] = "--";

//Helper variables
int gpsReceiveData = 0;
uint8_t gpsStatus = 0;
long unsigned resendGPSCommand = 0;

/* END L80 - M39 GPS  .... definitions                                                                *
***************************************************************************************************** */

/* ****************************************************************************************************
   BLE Server definitions                                                                             *
***************************************************************************************************** */
BLEServer* pServer = NULL;
BLECharacteristic* pTxCharacteristic;
bool deviceConnected = false;
bool oldDeviceConnected = false;
uint8_t txValue = 0;
#define SERVICE_UUID           "6E400001-B5A3-F393-E0A9-E50E24DCCA9E" // UART service UUID
#define CHARACTERISTIC_UUID_RX "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
#define CHARACTERISTIC_UUID_TX "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
/* END BLE Server  .... definitions                                                                   *
***************************************************************************************************** */

/* ****************************************************************************************************
   Streaming definitions                                                                              *
***************************************************************************************************** */
unsigned long progressTimer;
#define PROGRESS_TIMEOUT 1000
unsigned long consoleRefreshTimeOut = 0;
#define CONSOLE_REFRESH_SEC 1
unsigned long consoleCleanTimeout = 0;
#define CONSOLE_CLEAN_TIME_SEC 30
/* END Streaming definitions                                                                   *
***************************************************************************************************** */

/* ****************************************************************************************************
   MACROS                                                                                             *
***************************************************************************************************** */
#define SQR(X) (X *(X))
/* END MACROS                                                                                         *
***************************************************************************************************** */

// ****************************** END DEFINITIONS AND DECLARATIONS ************************************* 


/* ****************************************************************************************************
   BLE CLASS OBJECTS, FUNCTIONS AND CALLBACKS                                                         *
***************************************************************************************************** */
class MyServerCallbacks : public BLEServerCallbacks {
	void onConnect(BLEServer* pServer) {
		deviceConnected = true;
		Serial.println("BLE device connected!");
		consolSize(120, 30); //should be driven from elsewhere
	};

	void onDisconnect(BLEServer* pServer) {
		Serial.println("BLE device disconnected!");
		deviceConnected = false;
	}
};

class MyCallbacks : public BLECharacteristicCallbacks {
	void onWrite(BLECharacteristic* pCharacteristic) {
		std::string rxValue = pCharacteristic->getValue();

		if (rxValue.length() > 0) {
			Serial.println("*********");
			Serial.print("Received Value: ");
			for (int i = 0; i < rxValue.length(); i++)
				Serial.print(rxValue[i]);

			Serial.println();
			Serial.println("*********");
		}
	}
};

uint8_t BLEPrint(char* consoleText) {
	if (deviceConnected) {
		pTxCharacteristic->setValue(consoleText);
		pTxCharacteristic->notify();
		return 0;
	}
	else
	{
		return 255;
	}
}
/* END - BLE CLASSES, FUNCTIONS AND CALLBACKS                                                         *
***************************************************************************************************** */

/* ****************************************************************************************************
   CONSOLE & BLE OUTPUT & FORMATTING FUNCTIONS                                                        *
***************************************************************************************************** */
uint8_t consolePrint(char* consoleText, int outputDev = 2) {
	switch (outputDev) {
	case 0:
		Serial.print(consoleText);
		break;

	case 1:
		if (BLEPrint(consoleText))
			return 255;
		break;

	case 2:
		Serial.print(consoleText);
		if (BLEPrint(consoleText))
			return 255;
		break;

	default:
		return 255;
		break;
	}
	return 0;
}

uint8_t consolePrintln(char* consoleText, int outputDev = 2) {
	int res = consolePrint(consoleText, outputDev);
	res = res + consolePrint("\n", outputDev);
	if (outputDev)
		consolePrint("\r", outputDev);
	if (res)
		return 255;
	return 0;
}

// http://www.termsys.demon.co.uk/vtansi.htm

uint8_t consoleClear() {
	consolePrint("\033[2J",1);
	consolePrint("\033[0;0H",1);
	return 0;
}

uint8_t consoleCursorPos(int x, int y) {
	char formatString[20];
	sprintf(formatString, "\033[%d;%dH", y, x);
	consolePrint(formatString, 1);
	return 0;
}

uint8_t consolSize(int x, int y) {
	char formatString[20];
	sprintf(formatString, "\e[8; %d; %dt", y, x);
	consolePrint(formatString, 1);
	return(0);
}

void trimValues(void) {
	switch (gpsStatus) {
	case 0:
		sprintf(GPSStatusTxt, "NO_LCK");
		break;
	case 1: 
		sprintf(GPSStatusTxt, "GPS2D ");
		break;
	case 2: 
		sprintf(GPSStatusTxt, "GPS3D ");
		break;
	case 3: 
		sprintf(GPSStatusTxt, "DGPS2D");
		break;
	case 4: 
		sprintf(GPSStatusTxt, "DGPS3D");
		break;
	}
	sprintf(GPSYearTxt, "%d", GPS.year);
	sprintf(GPSMonthTxt, "%02d", GPS.month);
	sprintf(GPSDayTxt, "%02d", GPS.day);
	sprintf(GPSHourTxt, "%02d", GPS.hour);
	sprintf(GPSMinuteTxt, "%02d", GPS.minute);
	sprintf(GPSSecondsTxt, "%02d", GPS.seconds);
	sprintf(GPSLatTxt, "%f %c", GPS.latitudeDegrees, GPS.lat);
	sprintf(GPSLonTxt, "%f %c", GPS.longitudeDegrees, GPS.lon);
	sprintf(GPSSpeedTxt, "%04.1f", GPS.speed);
	sprintf(GPSAngleTxt, "%03.0f", GPS.angle);
	sprintf(GPSAltitudeTxt, "%+06.1f", GPS.altitude - GPSAltCalib);
	sprintf(GPSVarTxt, "%+05.1f", 0.0);
	sprintf(GPSSatellitesTxt, "%2d", GPS.satellites);

	sprintf(barAltTxt, "%+05.1f", barAlt);
	sprintf(barVarTxt, "%+05.2f", barVar);
	sprintf(tempTxt, "%+05.1f", temp);
	sprintf(barPresTxt, "%05.1f", barPres);

	sprintf(rollTxt, "%+06.1f", roll);
	sprintf(rollRateTxt, "%+06.1f", rollRate);
	sprintf(pitchTxt, "%+06.1f", pitch);
	sprintf(pitchRateTxt, "%+06.1f", pitchRate);
	sprintf(yawTxt, "%+06.1f", yaw);
	sprintf(yawRateTxt, "%+06.1f", yawRate);
	sprintf(accXYZTxt, "%03.1f", accXYZ);
	sprintf(magHdgTxt, "%03.0f", magHdg);
	sprintf(magHdgRateTxt, "%+06.1f", magHdgRate);
	sprintf(magXYZTxt, "%06.0f", magXYZ);
	sprintf(magInclTxt, "%02.0f", magIncl);

	if (!gpsStatus) {
		sprintf(GPSYearTxt, "--");
		sprintf(GPSMonthTxt, "--");
		sprintf(GPSDayTxt, "--");
		sprintf(GPSHourTxt, "--");
		sprintf(GPSMinuteTxt, "--");
		sprintf(GPSSecondsTxt, "--");
		sprintf(GPSLatTxt, "--.------ -");
		sprintf(GPSLonTxt, "--.------ -");
		sprintf(GPSSpeedTxt, "--.-");
		sprintf(GPSAngleTxt, "---");
		sprintf(GPSAltitudeTxt, "+---.-", GPS.altitude);
		sprintf(GPSVarTxt, "+--.-");
		sprintf(GPSSatellitesTxt, "--");
	}

	return;
}
/* END - CONSOLE& BLE OUTPUT & FORMATTING FUNCTIONS
****************************************************************************************************** */

/* ***************************************************************************************************
   BMP280 fuctions                                                                                   *
****************************************************************************************************** */
//Calibrate
void BarTempCalib(void) {
	consolePrintln("Calibrating the BMP280 barometic pressure- and temperature sensor...");
	temp = bmp.readTemperature();
	barPresCalib = bmp.readPressure();
	char BarTempCalibText[132];
	sprintf(BarTempCalibText, "Normal preasure at current hight callibrated to : %.1f [hPa] - as zero hight level", (barPresCalib / 100));
	consolePrintln(BarTempCalibText);
	return;
}

//Get data
void getBarTempData(void) {
	temp = bmp.readTemperature();
	barPres = bmp.readPressure() / (float)100;
	barAlt = bmp.readAltitude(barPresCalib / (float)100);
	if (!prevTime) {									// Disregard the very first sample
		barVarDt = 1;									// Just to avoid division by zero
	}
	else
		barVarDt = millis() - prevTime;
	prevTime = millis();
	
	if (++barVarFilterIndex > 19)
		barVarFilterIndex = 0;

	barAltFiltVector[barVarFilterIndex] = bmp.readAltitude(barPresCalib / (float)100);
	barDtFiltVector[barVarFilterIndex] = barVarDt;
	dBarVar = barAltFiltVector[barVarFilterIndex] - barAltFiltVector[barVarFilterIndex - 1];
	dTTot = 0;
	uint8_t i;
	for (i = 0; i < 20; i++)
		dTTot = dTTot + barDtFiltVector[i];
	
	barVarFiltVector[barVarFilterIndex] = 10000 * dBarVar / (float)dTTot; //Should be 1000?

	barVar = 0;
	for (i = 0; i < 20; i++) {
		barVar = barVar + barVarFiltVector[i];
	}
	barVar = barVar / (float)20;
	return;
}
/* END - BMP280 fuctions                                                                             *
******************************************************************************************************* /

/* ***************************************************************************************************
   MPU9250 fuctions                                                                                  *
****************************************************************************************************** */
//Callibrate
//  Propriatary Callibrate Mag
void magCalib(void) {
	//Ofset callibration, TODO implement X, Y, Z gain callibration if needed?
	consolePrintln("Starting standard magnometer callibration - rotate the device in all three axises (roll, pitch and yaw) during comming 30 seconds");
	mpu.calibrateMag();
	consolePrintln("Starting propriatary magnometer callibration - rotate the device in all three axises (roll, pitch and yaw) during comming 30 seconds");
	long int calibtimer;
	calibtimer = millis() + 30000;
	mpu.update();
	float maxx;
	maxx = mpu.getMag(0);
	float minx;
	minx = mpu.getMag(0);
	float maxy;
	maxy = mpu.getMag(1);
	float miny;
	miny = mpu.getMag(1);
	float maxz;
	maxz = mpu.getMag(2);
	float minz;
	minz = mpu.getMag(2);
	delay(100);

	while (millis() < calibtimer) {
		mpu.update();
		if (mpu.getMag(0) > maxx)
			maxx = mpu.getMag(0);
		if (mpu.getMag(0) < minx)
			minx = mpu.getMag(0);
		if (mpu.getMag(1) > maxy)
			maxy = mpu.getMag(1);
		if (mpu.getMag(1) < miny)
			miny = mpu.getMag(1);
		if (mpu.getMag(2) > maxz)
			maxz = mpu.getMag(2);
		if (mpu.getMag(2) < minz)
			minz = mpu.getMag(2);
		delay(20);
	}

	mcalibx = minx + abs((minx - maxx) / 2);
	mcaliby = miny + abs((miny - maxy) / 2);
	mcalibz = minz + abs((minz - maxz) / 2);
	consolePrintln("Magnetometer calibration finished");
	char callibdata[132];
	sprintf(callibdata, "Calibration offset[nT] - X:%.1f, Y:%.1f, Z:%.1f", mcalibx, mcaliby, mcalibz);
	consolePrintln(callibdata);
	delay(5000);
}

//Get MPU Data 
void getMPUdata(void) {
	if (millis() > mpuReadingTime) {
		long int dT = MPU_READING_INTERVALL + millis() - mpuReadingTime;
		mpu.update();
		mpuReadingTime = millis() + MPU_READING_INTERVALL;

		// Calculate Euler angels from Kalman filtered Quaternions 
		rollRate = (1000 * (mpu.getRoll() - roll)) / (float)dT; //Pitch and roll needs to be swapped
		roll = mpu.getRoll();
		pitchRate = (1000 * (mpu.getPitch() - pitch)) / (float)dT;
		pitch = mpu.getPitch();

		yaw = mpu.getYaw();
		if (yaw < 0)
			yaw = 360 + yaw;
		yawRate = 1000 * (yaw - prevYaw) / (float)dT;
		prevYaw = yaw;

		//calculate filtered accelerations
		if (++mpuFilterIndex > 9)
			mpuFilterIndex = 0;
		accXFiltVector[mpuFilterIndex] = mpu.getAcc(AX);
		accYFiltVector[mpuFilterIndex] = mpu.getAcc(AY);
		accZFiltVector[mpuFilterIndex] = mpu.getAcc(AZ);
		accX = 0;
		accY = 0;
		accZ = 0;
		uint8_t i;
		for (i = 0; i < 10; i++) {
			accX = accX + accXFiltVector[i];
			accY = accY + accYFiltVector[i];
			accZ = accZ + accZFiltVector[i];
		}
		accX = accX / 10;
		accY = accY / 10;
		accZ = accZ / 10;
		accXYZ = sqrt(SQR(accX) + SQR(accY) + SQR(accZ));

		// Calculate filtered magnetic fields [nT] and headings
		mXFiltVector[mpuFilterIndex] = (mpu.getMag(MX) - mcalibx) * 100;
		mYFiltVector[mpuFilterIndex] = (mpu.getMag(MY) - mcaliby) * 100;
		mZFiltVector[mpuFilterIndex] = (mpu.getMag(MZ) - mcalibz) * 100;
		magX = 0;
		magY = 0;
		magZ = 0;
		for (i = 0; i < 10; i++) {
			magX = magX + mXFiltVector[i];
			magY = magY + mYFiltVector[i];
			magZ = magZ + mZFiltVector[i];
		}
		magX = magX / 10;
		magY = magY / 10;
		magZ = magZ / 10;
		float magXY = sqrt(SQR(magX) + SQR(magY));
		magXYZ = sqrt(SQR(magX) + SQR(magY) + SQR(magZ));
		magIncl = acos(magXY / magXYZ) * 57.29;
		float prevMagHdg = magHdg;
		magHdg = acos(magX / magXY) * 57.29;
		if (magY > 0)
			magHdg = 360 - magHdg;
		magHdgRate = 1000 * (magHdg - prevMagHdg) / dT;
	}
}

// MPU9250 Interrupt routine
void IRAM_ATTR gotMpuInterrupt(void) {
	mpuInterruptReceived = 1;
	detachInterrupt(MPU_INTERRUPT_PIN);
	return;
}
/* END MPU9250 fuctions                                                                                *
****************************************************************************************************** */

/* ***************************************************************************************************
   L80-M39 GPS functions                                                                               *
****************************************************************************************************** */
//Get GPS data
void getGPSdata(void) {
	if (GPS.newNMEAreceived()) {
		//Serial.print("New NMEA message received: ");
		//Serial.println(GPS.lastNMEA());
		if (GPS.parse(GPS.lastNMEA())) {// this sets the newNMEAreceived() flag to false
			//consolePrintln("New NMEA message validated", 0);
	//update GPS data or invalidate if no fix and more than 2 seconds old....
			if (!GPS.fix) {
				gpsStatus = 0; //"NO_LCK"
			}
			else if (GPS.fixquality) {
				switch (GPS.fixquality) {
				case 1:
					if (GPS.fixquality_3d != 3) {
						gpsStatus = 1; //"GPS2D"
					}
					else {
						gpsStatus = 2; //"GPS3D"
					}
					break;
				case 2:
					if (GPS.fixquality_3d != 3) {
						gpsStatus = 3; //"DGPS2D"
					}
					else {
						gpsStatus = 4; //"DGPS3D"
					}
					break;
				}
			}
		}
	}
}

//GPS Read timmer interrupt
void IRAM_ATTR gpsRead(void) {
	GPS.read();
}
/* END L80-M39 GPS functions                                                                           *
****************************************************************************************************** */

/* ***************************************************************************************************
   I2C functions                                                                                     *
****************************************************************************************************** */
int i2cWriteByte(TwoWire w, uint8_t address, uint8_t subAddress, uint8_t data) {
	Serial.println("Writing to I2C");
	w.beginTransmission(address);				 // Initialize the Tx buffer
	w.write(subAddress);						 // Put slave register address in Tx buffer
	w.write(data);								 // Put data in Tx buffer
	int i2cErr = w.endTransmission();            // Send the Tx buffer
	if (i2cErr) {
		Serial.print("I2C ERROR CODE : ");
		Serial.println(i2cErr);
	}
	return i2cErr;
}

uint8_t i2cReadByte(TwoWire w, uint8_t address, uint8_t subAddress) {
	Serial.println("Reading from I2C");
	uint8_t data = 0;							 // `data` will store the register data
	w.beginTransmission(address);				 // Initialize the Tx buffer
	w.write(subAddress);						 // Put slave register address in Tx buffer
	int i2cErr = w.endTransmission(false);		 // Send the Tx buffer, but send a restart to keep connection alive
	if (i2cErr) {
		Serial.print("I2C ERROR CODE : ");
		Serial.println(i2cErr);
	}
	w.requestFrom(address, (size_t)1);  // Read one byte from slave register address
	if (w.available()) data = w.read();                      // Fill Rx buffer with result
	return data;                             // Return data read from slave register
}
/* END - I2C functions                                                                               *
****************************************************************************************************** */

/* ***************************************************************************************************
   ARDUINO SETUP                                                                                     *
****************************************************************************************************** */
//The setup function runs once when you press reset or power on the board
void setup() {
	Serial.begin(115200);
	pinMode(CALIB_PIN, INPUT);
	pinMode(MPU_INTERRUPT_PIN, INPUT);

	// Create the BLE Device
	BLEDevice::init("UART Service");

	// Create the BLE Server
	pServer = BLEDevice::createServer();
	pServer->setCallbacks(new MyServerCallbacks());

	// Create the BLE Service
	BLEService* pService = pServer->createService(SERVICE_UUID);

	// Create a BLE Characteristic
	pTxCharacteristic = pService->createCharacteristic(
		CHARACTERISTIC_UUID_TX,
		BLECharacteristic::PROPERTY_NOTIFY
	);

	pTxCharacteristic->addDescriptor(new BLE2902());

	BLECharacteristic* pRxCharacteristic = pService->createCharacteristic(
		CHARACTERISTIC_UUID_RX,
		BLECharacteristic::PROPERTY_WRITE
	);

	pRxCharacteristic->setCallbacks(new MyCallbacks());

	// Start the BLE service
	pService->start();

	// Start advertising
	pServer->getAdvertising()->start();
	Serial.println("Waiting for a Terminal Bluetooth client connection, notifying my presence as .....");

	//Setup the LEDs
	ledcSetup(RED_LED_CH, freq, resolution);
	ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
	ledcAttachPin(RED_LED_PIN, RED_LED_CH);
	
	ledcSetup(BLUE_LED_CH, freq, resolution);
	ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
	ledcAttachPin(BLUE_LED_PIN, BLUE_LED_CH);

	ledcSetup(GREEN_LED_CH, freq, resolution);
	ledcWrite(GREEN_LED_CH, (pow(2, resolution) - 0));
	ledcAttachPin(GREEN_LED_PIN, GREEN_LED_CH);

	I2C_0.begin(I2C_0_SDA_PIN, I2C_0_SCL_PIN, 100000);
	I2C_1.begin(I2C_1_SDA_PIN, I2C_1_SCL_PIN, 100000);

	GPS.begin(9600);
	GPSSerial.begin(9600, SERIAL_8N1, GPS_SERIAL_RXD_PIN, GPS_SERIAL_TXD_PIN);
	GPS.sendCommand(PMTK_SET_BAUD_115200);
	GPSSerial.flush(); // wait for last transmitted data to be sent 
	GPSSerial.begin(115200, SERIAL_8N1, GPS_SERIAL_RXD_PIN, GPS_SERIAL_TXD_PIN);
	while (GPSSerial.available()) Serial.read();

	//Setting up GPS timer interrupt
	gpsTimer = timerBegin(0, ESP.getCpuFreqMHz(), true); //80MHz CPU freq
	timerAttachInterrupt(gpsTimer, &gpsRead, true);
	timerAlarmWrite(gpsTimer, 50, true); //50 us/character for 115200 baud
	timerAlarmEnable(gpsTimer);
}
/* END ARDUINO SETUP                                                                                   *
****************************************************************************************************** */

/* ***************************************************************************************************
   ARDUINO LOOP                                                                                      *
****************************************************************************************************** */
// the loop function runs over and over again forever
void loop() {
	switch (testPhase) {
	//BIST First introductionary test phase
	case START_TEST:
		consolePrintln("Selftest test for OpenFlightTelemetry OFT001v1 board");
		Serial.print("Xtensa architecture ESP32 CPU running @: ");
		Serial.print(ESP.getCpuFreqMHz());
		Serial.println("MHz");
		consolePrint("press  calibration button to continue .");
		timeout++;
		delay(1000);
		testPhase++;
		subTestPhase = 0;
		break;

	//BIST Testing the Callib button
	case CALIB_BUTTON_TEST:
		if (digitalRead(CALIB_PIN)) {
			consolePrint(".");
			if (timeout >= 20) {
				consolePrintln("");
				consolePrintln("Self test FAILED - Calibration button not working - FAIL");
				timeout = 0;
				bistFc = BIST_FC_CALIB_BUTTON_FAIL;
				testPhase = FAIL_TEST;
			}
			else {
				consolePrint(".");
				timeout++;
				delay(1000);
			}
		}
		else {
			consolePrintln("");
			consolePrintln("Calibration button push detected - SUCCESS");
			ledRedLuminance = 0;
			ledBlueLuminance = 0;
			ledGreenLuminance = 0;
			timeout = 0;
			calibDebounce = 1;
			testPhase++;
			subTestPhase = 0;
		}
		break;

	//BIST Testing and callibrating LEDs
	case STATUS_LED_TEST:
		if (calibDebounce && !digitalRead(CALIB_PIN)) {
			break;
		}
		if (calibDebounce && digitalRead(CALIB_PIN)) {
			calibDebounce = 0;
		}
		switch (ledColorCalib) {
		case 0:
			if (!ledRedLuminance)
				consolePrintln("Calibrating status LEDs, starting with RED, press the calibration button when satisfied with the Luminance");

			if (!digitalRead(CALIB_PIN) || (ledRedLuminance >= pow(2, resolution))) {
				consolePrint("RED led is calibrated to: ");
				gcvt((100 * ledRedLuminance / pow(2, resolution)), 2, calibTextVal);
				consolePrint(calibTextVal);
				consolePrintln(" %");
				ledColorCalib++;
				calibDebounce = 1;
				delay(1000);
			}
			else {
				ledRedLuminance++;
				ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedLuminance));
				delay(100);
			}
			break;
		case 1:
			if (!ledBlueLuminance) {
				consolePrintln("Continuing with BLUE, press the calibration button when satisfied with the Luminance");
			}
			if (!digitalRead(CALIB_PIN) || (ledBlueLuminance >= pow(2, resolution))) {
				consolePrint("BLUE led is calibrated to: ");
				gcvt((100 * ledBlueLuminance / pow(2, resolution)), 2, calibTextVal);
				consolePrint(calibTextVal);
				consolePrintln(" %");
				ledColorCalib++;
				calibDebounce = 1;
				delay(1000);
				ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
			}
			else {
				ledBlueLuminance++;
				if (ledBlueLuminance & 2) {
					ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
					ledcWrite(BLUE_LED_CH, (pow(2, resolution) - ledBlueLuminance));
				}
				else {
					ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
					ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedLuminance));
				}
				delay(100);
			}
			break;
		case 2:
			if (!ledGreenLuminance) {
				consolePrintln("Continuing with GREEN, press the calibration button when satisfied with the Luminance");
			}
			if (!digitalRead(CALIB_PIN) || (ledGreenLuminance >= pow(2, resolution))) {
				consolePrint("GREEN led is calibrated to: ");
				gcvt((100 * ledGreenLuminance / pow(2, resolution)), 2, calibTextVal);
				consolePrint(calibTextVal);
				consolePrintln(" %");
				ledColorCalib++;
				delay(1000);
				ledcWrite(GREEN_LED_CH, (pow(2, resolution) - 0));
				ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
			}
			else {
				ledGreenLuminance++;
				if (ledGreenLuminance & 2) {
					ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
					ledcWrite(GREEN_LED_CH, (pow(2, resolution) - ledGreenLuminance));
				}
				else {
					ledcWrite(GREEN_LED_CH, (pow(2, resolution) - 0));
					ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedLuminance));
				}
				delay(100);
			}
			break;
		case 3:
			ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
			ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
			ledcWrite(GREEN_LED_CH, (pow(2, resolution) - 0));
			if (ledTestCnt++ > 1) ledTestCnt = 0;
			switch (ledTestCnt) {
			case 0:
				ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
				ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedLuminance));
				break;
			case 1:
				ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
				ledcWrite(BLUE_LED_CH, (pow(2, resolution) - ledBlueLuminance));
				break;
			case 2:
				ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
				ledcWrite(GREEN_LED_CH, (pow(2, resolution) - ledGreenLuminance));
				break;
			}
			delay(ledTestDelay);
			ledTestDelay = ledTestDelay * 0.8;
			if (ledTestDelay < 2) {
				ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedLuminance));
				ledcWrite(BLUE_LED_CH, (pow(2, resolution) - ledBlueLuminance));
				ledcWrite(GREEN_LED_CH, (pow(2, resolution) - ledGreenLuminance));
				delay(1000);
				ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
				ledcWrite(BLUE_LED_CH, (pow(2, resolution) - ledBlueLuminance));
				ledcWrite(GREEN_LED_CH, (pow(2, resolution) - 0));
				testPhase++;
				subTestPhase = 0;
			}
			break;
		}
		break;

	//BIST Testing the BMP280 barometic and temperature sensor
	case BMP280_TEST:
		if (!bmp.begin(BMP280_ADDR, BMP280_CID)) {
			consolePrintln("Self test FAILED - BMP280 Barometic sensor NOT found - FAIL");
			bistFc = BIST_FC_BPM280_NO_DETECT_FAIL;
			testPhase = FAIL_TEST;
		}
		else {
			consolePrintln("BMP280 Barometic sensor found - SUCCESS");
			bmp.setSampling(Adafruit_BMP280::MODE_NORMAL, /* Operating Mode.        */
				Adafruit_BMP280::SAMPLING_X2,             /* Temp. oversampling     */
				Adafruit_BMP280::SAMPLING_X16,            /* Pressure oversampling  */
				Adafruit_BMP280::FILTER_OFF,              /* Filtering.             */
				Adafruit_BMP280::STANDBY_MS_500);         /* Standby time.          */
			testPhase++;
			subTestPhase = 0;
		}
		break;

	//BIST Testing the MPU9250 inertial sensor
	case MPU9250_TEST:
		switch (subTestPhase) {
		case 0:
			mpu.setup(I2C_1);
			delay(1000);
			if (mpu.isConnectedMPU9250()) {
				//mpu.setMagneticDeclination(0);
				consolePrintln("MPU9250 6 axis inertial sensor found - SUCCESS");
				delay(5000);
				subTestPhase++;
			}
			else { 
				consolePrintln("MPU9250 6 axis inertial sensor NOT found -  FAIL");
				bistFc = BIST_FC_MPU9250_NO_DETECT_FAIL;
				testPhase = FAIL_TEST;
			}
			break;
		case 1:
			if (mpu.isConnectedAK8963()) {
				consolePrintln("AK8963 3 axis magnetometer found - SUCCESS");
				subTestPhase++;
			}
			else {
				consolePrintln("AK8963 3 axis magnetometer NOT found - FAIL");
				bistFc = BIST_FC_AK8963_NO_DETECT_FAIL;
				testPhase = FAIL_TEST;
			}
			break;
		case 2:
			consolePrintln("Checking MPU9250 Interrupt line LOW without MPU9250 interrupts enabled - to detact a broken interrupt line (OFT has a pull-up)...");
			//attachInterrupt(MPU_INTERRUPT_PIN, gotMpuInterrupt, GPIO_INTR_LOW_LEVEL);
			mpuInterruptTimeout = millis() + 1000;
			subTestPhase++;
			break;
		case 3:
			if (mpuInterruptReceived) {
				detachInterrupt(MPU_INTERRUPT_PIN);
				consolePrintln("Spurious MPU9250 Interrupt received while it shouldnt have/was not programed to generate interupts - FAIL");
				bistFc = BIST_FC_MPU9250_INTERUPT_LINE_OPEN;
				testPhase = FAIL_TEST;
			}
			else {
				if (millis() > mpuInterruptTimeout) {
					consolePrintln("No spurious MPU9250 Interrupt received - SUCCESS");
					consolePrintln("Checking MPU9250 Interrupt line rising edge with MPU9250 programmed to generate Interrupts(RISING EDGE) when data is available...");
					mpuInterruptReceived = 0;
					detachInterrupt(MPU_INTERRUPT_PIN);
					mpu.write(MPU9250_INT_PIN_CFG_ADDR, MPU9250_INT_PIN_CFG_DEFAULT);
					delay(100);
					mpu.write(MPU9250_INT_ENABLE_ADDR, MPU9250_INT_EN_DATA_READY);
					delay(100);
					attachInterrupt(MPU_INTERRUPT_PIN, gotMpuInterrupt, GPIO_INTR_POSEDGE);
					mpu.read(MPU9250_ADDR, MPU9250_INT_STATUS);
					mpuInterruptTimeout = millis() + 1000;
					subTestPhase++;
				}
			}
			break;
		case 4:
			if (mpuInterruptReceived) {
				detachInterrupt(MPU_INTERRUPT_PIN);
				consolePrintln("MPU9250 Interrupt received as it should - SUCCESS");
				mpu.write(MPU9250_INT_ENABLE_ADDR, MPU9250_INT_DISABLE);
				testPhase++;
				subTestPhase = 0;
			}
			else {
				if (millis() > mpuInterruptTimeout) {
					detachInterrupt(MPU_INTERRUPT_PIN);
					consolePrintln("No MPU9250 Interrupt received - FAIL");
					mpu.write(MPU9250_INT_ENABLE_ADDR, MPU9250_INT_DISABLE);
					bistFc = BIST_FC_MPU9250_NO_INTERUPT;
					testPhase = FAIL_TEST;
				}
			}
			break;
		}
		break;

	//BIST Testing the L80-M39 GPS receiver
	case L80M39_TEST:
		switch (subTestPhase) {
		case 0:
			consolePrintln("Checking GPS Module L80-M39");
			subTestPhase++;
			break;
		case 1:
			GPS.newNMEAreceived();
			GPS.lastNMEA();
			GPS.sendCommand(PMTK_SET_NMEA_OUTPUT_ALLDATA);
			delay(100);
			GPS.sendCommand(PMTK_API_SET_FIX_CTL_1HZ);
			delay(100);
			resendGPSCommand = millis() + 100;
			timeout = millis() + 5000;
			subTestPhase++;

		case 2:
			if (millis() > resendGPSCommand) { //TODO: Some times the commands seems not to be received, worrying needs further troubleshooting with the scope - do we we need to send them periodically?
				consolePrintln("(Re)sending Version request command...");
				GPS.sendCommand(PMTK_Q_RELEASE);
				resendGPSCommand = millis() + 100;
			}
			if (GPS.newNMEAreceived()) {
				//Serial.print("GPS data received");
				//Serial.println(GPS.lastNMEA());
				gpsReceiveData = 1;
				if (strncmp("$PMTK705", GPS.lastNMEA(), strlen("$PMTK705")) == 0) {
					consolePrintln("L80-M39 GPS module found - SUCCESS");
					testPhase++;
					subTestPhase = 0;
					timeout = 0;
					break;
				}
				if (millis() > timeout && gpsReceiveData) {
					consolePrintln("Self test FAILED - L80-M39 GPS module found but NOT functional - FAIL");
					bistFc = BIST_FC_L80M39_DETECT_BUT_NO_FUNCTION_FAIL;
					testPhase = FAIL_TEST;
					subTestPhase = 0;
					break;
				}
			}
			if (!gpsReceiveData && (millis() > timeout)) {
				consolePrintln("Self test FAILED - L80-M39 GPS module NOT found - FAILED");
				bistFc = BIST_FC_L80M39_NO_DETECT_FAIL;
				testPhase = FAIL_TEST;
				subTestPhase = 0;
				break;
			}
			break;
		}
		break;

	//BIST Testing Successful
	case SUCCESS_TEST:
		ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
		ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
		ledcWrite(GREEN_LED_CH, (pow(2, resolution) - ledGreenLuminance));
		if (GPS.newNMEAreceived())
			GPS.parse(GPS.lastNMEA());
		if ((GPS.fix && (GPSAltCalib = GPS.altitude)) || (!digitalRead(CALIB_PIN))) {
			consolePrintln("Satelites aquired, Calibrating the system....");
			BarTempCalib();
			ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedLuminance));
			ledcWrite(BLUE_LED_CH, (pow(2, resolution) - ledBlueLuminance));
			ledcWrite(GREEN_LED_CH, (pow(2, resolution) - ledGreenLuminance));
			mpu.calibrateAccelGyro();
			magCalib();
			consolePrintln("Calibration done, streaming data...");
			consoleClear();
			timeout = 0;
			subTestPhase = 0;
			testPhase++;
		}
		else {
			if (!subTestPhase) {
				consolePrint("Aquiring satellite data for calibration, press the Calib button if you do not want to wait for GPS lock... ");
				subTestPhase++;
			}
			else {
				if (millis() > progressTimer) {
					consolePrint(".");
					progressTimer = millis() + PROGRESS_TIMEOUT;
				}
			}
		}
		break;

	//BIST Testing - Streaming data from all sensors to console and BlueTooth
	case STREAM_SENSORDATA_TEST:
		ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
		ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
		ledcWrite(GREEN_LED_CH, (pow(2, resolution) - ledGreenLuminance));
		// GPS NMEA aquicition and parsing...
		getBarTempData(); 
		getGPSdata();
		getMPUdata();

		if (consoleCleanTimeout < millis()) {
			consoleCleanTimeout = millis() + (CONSOLE_CLEAN_TIME_SEC * 1000);
			consoleClear();
		}
		if (consoleRefreshTimeOut < millis() + 1) {
			//consoleClear(); TODO: Need to clear console every now and then
			consolePrint("\33[?3h", 1); //Set console to 132 columns
			consoleRefreshTimeOut = millis() + (CONSOLE_REFRESH_SEC * 1000);
			trimValues();
			char streamingOutputSting[132];
			consoleCursorPos(1, 1);
			consolePrint("\33[1m", 1);
			consolePrintln(               "GPS-TIME[UTC]       GPS-LCK  GPS-LAT[dg]  GPS-LON[Dg]  GPS-SPD[kn]  GPS-HD[deg]", 1);
			consolePrint("\33[1m", 1);
			consoleCursorPos(1, 2);
 			sprintf(streamingOutputSting, "%s:%s:%s %s:%s:%s   %s   %s  %s  %s         %s", GPSYearTxt, GPSMonthTxt, GPSDayTxt, GPSHourTxt, GPSMinuteTxt, GPSSecondsTxt, GPSStatusTxt, GPSLatTxt, GPSLonTxt, GPSSpeedTxt, GPSAngleTxt);
			consolePrintln(streamingOutputSting, 1);
			consoleCursorPos(1, 3);
			consolePrint("\33[1m", 1);
			consolePrintln(               "GPS-ALT[m]  GPS-VAR[m/s]  GPS-SATs", 1);
			consolePrint("\33[1m", 1);
			consoleCursorPos(1, 4);
			sprintf(streamingOutputSting, "%s      %s        %s", GPSAltitudeTxt, GPSVarTxt, GPSSatellitesTxt);
			consolePrintln(streamingOutputSting, 1);
			consoleCursorPos(1, 6);
			consolePrint("\33[1m", 1);
			consolePrintln(               "BAR-ALT[m]     BAR-VAR[m/s]  Temp[C]  Bar[hPA]", 1);
			consolePrint("\33[1m", 1);
			consoleCursorPos(1, 7);
			sprintf(streamingOutputSting, "%s          %s         %s    %s", barAltTxt, barVarTxt, tempTxt, barPresTxt);
			consolePrintln(streamingOutputSting, 1);
			consoleCursorPos(1, 9);
			consolePrint("\33[1m", 1);
			consolePrintln(               "Ptch[dg]       Roll[dg]       Yaw[dg]     Acc[g]", 1);
			consolePrint("\33[1m", 1);
			consoleCursorPos(1, 10);
			sprintf(streamingOutputSting, "%s         %s         %s      %s", pitchTxt, rollTxt, yawTxt, accXYZTxt);
			consolePrintln(streamingOutputSting, 1);
			consoleCursorPos(1, 11);
			consolePrint("\33[1m", 1);
			consolePrintln(               "Ptchrate[dg/s] Rollrate[dg/s] Yawrate[dg/s]", 1);
			consolePrint("\33[1m", 1);
			consoleCursorPos(1, 12);
			sprintf(streamingOutputSting, "%s         %s         %s", pitchRateTxt, rollRateTxt, yawRateTxt);
			consolePrintln(streamingOutputSting, 1);
			consoleCursorPos(1, 14);
			consolePrint("\33[1m", 1);
			consolePrintln(               "M-HDG[dg]    M-HDG RATE[dg/s]     M-Field[nT]     M-inc[dg]", 1);
			consolePrint("\33[1m", 1);
			consoleCursorPos(1, 15);
			sprintf(streamingOutputSting, "%s          %s               %s          %s", magHdgTxt, magHdgRateTxt, magXYZTxt, magInclTxt);
			consolePrintln(streamingOutputSting, 1);
			consoleCursorPos(1, 16);
		}
		delay(20);
		break;

	//BIST Testing failed
	//TODO: instrumenting Fault codes
	case FAIL_TEST:
		char errCodeTxt[3];
		sprintf(errCodeTxt, "Fault code : %d", bistFc);
		consolePrintln(errCodeTxt);
		consolePrintln("Self test FAILED - SPINNING.....");
		ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedLuminance));
		ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
		ledcWrite(GREEN_LED_CH, (pow(2, resolution) - 0));
		for (;;) {}
		break;

	default:
		testPhase++;
		break;
	}

	// BLE handling below
	// BLE disconnecting
	if (!deviceConnected && oldDeviceConnected) {
		delay(500); // give the bluetooth stack the chance to get things ready
		pServer->startAdvertising(); // restart advertising
		Serial.println("BLE device disconnected - advertiseing BLE again...");
		oldDeviceConnected = deviceConnected;
	}
	// BLE connecting
	if (deviceConnected && !oldDeviceConnected) {
		Serial.println("BLE device found - trying to connect...");
		oldDeviceConnected = deviceConnected;
	}
}
