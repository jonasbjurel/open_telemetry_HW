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
  *                        - LED ambers                                                               *
  *                        - BMP280 Barometic and temperature data                                    *
  *                        - MPU9250 9-axis intertial navigation sensor                               *
  *                        - L80-M39 GPS receiver                                                     *
  *                      the prime use-case for model air-craft on-board systems.                     *
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
/* Libray inclutions                                                                                  *
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
#include "lib/MPU9250-0.1.1/MPU9250.h"
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
/* ESP32 Huzza Feather PIN definitions (ESP32 Wroom)                                                  *
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
/* I/F and device object definitions                                                                  *
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
/* BIST testphases and reult codes                                                                    *
***************************************************************************************************** */ 
//Major BIST test phases
#define START_TEST 0
#define CALIB_BUTTON_TEST 1
#define STATUS_LED_TEST 2
#define BMP280 3
#define MPU9250 4
#define L80M39 5
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
#define BIST_FC_MPU9250_DETECT_BUT_NO_FUNCTION_FAIL 10
int bistFc = BIST_FC_SUCCESS;
char calibTextVal[10];
uint8_t mpuInterruptReceived = 0;

/* End BIST testphases and reult codes                                                                *
***************************************************************************************************** */

/* ****************************************************************************************************
/* Callib button and Status led definitions                                                           *
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
int ledRedAmber = 0;
int ledBlueAmber = 0;
int ledGreenAmber = 0;
int calibDebounce = 0;




/* ****************************************************************************************************
/* BMP280 Barometic and Temp definitions                                                              *
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
float barVarPeek;
float dBarVar;
int dTTot;
uint8_t barVarFilterIndex = 0;
float barAltFiltVector[20] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
int barDtFiltVector[20] = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
float barVarFiltVector[20] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

/* End BMP280 Barometic and Temp definitions                                                          *
***************************************************************************************************** */

/* ****************************************************************************************************
/* MPU9250 .... definitions                                                                           *
***************************************************************************************************** */
//MPU Definitions
#define MPU_READING_INTERVALL 20
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
/* ************************************************************************************************** */

/* ****************************************************************************************************
/* L80 - M39 GPS  .... definitions                                                                    *
***************************************************************************************************** */
//Definitions
#define GPS_NOLCK 0
#define GPS_ACC 1
#define DGPS_ACC 2
#define GPS3D_ACC 3
#define DGPS3D_ACC 4

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
uint8_t gpsUpdate;
uint8_t gpsStatus = 0;

/* END L80 - M39 GPS  .... definitions                                                                *
***************************************************************************************************** */

/* ****************************************************************************************************
/* BLE Server definitions                                                                             *
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


//Unstructured definitions - needs refactoring
unsigned long progressTimer;
#define PROGRESS_TIMEOUT 1000
unsigned long consoleRefreshTimeOut = 0;
#define CONSOLE_REFRESH_SEC 1

/* ****************************************************************************************************
/* MACROS                                                                                             *
***************************************************************************************************** */
#define SQR(X) (X *(X))
/* END MACROS                                                                                         *
***************************************************************************************************** */

//****************************** END DEFINITIONS AND DECLARATIONS ************************************* 


/* ****************************************************************************************************
/* BLE CLASSES, FUNCTIONS AND CALLBACKS                                                               *
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
/* CONSOLE & BLE OUTPUT & FORMATTING FUNCTIONS                                                        *
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

	sprintf(GPSYearTxt, "%d", GPS.year);

	if (GPS.month < 10)
		sprintf(GPSMonthTxt, "0%d", GPS.month);
	else
		sprintf(GPSMonthTxt, "%d", GPS.month);

	if (GPS.day < 10)
		sprintf(GPSDayTxt, "0%d", GPS.day);
	else
		sprintf(GPSDayTxt, "%d", GPS.day);

	if (GPS.hour < 10) 
		sprintf(GPSHourTxt, "0%d", GPS.hour);
	else
		sprintf(GPSHourTxt, "%d", GPS.hour);

	if (GPS.minute < 10)
		sprintf(GPSMinuteTxt, "0%d", GPS.minute);
	else
		sprintf(GPSMinuteTxt, "%d", GPS.minute);

	if (GPS.seconds < 10)
		sprintf(GPSSecondsTxt, "0%d", GPS.seconds);
	else
		sprintf(GPSSecondsTxt, "%d", GPS.seconds);

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
	sprintf(GPSLatTxt, "%f %c", GPS.latitudeDegrees, GPS.lat);
	sprintf(GPSLonTxt, "%f %c", GPS.longitudeDegrees, GPS.lon);
	if (GPS.speed < 10)
		sprintf(GPSSpeedTxt, "0%.1f", GPS.speed);
	else
		sprintf(GPSSpeedTxt, "%.1f", GPS.speed);

	if (GPS.angle < 10)
		sprintf(GPSAngleTxt, "00%.0f", GPS.angle);
	else if (GPS.angle < 100)
		sprintf(GPSAngleTxt, "0%.0f", GPS.angle);
	else 
		sprintf(GPSAngleTxt, "%.0f", GPS.angle);

	sprintf(GPSAltitudeTxt, "%+06.1f", GPS.altitude + GPSAltCalib);

	sprintf(GPSVarTxt, "%+05.1f", 0.0);

	sprintf(GPSSatellitesTxt, "%2d", GPS.satellites);

	sprintf(barAltTxt, "%+05.1f", barAlt);
	sprintf(barVarTxt, "%+05.2f", barVarPeek);
	barVarPeek = 0;
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

	//if (!(GPS.altitude < 0))
	//	sprintf(GPSAltitudeTxt, "+%.1f", GPS.altitude);
	//else
	//	sprintf(GPSAltitudeTxt, "%.1f", GPS.altitude);

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
/*CONSOLE& BLE OUTPUT & FORMATTING FUNCTIONS
****************************************************************************************************** */

/* ***************************************************************************************************
/* BMP280 fuctions                                                                                   *
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

	//if (abs(barVar) > abs(barVarPeek)) //Un-comment if periodic peek values wanted
		barVarPeek = barVar;
	return;
}


/* ***************************************************************************************************
/* MPU9250 fuctions                                                                                  *
****************************************************************************************************** */
//Callibrate
//  Propriatary Callibrate Mag
void magCalib(void) {
	//Ofset callibration, TODO implement X, Y, Z gain callibration if needed? 
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
		//Serial.println(magHdg);
	}
}

//Get MPU Interrupt
void IRAM_ATTR gotMpuInterrupt(void) {
	mpuInterruptReceived = 1;
	return;
}
/* END MPU9250 fuctions                                                                                *
****************************************************************************************************** */

/* ***************************************************************************************************
/* L80-M39 GPS functions                                                                               *
****************************************************************************************************** */
//Get GPS data
void getGPSdata(void) {
	GPS.read();
	if (GPS.newNMEAreceived()) {
		//consolePrintln("New NMEA received", 0);

		// a tricky thing here is if we print the NMEA sentence, or data
		// we end up not listening and catching other sentences!
		// so be very wary if using OUTPUT_ALLDATA and trying to print out data
		//Serial.println(GPS.lastNMEA()); // this also sets the newNMEAreceived() flag to false
		//Serial.println(GPS.lastNMEA());
		if (GPS.parse(GPS.lastNMEA())) {// this also sets the newNMEAreceived() flag to false
			gpsUpdate = 1;
			//consolePrintln("New NMEA message validated", 0);
		}
		else {
			//consolePrintln("New NMEA message invalidated", 0);
			gpsUpdate = 0;
		}
	}
	else {
		//consolePrint("No New NMEA received", 0);
	}

	//update GPS data or invalidate if no fix and more than 2 seconds old....
	if (!GPS.fix) {
		gpsStatus = 0; //"NO_LCK";
	}
	else if (GPS.fixquality) {
		switch (GPS.fixquality) {
		case 1:
			if (GPS.fixquality_3d != 3) {
				gpsStatus = 1; //"GPS2D ";
			}
			else {
				gpsStatus = 2; //"GPS3D ";
			}
			break;
		case 2:
			if (GPS.fixquality_3d != 3) {
				gpsStatus = 3; //"DGPS2D";
			}
			else {
				gpsStatus = 4; //"DGPS3D";
			}
			break;
		}
	}
}
/* END L80-M39 GPS functions                                                                           *
****************************************************************************************************** */


/* ***************************************************************************************************
/* ARDUINO SETUP                                                                                     *
****************************************************************************************************** */
//The setup function runs once when you press reset or power the board
void setup() {
	Serial.begin(115200);
	pinMode(CALIB_PIN, INPUT);

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

	// Start the service
	pService->start();

	// Start advertising
	pServer->getAdvertising()->start();
	Serial.println("Waiting for a Terminal Bluetooth client connection, notifying my presence as .....");

	ledcSetup(RED_LED_CH, freq, resolution);
	ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedAmber));
	ledcAttachPin(RED_LED_PIN, RED_LED_CH);
	
	ledcSetup(BLUE_LED_CH, freq, resolution);
	ledcWrite(BLUE_LED_CH, (pow(2, resolution) - ledBlueAmber));
	ledcAttachPin(BLUE_LED_PIN, BLUE_LED_CH);

	ledcSetup(GREEN_LED_CH, freq, resolution);
	ledcWrite(GREEN_LED_CH, (pow(2, resolution) - ledGreenAmber));
	ledcAttachPin(GREEN_LED_PIN, GREEN_LED_CH);

	I2C_0.begin(I2C_0_SDA_PIN, I2C_0_SCL_PIN, 100000);
	I2C_1.begin(I2C_1_SDA_PIN, I2C_1_SCL_PIN, 100000);

	GPS.begin(9600);
	GPSSerial.begin(9600, SERIAL_8N1, GPS_SERIAL_RXD_PIN, GPS_SERIAL_TXD_PIN);
	GPS.sendCommand(PMTK_SET_BAUD_115200);
	GPSSerial.flush(); // wait for last transmitted data to be sent 
	GPSSerial.begin(115200, SERIAL_8N1, GPS_SERIAL_RXD_PIN, GPS_SERIAL_TXD_PIN);
	while (GPSSerial.available()) Serial.read();
}

/* END ARDUINO SETUP                                                                                   *
****************************************************************************************************** */

/* ***************************************************************************************************
/* ARDUINO LOOP                                                                                     *
****************************************************************************************************** */

// the loop function runs over and over again forever
void loop() {
	switch (testPhase) {
	//BIST First introductionary test phase
	case START_TEST:
		consolePrintln("Selftest test for OpenFlightTelemetry OFT001v1 board");
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
			if (!ledRedAmber)
				consolePrintln("Calibrating status LEDs, starting with RED, press the calibration button when satisfied with the amber");

			if (!digitalRead(CALIB_PIN) || (ledRedAmber >= pow(2, resolution))) {
				consolePrint("RED led is calibrated to: ");
				gcvt((100 * ledRedAmber / pow(2, resolution)), 2, calibTextVal);
				consolePrint(calibTextVal);
				consolePrintln(" %");
				ledColorCalib++;
				calibDebounce = 1;
				delay(1000);
			}
			else {
				ledRedAmber++;
				ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedAmber));
				delay(100);
			}
			break;

		case 1:
			if (!ledBlueAmber) {
				consolePrintln("Continuing with BLUE, press the calibration button when satisfied with the amber");
			}
			if (!digitalRead(CALIB_PIN) || (ledBlueAmber >= pow(2, resolution))) {
				consolePrint("BLUE led is calibrated to: ");
				gcvt((100 * ledBlueAmber / pow(2, resolution)), 2, calibTextVal);
				consolePrint(calibTextVal);
				consolePrintln(" %");
				ledColorCalib++;
				calibDebounce = 1;
				delay(1000);
				ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
			}
			else {
				ledBlueAmber++;
				if (ledBlueAmber & 2) {
					ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
					ledcWrite(BLUE_LED_CH, (pow(2, resolution) - ledBlueAmber));
				}
				else {
					ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
					ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedAmber));
				}
				delay(100);
			}
			break;

		case 2:
			if (!ledGreenAmber) {
				consolePrintln("Continuing with GREEN, press the calibration button when satisfied with the amber");
			}
			if (!digitalRead(CALIB_PIN) || (ledGreenAmber >= pow(2, resolution))) {
				consolePrint("GREEN led is calibrated to: ");
				gcvt((100 * ledGreenAmber / pow(2, resolution)), 2, calibTextVal);
				consolePrint(calibTextVal);
				consolePrintln(" %");
				ledColorCalib++;
				delay(1000);
				ledcWrite(GREEN_LED_CH, (pow(2, resolution) - 0));
				ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
			}
			else {
				ledGreenAmber++;
				if (ledGreenAmber & 2) {
					ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
					ledcWrite(GREEN_LED_CH, (pow(2, resolution) - ledGreenAmber));
				}
				else {
					ledcWrite(GREEN_LED_CH, (pow(2, resolution) - 0));
					ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedAmber));
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
				ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedAmber));
				break;
			case 1:
				ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
				ledcWrite(BLUE_LED_CH, (pow(2, resolution) - ledBlueAmber));
				break;
			case 2:
				ledcWrite(GREEN_LED_CH, (pow(2, resolution) - ledGreenAmber));
				break;
			}
			delay(ledTestDelay);
			ledTestDelay = ledTestDelay * 0.9;
			if (ledTestDelay < 2) {
				ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedAmber));
				ledcWrite(BLUE_LED_CH, (pow(2, resolution) - ledBlueAmber));
				ledcWrite(GREEN_LED_CH, (pow(2, resolution) - ledGreenAmber));
				delay(1000);
				ledcWrite(RED_LED_CH, (pow(2, resolution) - 0));
				ledcWrite(BLUE_LED_CH, (pow(2, resolution) - 0));
				ledcWrite(GREEN_LED_CH, (pow(2, resolution) - 0));
				testPhase++;
				subTestPhase = 0;
			}
			break;
		}
		break;

	//BIST Testing the BMP280 barometic and temperature sensor
	case BMP280:
		if (!bmp.begin(BMP280_ADDR, BMP280_CID)) {
			consolePrintln("Self test FAILED - BMP280 Barometic sensor NOT found - FAIL");
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
	case MPU9250:
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
				testPhase = FAIL_TEST;
			}
			break;

		case 2:
			consolePrintln("Checking MPU9250 Interrupt line...");
			attachInterrupt(MPU_INTERRUPT_PIN, gotMpuInterrupt, FALLING);
			mpuInterruptTimeout = millis() + 1000;
			subTestPhase++;
			break;

		case 3:
			if (mpuInterruptReceived) {
				consolePrintln("MPU9250 Interrupt received - SUCCESS");
				detachInterrupt(MPU_INTERRUPT_PIN);
				testPhase++;
				subTestPhase = 0;
			}
			else {
				if (millis() > mpuInterruptTimeout) {
					consolePrintln("MPU9250 Interrupt NOT received - FAIL");
					testPhase = FAIL_TEST;
				}
			}
			break;
		}
		break;

	//BIST Testing the L8-M39 GPS receiver
	case L80M39:
		switch (subTestPhase) {
		case 0:
			consolePrintln("Checking GPS Module L80-M39");
			subTestPhase++;
			break;

		case 1:
			// uncomment this line to turn on RMC (recommended minimum) and GGA (fix data) including altitude
			//GPS.sendCommand(PMTK_SET_NMEA_OUTPUT_ALLDATA);
			GPS.sendCommand(PMTK_SET_NMEA_OUTPUT_RMCGGA);
			// Set the update rate
			GPS.sendCommand(PMTK_SET_NMEA_UPDATE_1HZ);
			GPS.sendCommand(PMTK_Q_RELEASE);
			subTestPhase++;
			timeout = millis() + 2000;
		case 2:
			GPS.read();
			if (GPS.newNMEAreceived()) {
				//Serial.println("New NMEA Arrived");
				gpsReceiveData = 1;
				//Serial.print(GPS.lastNMEA());
				if (strncmp("$PMTK705", GPS.lastNMEA(), strlen("$PMTK705")) == 0) {
					consolePrintln("L80-M39 GPS module found - SUCCESS");
					testPhase++;
					subTestPhase = 0;
					timeout = 0;
					break;
				}
				if (millis() > timeout && gpsReceiveData) {
					consolePrintln("Self test FAILED - L80-M39 GPS module found but NOT functional - FAIL");
					testPhase = FAIL_TEST;
					subTestPhase = 0;
					break;
				}
			}
			if (!gpsReceiveData && (millis() > timeout)) {
				consolePrintln("Self test FAILED - L80-M39 GPS module NOT found - FAILED");
				testPhase = FAIL_TEST;
				subTestPhase = 0;
				break;
			}
			break;
		}
		break;

	//BIST Testing Successful
	case SUCCESS_TEST:
		GPS.read();
		if (GPS.newNMEAreceived())
			GPS.parse(GPS.lastNMEA());
		if (GPS.fix && (GPSAltCalib = GPS.altitude)) {
			consolePrintln("Satelites aquired, Calibrating the system....");
			BarTempCalib();
			mpu.calibrateAccelGyro();
			magCalib();

			consolePrintln("Calibration done, streaming data...");
			timeout = 0;
			subTestPhase = 0;
			testPhase++;
		}
		else {
			if (!subTestPhase) {
				consolePrint("Aquiring satellite data for calibration...");
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
		// GPS NMEA acuicition and parsing...
		getBarTempData(); 
		getGPSdata();
		getMPUdata();

		//TODO: Consider below into a coroutine
		if (consoleRefreshTimeOut < millis() + 1) {
			consoleClear();
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
		consolePrint("Self test FAILED - SPINNING.....");
		ledcWrite(RED_LED_CH, (pow(2, resolution) - ledRedAmber));
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
	//Serial.println("looping");
}
