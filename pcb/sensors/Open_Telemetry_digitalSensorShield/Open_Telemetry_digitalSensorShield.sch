EESchema Schematic File Version 4
LIBS:Open_Telemetry_digitalSensorShield-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:Conn_01x16_Female J3
U 1 1 5DB7F77A
P 10200 5450
F 0 "J3" H 10228 5426 50  0000 L CNN
F 1 "Conn_01x16_Female" H 10228 5335 50  0000 L CNN
F 2 "Open_Telemetry:PinHeader_1x16_P2.54mm_Vertical_Down" H 10200 5450 50  0001 C CNN
F 3 "~" H 10200 5450 50  0001 C CNN
	1    10200 5450
	1    0    0    -1  
$EndComp
Text Notes 8950 4600 0    79   ~ 16
ESP32 HAT/SHIELD CONNECTIONS
$Comp
L Connector:Conn_01x12_Female J2
U 1 1 5DB7AEF5
P 8450 5300
F 0 "J2" H 8478 5276 50  0000 L CNN
F 1 "Conn_01x12_Female" H 8478 5185 50  0000 L CNN
F 2 "Open_Telemetry:PinHeader_1x12_P2.54mm_Vertical_Down" H 8450 5300 50  0001 C CNN
F 3 "~" H 8450 5300 50  0001 C CNN
	1    8450 5300
	1    0    0    -1  
$EndComp
Text Notes 9700 2050 0    79   ~ 16
Buttons & lights
Text GLabel 10650 2400 1    50   Input ~ 0
CALIB
$Comp
L power:+3.3V #PWR021
U 1 1 5DC22D01
P 9050 4200
F 0 "#PWR021" H 9050 4050 50  0001 C CNN
F 1 "+3.3V" H 9065 4373 50  0000 C CNN
F 2 "" H 9050 4200 50  0001 C CNN
F 3 "" H 9050 4200 50  0001 C CNN
	1    9050 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 3550 9100 3500
Wire Wire Line
	9100 3500 9000 3500
Wire Wire Line
	9000 3500 9000 3450
Wire Wire Line
	9300 3550 9300 3450
Wire Wire Line
	9500 3550 9500 3500
Wire Wire Line
	9500 3500 9600 3500
Wire Wire Line
	9600 3500 9600 3450
Text GLabel 9000 2650 1    50   Input ~ 0
BLUE_LED
Text GLabel 9300 2650 1    50   Input ~ 0
GREEN_LED
Text GLabel 9600 2650 1    50   Input ~ 0
RED_LED
Wire Wire Line
	9050 4250 9050 4200
Wire Wire Line
	9300 4250 9050 4250
Wire Wire Line
	9300 3950 9300 4250
$Comp
L power:GND #PWR018
U 1 1 5DDC7A71
P 8200 4050
F 0 "#PWR018" H 8200 3800 50  0001 C CNN
F 1 "GND" H 8205 3877 50  0000 C CNN
F 2 "" H 8200 4050 50  0001 C CNN
F 3 "" H 8200 4050 50  0001 C CNN
	1    8200 4050
	1    0    0    -1  
$EndComp
Text GLabel 8200 2650 1    50   Input ~ 0
SAT_LOCK
$Comp
L power:GND #PWR017
U 1 1 5DF81550
P 7500 4050
F 0 "#PWR017" H 7500 3800 50  0001 C CNN
F 1 "GND" H 7505 3877 50  0000 C CNN
F 2 "" H 7500 4050 50  0001 C CNN
F 3 "" H 7500 4050 50  0001 C CNN
	1    7500 4050
	1    0    0    -1  
$EndComp
Text GLabel 7500 2650 1    50   Input ~ 0
EXT_ANT
Wire Notes Line
	7950 1950 10750 1950
Wire Notes Line
	11100 6400 11100 4450
Wire Notes Line
	10900 4350 8100 4350
Wire Notes Line
	11100 2250 11100 4350
$Comp
L power:GNDA #PWR019
U 1 1 5DF5AEC2
P 8600 1450
F 0 "#PWR019" H 8600 1200 50  0001 C CNN
F 1 "GNDA" H 8605 1277 50  0000 C CNN
F 2 "" H 8600 1450 50  0001 C CNN
F 3 "" H 8600 1450 50  0001 C CNN
	1    8600 1450
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR023
U 1 1 5DCB44C2
P 9500 800
F 0 "#PWR023" H 9500 650 50  0001 C CNN
F 1 "+3.3V" H 9515 973 50  0000 C CNN
F 2 "" H 9500 800 50  0001 C CNN
F 3 "" H 9500 800 50  0001 C CNN
	1    9500 800 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR025
U 1 1 5DCC7040
P 10200 1450
F 0 "#PWR025" H 10200 1200 50  0001 C CNN
F 1 "GND" H 10205 1277 50  0000 C CNN
F 2 "" H 10200 1450 50  0001 C CNN
F 3 "" H 10200 1450 50  0001 C CNN
	1    10200 1450
	1    0    0    -1  
$EndComp
Text Notes 8250 750  0    79   ~ 16
Power distribution
Text Notes 700  850  0    79   ~ 16
GPS positioning
Wire Wire Line
	2000 1650 2750 1650
Connection ~ 2000 1650
Wire Wire Line
	2000 1750 2000 1650
Wire Wire Line
	5450 1700 5550 1700
Wire Wire Line
	5450 1650 5450 1700
Wire Wire Line
	4550 2150 4550 2250
Connection ~ 5850 2150
Wire Wire Line
	5850 2150 5850 2250
Wire Wire Line
	5850 2050 5850 2150
$Comp
L power:GNDA #PWR014
U 1 1 5DF19E9E
P 5850 2250
F 0 "#PWR014" H 5850 2000 50  0001 C CNN
F 1 "GNDA" H 5855 2077 50  0000 C CNN
F 2 "" H 5850 2250 50  0001 C CNN
F 3 "" H 5850 2250 50  0001 C CNN
	1    5850 2250
	1    0    0    -1  
$EndComp
$Comp
L power:GNDA #PWR010
U 1 1 5DF19109
P 4550 2250
F 0 "#PWR010" H 4550 2000 50  0001 C CNN
F 1 "GNDA" H 4555 2077 50  0000 C CNN
F 2 "" H 4550 2250 50  0001 C CNN
F 3 "" H 4550 2250 50  0001 C CNN
	1    4550 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 1750 4550 2050
Wire Wire Line
	4150 1750 4550 1750
$Comp
L 73412-0110:73412-0110 J1
U 1 1 5DF0F789
P 4550 2050
F 0 "J1" H 5200 2315 50  0000 C CNN
F 1 "73412-0110" H 5200 2224 50  0000 C CNN
F 2 "Open_Telemetry:U.FL_Molex_MCRF_73412-0110_Vertical" H 5700 2150 50  0001 L CNN
F 3 "http://www.molex.com/pdm_docs/sd/734120110_sd.pdf" H 5700 2050 50  0001 L CNN
F 4 "50 Ohms, MCRF, PCB Vertical Jack Receptacle, SMT, 1.25mm Mounted Height" H 5700 1950 50  0001 L CNN "Description"
F 5 "" H 5700 1850 50  0001 L CNN "Height"
F 6 "Molex" H 5700 1750 50  0001 L CNN "Manufacturer_Name"
F 7 "73412-0110" H 5700 1650 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "538-73412-0110" H 5700 1550 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=538-73412-0110" H 5700 1450 50  0001 L CNN "Mouser Price/Stock"
F 10 "7025425P" H 5700 1350 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/7025425P" H 5700 1250 50  0001 L CNN "RS Price/Stock"
F 12 "70357960" H 5700 1150 50  0001 L CNN "Allied_Number"
F 13 "https://www.alliedelec.com/molex-incorporated-73412-0110/70357960/" H 5700 1050 50  0001 L CNN "Allied Price/Stock"
	1    4550 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 2300 3650 2300
Wire Wire Line
	4350 2050 4350 2300
$Comp
L power:+3.3V #PWR09
U 1 1 5DF049BD
P 4350 2050
F 0 "#PWR09" H 4350 1900 50  0001 C CNN
F 1 "+3.3V" H 4365 2223 50  0000 C CNN
F 2 "" H 4350 2050 50  0001 C CNN
F 3 "" H 4350 2050 50  0001 C CNN
	1    4350 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 1850 4150 2150
Wire Wire Line
	5450 1050 5450 1250
$Comp
L power:+3.3V #PWR011
U 1 1 5DE47C54
P 5450 1050
F 0 "#PWR011" H 5450 900 50  0001 C CNN
F 1 "+3.3V" H 5465 1223 50  0000 C CNN
F 2 "" H 5450 1050 50  0001 C CNN
F 3 "" H 5450 1050 50  0001 C CNN
	1    5450 1050
	1    0    0    -1  
$EndComp
Text GLabel 5550 1700 2    50   Output ~ 0
EXT_ANT
$Comp
L power:+3.3V #PWR08
U 1 1 5DE2759E
P 4000 950
F 0 "#PWR08" H 4000 800 50  0001 C CNN
F 1 "+3.3V" H 4015 1123 50  0000 C CNN
F 2 "" H 4000 950 50  0001 C CNN
F 3 "" H 4000 950 50  0001 C CNN
	1    4000 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 1450 5150 1450
Connection ~ 5000 1450
Wire Wire Line
	4850 1450 5000 1450
$Comp
L Transistor_BJT:BC846BPN Q1
U 2 1 5DE09AF2
P 5350 1450
F 0 "Q1" H 5541 1404 50  0000 L CNN
F 1 "BC846BPN" H 5541 1495 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 5550 1550 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BC846BPN.pdf" H 5350 1450 50  0001 C CNN
	2    5350 1450
	1    0    0    1   
$EndComp
$Comp
L L80-M39:L80-M39 IC1
U 1 1 5DCCFD3F
P 2750 1350
F 0 "IC1" H 3450 1615 50  0000 C CNN
F 1 "L80-M39" H 3450 1524 50  0000 C CNN
F 2 "L80-M39" H 4000 1450 50  0001 L CNN
F 3 "http://docs-emea.rs-online.com/webdocs/147d/0900766b8147dbf2.pdf" H 4000 1350 50  0001 L CNN
F 4 "L80 GPS Module" H 4000 1250 50  0001 L CNN "Description"
F 5 "" H 4000 1150 50  0001 L CNN "Height"
F 6 "Quectel" H 4000 1050 50  0001 L CNN "Manufacturer_Name"
F 7 "L80-M39" H 4000 950 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "" H 4000 850 50  0001 L CNN "Mouser Part Number"
F 9 "" H 4000 750 50  0001 L CNN "Mouser Price/Stock"
F 10 "9084088" H 4000 650 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/9084088" H 4000 550 50  0001 L CNN "RS Price/Stock"
	1    2750 1350
	1    0    0    -1  
$EndComp
Text GLabel 4300 1650 2    50   Input ~ 0
RESET
Wire Wire Line
	4300 1650 4150 1650
$Comp
L power:GND #PWR02
U 1 1 5DCE95A0
P 800 2250
F 0 "#PWR02" H 800 2000 50  0001 C CNN
F 1 "GND" H 805 2077 50  0000 C CNN
F 2 "" H 800 2250 50  0001 C CNN
F 3 "" H 800 2250 50  0001 C CNN
	1    800  2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	800  2150 800  2250
Wire Wire Line
	1900 1350 2750 1350
Wire Wire Line
	1900 1450 2750 1450
Wire Notes Line
	11100 600  8200 600 
Wire Notes Line
	8200 600  8200 1650
Wire Notes Line
	11100 1650 11100 600 
Wire Notes Line
	6900 4450 11150 4450
Text GLabel 9750 6250 0    50   BiDi ~ 0
RESET
Wire Wire Line
	9750 6250 10000 6250
Text GLabel 9750 4750 0    50   Input ~ 0
INT_0
$Comp
L power:+3.3V #PWR020
U 1 1 5E099201
P 8700 6150
F 0 "#PWR020" H 8700 6000 50  0001 C CNN
F 1 "+3.3V" H 8715 6323 50  0000 C CNN
F 2 "" H 8700 6150 50  0001 C CNN
F 3 "" H 8700 6150 50  0001 C CNN
	1    8700 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 6150 8700 6150
$Comp
L power:GND #PWR022
U 1 1 5E0A2747
P 9150 6200
F 0 "#PWR022" H 9150 5950 50  0001 C CNN
F 1 "GND" H 9155 6027 50  0000 C CNN
F 2 "" H 9150 6200 50  0001 C CNN
F 3 "" H 9150 6200 50  0001 C CNN
	1    9150 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9750 4750 10000 4750
Text GLabel 8000 5800 0    50   Output ~ 0
I2C_0_SCL_3V
Wire Wire Line
	8000 5800 8250 5800
Text GLabel 8000 5900 0    50   BiDi ~ 0
I2C_0_SDA_3V
Wire Wire Line
	8000 5900 8250 5900
Text GLabel 9750 4850 0    50   BiDi ~ 0
I2C_1_SDA_3V
Wire Wire Line
	9750 4950 10000 4950
Text GLabel 9750 4950 0    50   Output ~ 0
I2C_1_SCL_3V
Wire Wire Line
	9750 4850 10000 4850
Text GLabel 9750 5550 0    50   Input ~ 0
UART_1_CLIENT_RXD
Text GLabel 9750 5650 0    50   Input ~ 0
UART_1_CLIENT_TXD
Wire Wire Line
	9750 5550 10000 5550
Wire Wire Line
	9750 5650 10000 5650
Text GLabel 9800 5350 0    50   Input ~ 0
CALIB
Text GLabel 7950 5100 0    50   Output ~ 0
RED_LED
Wire Wire Line
	7950 5100 8250 5100
Text GLabel 7950 5300 0    50   Output ~ 0
GREEN_LED
Wire Wire Line
	9800 5350 10000 5350
Text GLabel 7950 5200 0    50   Output ~ 0
BLUE_LED
Wire Wire Line
	8250 5200 7950 5200
Wire Wire Line
	8250 5300 7950 5300
Wire Wire Line
	2000 1750 2750 1750
$Comp
L T491B106K016AT7280:T491B106K016AT7280 C6
U 1 1 5E18F403
P 8350 950
F 0 "C6" V 8554 1080 50  0000 L CNN
F 1 "10uF" V 8645 1080 50  0000 L CNN
F 2 "CAPPM3528X210N" H 8700 1000 50  0001 L CNN
F 3 "https://api.kemet.com/component-edge/download/datasheet/T491B106K016AT7280.pdf" H 8700 900 50  0001 L CNN
F 4 "Tantalum Capacitors - Solid SMD 16V 10uF 1311 10% ESR=2ohms" H 8700 800 50  0001 L CNN "Description"
F 5 "2.1" H 8700 700 50  0001 L CNN "Height"
F 6 "Kemet" H 8700 600 50  0001 L CNN "Manufacturer_Name"
F 7 "T491B106K016AT7280" H 8700 500 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "80-T491B106K16AT7280" H 8700 400 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=80-T491B106K16AT7280" H 8700 300 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 8700 200 50  0001 L CNN "RS Part Number"
F 11 "" H 8700 100 50  0001 L CNN "RS Price/Stock"
	1    8350 950 
	0    1    1    0   
$EndComp
Wire Wire Line
	8350 1450 8600 1450
Connection ~ 8600 1450
$Comp
L T491B106K016AT7280:T491B106K016AT7280 C7
U 1 1 5E25E078
P 9950 850
F 0 "C7" V 10154 980 50  0000 L CNN
F 1 "10uF" V 10245 980 50  0000 L CNN
F 2 "CAPPM3528X210N" H 10300 900 50  0001 L CNN
F 3 "https://api.kemet.com/component-edge/download/datasheet/T491B106K016AT7280.pdf" H 10300 800 50  0001 L CNN
F 4 "Tantalum Capacitors - Solid SMD 16V 10uF 1311 10% ESR=2ohms" H 10300 700 50  0001 L CNN "Description"
F 5 "2.1" H 10300 600 50  0001 L CNN "Height"
F 6 "Kemet" H 10300 500 50  0001 L CNN "Manufacturer_Name"
F 7 "T491B106K016AT7280" H 10300 400 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "80-T491B106K16AT7280" H 10300 300 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=80-T491B106K16AT7280" H 10300 200 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 10300 100 50  0001 L CNN "RS Part Number"
F 11 "" H 10300 0   50  0001 L CNN "RS Price/Stock"
	1    9950 850 
	0    1    1    0   
$EndComp
$Comp
L T491B106K016AT7280:T491B106K016AT7280 C8
U 1 1 5E25F87E
P 10400 850
F 0 "C8" V 10604 980 50  0000 L CNN
F 1 "10uF" V 10695 980 50  0000 L CNN
F 2 "CAPPM3528X210N" H 10750 900 50  0001 L CNN
F 3 "https://api.kemet.com/component-edge/download/datasheet/T491B106K016AT7280.pdf" H 10750 800 50  0001 L CNN
F 4 "Tantalum Capacitors - Solid SMD 16V 10uF 1311 10% ESR=2ohms" H 10750 700 50  0001 L CNN "Description"
F 5 "2.1" H 10750 600 50  0001 L CNN "Height"
F 6 "Kemet" H 10750 500 50  0001 L CNN "Manufacturer_Name"
F 7 "T491B106K016AT7280" H 10750 400 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "80-T491B106K16AT7280" H 10750 300 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=80-T491B106K16AT7280" H 10750 200 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 10750 100 50  0001 L CNN "RS Part Number"
F 11 "" H 10750 0   50  0001 L CNN "RS Price/Stock"
	1    10400 850 
	0    1    1    0   
$EndComp
Wire Wire Line
	10400 1350 10200 1350
Wire Wire Line
	10200 1350 10200 1450
Connection ~ 10200 1350
Wire Wire Line
	10200 1350 9950 1350
Connection ~ 10200 1450
Wire Wire Line
	9500 850  9500 800 
Connection ~ 9500 850 
Wire Wire Line
	9500 850  9950 850 
Wire Wire Line
	9950 850  10400 850 
Connection ~ 9950 850 
Wire Wire Line
	8350 950  8350 850 
$Comp
L C0603C103K4RACTU:C0603C103K4RACTU C3
U 1 1 5E34E85C
P 1900 1650
F 0 "C3" V 2104 1778 50  0000 L CNN
F 1 "10nF" V 2195 1778 50  0000 L CNN
F 2 "CAPC1608X87N" H 2250 1700 50  0001 L CNN
F 3 "https://api.kemet.com/component-edge/download/datasheet/C0603C103K4RACTU.pdf" H 2250 1600 50  0001 L CNN
F 4 "KEMET - C0603C103K4RACTU - CAP, 0.01F, 16V, 10%, X7R, 0603" H 2250 1500 50  0001 L CNN "Description"
F 5 "0.87" H 2250 1400 50  0001 L CNN "Height"
F 6 "Kemet" H 2250 1300 50  0001 L CNN "Manufacturer_Name"
F 7 "C0603C103K4RACTU" H 2250 1200 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "80-C0603C103K4R" H 2250 1100 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=80-C0603C103K4R" H 2250 1000 50  0001 L CNN "Mouser Price/Stock"
F 10 "1464174" H 2250 900 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/1464174" H 2250 800 50  0001 L CNN "RS Price/Stock"
F 12 "70097263" H 2250 700 50  0001 L CNN "Allied_Number"
F 13 "https://www.alliedelec.com/kemet-c0603c103k4ractu/70097263/" H 2250 600 50  0001 L CNN "Allied Price/Stock"
	1    1900 1650
	0    1    1    0   
$EndComp
$Comp
L RC0201JR-071KL:RC0201JR-071KL R11
U 1 1 5E3E833E
P 7500 2750
F 0 "R11" H 7850 2975 50  0000 C CNN
F 1 "1k" H 7850 2884 50  0000 C CNN
F 2 "RESC0603X26N" H 8050 2800 50  0001 L CNN
F 3 "https://www.digikey.se/en/datasheets/yageo/yageo-pyu-r_marking_2" H 8050 2700 50  0001 L CNN
F 4 "YAGEO - RC0201JR-071KL - RES, THICK FILM, 1K, 5%, 0.5W, 0201, REEL" H 8050 2600 50  0001 L CNN "Description"
F 5 "0.26" H 8050 2500 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 8050 2400 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-071KL" H 8050 2300 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-071KL" H 8050 2200 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-071KL" H 8050 2100 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 8050 2000 50  0001 L CNN "RS Part Number"
F 11 "" H 8050 1900 50  0001 L CNN "RS Price/Stock"
	1    7500 2750
	0    1    1    0   
$EndComp
$Comp
L RC0201JR-071KL:RC0201JR-071KL R12
U 1 1 5E461325
P 8200 2750
F 0 "R12" H 8550 2975 50  0000 C CNN
F 1 "1k" H 8550 2884 50  0000 C CNN
F 2 "RESC0603X26N" H 8750 2800 50  0001 L CNN
F 3 "https://www.digikey.se/en/datasheets/yageo/yageo-pyu-r_marking_2" H 8750 2700 50  0001 L CNN
F 4 "YAGEO - RC0201JR-071KL - RES, THICK FILM, 1K, 5%, 0.5W, 0201, REEL" H 8750 2600 50  0001 L CNN "Description"
F 5 "0.26" H 8750 2500 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 8750 2400 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-071KL" H 8750 2300 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-071KL" H 8750 2200 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-071KL" H 8750 2100 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 8750 2000 50  0001 L CNN "RS Part Number"
F 11 "" H 8750 1900 50  0001 L CNN "RS Price/Stock"
	1    8200 2750
	0    1    1    0   
$EndComp
$Comp
L RC0201JR-071KL:RC0201JR-071KL R13
U 1 1 5E4617BC
P 9000 2750
F 0 "R13" H 9350 2975 50  0000 C CNN
F 1 "1k" H 9350 2884 50  0000 C CNN
F 2 "RESC0603X26N" H 9550 2800 50  0001 L CNN
F 3 "https://www.digikey.se/en/datasheets/yageo/yageo-pyu-r_marking_2" H 9550 2700 50  0001 L CNN
F 4 "YAGEO - RC0201JR-071KL - RES, THICK FILM, 1K, 5%, 0.5W, 0201, REEL" H 9550 2600 50  0001 L CNN "Description"
F 5 "0.26" H 9550 2500 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 9550 2400 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-071KL" H 9550 2300 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-071KL" H 9550 2200 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-071KL" H 9550 2100 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 9550 2000 50  0001 L CNN "RS Part Number"
F 11 "" H 9550 1900 50  0001 L CNN "RS Price/Stock"
	1    9000 2750
	0    1    1    0   
$EndComp
$Comp
L RC0201JR-071KL:RC0201JR-071KL R14
U 1 1 5E461B97
P 9300 2750
F 0 "R14" H 9650 2975 50  0000 C CNN
F 1 "1k" H 9650 2884 50  0000 C CNN
F 2 "RESC0603X26N" H 9850 2800 50  0001 L CNN
F 3 "https://www.digikey.se/en/datasheets/yageo/yageo-pyu-r_marking_2" H 9850 2700 50  0001 L CNN
F 4 "YAGEO - RC0201JR-071KL - RES, THICK FILM, 1K, 5%, 0.5W, 0201, REEL" H 9850 2600 50  0001 L CNN "Description"
F 5 "0.26" H 9850 2500 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 9850 2400 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-071KL" H 9850 2300 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-071KL" H 9850 2200 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-071KL" H 9850 2100 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 9850 2000 50  0001 L CNN "RS Part Number"
F 11 "" H 9850 1900 50  0001 L CNN "RS Price/Stock"
	1    9300 2750
	0    1    1    0   
$EndComp
$Comp
L RC0201JR-071KL:RC0201JR-071KL R15
U 1 1 5E46211C
P 9600 2750
F 0 "R15" H 9950 2975 50  0000 C CNN
F 1 "1k" H 9950 2884 50  0000 C CNN
F 2 "RESC0603X26N" H 10150 2800 50  0001 L CNN
F 3 "https://www.digikey.se/en/datasheets/yageo/yageo-pyu-r_marking_2" H 10150 2700 50  0001 L CNN
F 4 "YAGEO - RC0201JR-071KL - RES, THICK FILM, 1K, 5%, 0.5W, 0201, REEL" H 10150 2600 50  0001 L CNN "Description"
F 5 "0.26" H 10150 2500 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 10150 2400 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-071KL" H 10150 2300 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-071KL" H 10150 2200 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-071KL" H 10150 2100 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 10150 2000 50  0001 L CNN "RS Part Number"
F 11 "" H 10150 1900 50  0001 L CNN "RS Price/Stock"
	1    9600 2750
	0    1    1    0   
$EndComp
Wire Wire Line
	9600 2650 9600 2750
Wire Wire Line
	9300 2650 9300 2750
Wire Wire Line
	9000 2650 9000 2750
Wire Wire Line
	8200 2650 8200 2750
Wire Wire Line
	7500 2650 7500 2750
$Comp
L RC0201JR-071KL:RC0201JR-071KL R3
U 1 1 5E4B2E6B
P 2350 2500
F 0 "R3" H 2700 2725 50  0000 C CNN
F 1 "1k" H 2700 2634 50  0000 C CNN
F 2 "RESC0603X26N" H 2900 2550 50  0001 L CNN
F 3 "https://www.digikey.se/en/datasheets/yageo/yageo-pyu-r_marking_2" H 2900 2450 50  0001 L CNN
F 4 "YAGEO - RC0201JR-071KL - RES, THICK FILM, 1K, 5%, 0.5W, 0201, REEL" H 2900 2350 50  0001 L CNN "Description"
F 5 "0.26" H 2900 2250 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 2900 2150 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-071KL" H 2900 2050 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-071KL" H 2900 1950 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-071KL" H 2900 1850 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 2900 1750 50  0001 L CNN "RS Part Number"
F 11 "" H 2900 1650 50  0001 L CNN "RS Price/Stock"
	1    2350 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 2700 3650 2900
Wire Wire Line
	3650 2900 3800 2900
Text GLabel 3800 2900 2    50   Input ~ 0
SAT_LOCK
$Comp
L power:GND #PWR05
U 1 1 5DD5DE88
P 2350 2950
F 0 "#PWR05" H 2350 2700 50  0001 C CNN
F 1 "GND" H 2355 2777 50  0000 C CNN
F 2 "" H 2350 2950 50  0001 C CNN
F 3 "" H 2350 2950 50  0001 C CNN
	1    2350 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 2500 3350 2500
Connection ~ 3200 2500
Wire Wire Line
	3050 2500 3200 2500
$Comp
L Transistor_BJT:BC846BPN Q1
U 1 1 5DD4D3FC
P 3550 2500
F 0 "Q1" H 3741 2546 50  0000 L CNN
F 1 "BC846BPN" H 3741 2455 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-363_SC-70-6" H 3750 2600 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BC846BPN.pdf" H 3550 2500 50  0001 C CNN
	1    3550 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 2500 2350 1850
Wire Wire Line
	2350 1850 2750 1850
$Comp
L RC0201JR-071KL:RC0201JR-071KL R7
U 1 1 5E50BE0C
P 4150 1450
F 0 "R7" H 4500 1675 50  0000 C CNN
F 1 "1k" H 4500 1584 50  0000 C CNN
F 2 "RESC0603X26N" H 4700 1500 50  0001 L CNN
F 3 "https://www.digikey.se/en/datasheets/yageo/yageo-pyu-r_marking_2" H 4700 1400 50  0001 L CNN
F 4 "YAGEO - RC0201JR-071KL - RES, THICK FILM, 1K, 5%, 0.5W, 0201, REEL" H 4700 1300 50  0001 L CNN "Description"
F 5 "0.26" H 4700 1200 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 4700 1100 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-071KL" H 4700 1000 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-071KL" H 4700 900 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-071KL" H 4700 800 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 4700 700 50  0001 L CNN "RS Part Number"
F 11 "" H 4700 600 50  0001 L CNN "RS Price/Stock"
	1    4150 1450
	1    0    0    -1  
$EndComp
$Comp
L RC0201JR-07100KL:RC0201JR-07100KL R4
U 1 1 5E93D9F6
P 2350 2850
F 0 "R4" H 2700 3075 50  0000 C CNN
F 1 "100k" H 2700 2984 50  0000 C CNN
F 2 "RESC0603X26N" H 2900 2900 50  0001 L CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RC0201_51_RoHS_L_8.pdf" H 2900 2800 50  0001 L CNN
F 4 "YAGEO - RC0201JR-07100KL - RES, THICK FILM, 100K, 5%, 0.5W, 0201" H 2900 2700 50  0001 L CNN "Description"
F 5 "0.26" H 2900 2600 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 2900 2500 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-07100KL" H 2900 2400 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-07100KL" H 2900 2300 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-07100KL" H 2900 2200 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 2900 2100 50  0001 L CNN "RS Part Number"
F 11 "" H 2900 2000 50  0001 L CNN "RS Price/Stock"
	1    2350 2850
	1    0    0    -1  
$EndComp
Wire Notes Line
	8200 1650 11100 1650
$Comp
L RC0201JR-07100KL:RC0201JR-07100KL R6
U 1 1 5E948864
P 4150 1050
F 0 "R6" H 4500 1275 50  0000 C CNN
F 1 "100k" H 4500 1184 50  0000 C CNN
F 2 "RESC0603X26N" H 4700 1100 50  0001 L CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RC0201_51_RoHS_L_8.pdf" H 4700 1000 50  0001 L CNN
F 4 "YAGEO - RC0201JR-07100KL - RES, THICK FILM, 100K, 5%, 0.5W, 0201" H 4700 900 50  0001 L CNN "Description"
F 5 "0.26" H 4700 800 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 4700 700 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-07100KL" H 4700 600 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-07100KL" H 4700 500 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-07100KL" H 4700 400 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 4700 300 50  0001 L CNN "RS Part Number"
F 11 "" H 4700 200 50  0001 L CNN "RS Price/Stock"
	1    4150 1050
	1    0    0    -1  
$EndComp
Wire Notes Line
	6000 700  650  700 
Wire Wire Line
	5000 1050 4850 1050
Wire Wire Line
	4150 1050 4000 1050
Wire Wire Line
	4000 1050 4000 950 
Wire Wire Line
	5000 1050 5000 1450
Wire Wire Line
	2350 2850 2350 2950
Wire Wire Line
	3050 2850 3200 2850
Wire Wire Line
	3200 2500 3200 2850
Wire Wire Line
	2350 4500 2350 5000
$Comp
L RC0201JR-070RL:RC0201JR-070RL R8
U 1 1 5E952D3B
P 4450 4350
F 0 "R8" V 4754 4438 50  0000 L CNN
F 1 "NULL" V 4845 4438 50  0000 L CNN
F 2 "RESC0603X26N" H 5000 4400 50  0001 L CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RC0201_51_RoHS_L_8.pdf" H 5000 4300 50  0001 L CNN
F 4 "YAGEO (PHYCOMP) - RC0201JR-070RL - RES, THICK FILM, 0R, 5%, 0.05W, 0201" H 5000 4200 50  0001 L CNN "Description"
F 5 "0.26" H 5000 4100 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 5000 4000 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-070RL" H 5000 3900 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-070RL" H 5000 3800 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-070RL" H 5000 3700 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 5000 3600 50  0001 L CNN "RS Part Number"
F 11 "" H 5000 3500 50  0001 L CNN "RS Price/Stock"
	1    4450 4350
	0    1    1    0   
$EndComp
$Comp
L RC0201JR-070RL:RC0201JR-070RL R5
U 1 1 5E950BB8
P 2350 4500
F 0 "R5" H 2700 4725 50  0000 C CNN
F 1 "NULL" H 2700 4634 50  0000 C CNN
F 2 "RESC0603X26N" H 2900 4550 50  0001 L CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RC0201_51_RoHS_L_8.pdf" H 2900 4450 50  0001 L CNN
F 4 "YAGEO (PHYCOMP) - RC0201JR-070RL - RES, THICK FILM, 0R, 5%, 0.05W, 0201" H 2900 4350 50  0001 L CNN "Description"
F 5 "0.26" H 2900 4250 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 2900 4150 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-070RL" H 2900 4050 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-070RL" H 2900 3950 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-070RL" H 2900 3850 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 2900 3750 50  0001 L CNN "RS Part Number"
F 11 "" H 2900 3650 50  0001 L CNN "RS Price/Stock"
	1    2350 4500
	1    0    0    -1  
$EndComp
Connection ~ 4450 5300
Wire Wire Line
	4450 5700 4450 5300
$Comp
L RC0201JR-0710KL:RC0201JR-0710KL R9
U 1 1 5E9100D9
P 4450 5700
F 0 "R9" V 4754 5788 50  0000 L CNN
F 1 "10k" V 4845 5788 50  0000 L CNN
F 2 "RESC0603X26N" H 5000 5750 50  0001 L CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RC0201_51_RoHS_L_8.pdf" H 5000 5650 50  0001 L CNN
F 4 "THICK FILM CHIP RESISTORS" H 5000 5550 50  0001 L CNN "Description"
F 5 "0.26" H 5000 5450 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 5000 5350 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-0710KL" H 5000 5250 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-0710KL" H 5000 5150 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-0710KL" H 5000 5050 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 5000 4950 50  0001 L CNN "RS Part Number"
F 11 "" H 5000 4850 50  0001 L CNN "RS Price/Stock"
	1    4450 5700
	0    1    1    0   
$EndComp
Wire Wire Line
	6300 4300 6300 4150
$Comp
L RC0201JR-0710KL:RC0201JR-0710KL R10
U 1 1 5E8F7DA2
P 6300 4300
F 0 "R10" V 6604 4388 50  0000 L CNN
F 1 "10k" V 6695 4388 50  0000 L CNN
F 2 "RESC0603X26N" H 6850 4350 50  0001 L CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RC0201_51_RoHS_L_8.pdf" H 6850 4250 50  0001 L CNN
F 4 "THICK FILM CHIP RESISTORS" H 6850 4150 50  0001 L CNN "Description"
F 5 "0.26" H 6850 4050 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 6850 3950 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-0710KL" H 6850 3850 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-0710KL" H 6850 3750 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-0710KL" H 6850 3650 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 6850 3550 50  0001 L CNN "RS Part Number"
F 11 "" H 6850 3450 50  0001 L CNN "RS Price/Stock"
	1    6300 4300
	0    1    1    0   
$EndComp
$Comp
L Sensor_Motion:MPU-9250 U2
U 1 1 5DB5EC31
P 5450 5500
F 0 "U2" H 5450 4511 50  0000 C CNN
F 1 "MPU-9250" H 5450 4420 50  0000 C CNN
F 2 "Open_Telemetry:3DInvenSense_QFN-24_3x3mm_P0.4mm" H 5450 4500 50  0001 C CNN
F 3 "https://store.invensense.com/datasheets/invensense/MPU9250REV1.0.pdf" H 5450 5350 50  0001 C CNN
	1    5450 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 4450 6050 4500
Wire Notes Line
	3000 4650 3000 5100
Wire Notes Line
	2600 4650 2600 5100
Wire Notes Line
	2600 4650 3000 4650
Wire Wire Line
	2700 6150 2750 6150
$Comp
L RC0201JR-0710KL:RC0201JR-0710KL R2
U 1 1 5E7BC949
P 2000 6150
F 0 "R2" H 2350 5935 50  0000 C CNN
F 1 "10k" H 2350 6026 50  0000 C BNN
F 2 "RESC0603X26N" H 2550 6200 50  0001 L CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RC0201_51_RoHS_L_8.pdf" H 2550 6100 50  0001 L CNN
F 4 "THICK FILM CHIP RESISTORS" H 2550 6000 50  0001 L CNN "Description"
F 5 "0.26" H 2550 5900 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 2550 5800 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-0710KL" H 2550 5700 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-0710KL" H 2550 5600 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-0710KL" H 2550 5500 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 2550 5400 50  0001 L CNN "RS Part Number"
F 11 "" H 2550 5300 50  0001 L CNN "RS Price/Stock"
	1    2000 6150
	1    0    0    -1  
$EndComp
$Comp
L Sensor:BME280 U1
U 1 1 5DB5D205
P 1400 5850
F 0 "U1" H 971 5896 50  0000 R CNN
F 1 "BME280" H 971 5805 50  0000 R CNN
F 2 "Open_Telemetry:Bosch_LGA-8_2x2.5mm_P0.65mm_ClockwisePinNumbering" H 2900 5400 50  0001 C CNN
F 3 "https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280-DS002.pdf" H 1400 5650 50  0001 C CNN
	1    1400 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 6450 1300 6450
Connection ~ 1500 6450
Wire Wire Line
	2000 5550 2000 5000
Wire Wire Line
	2000 4200 1500 4200
Text Notes 700  3900 0    79   ~ 16
Barometic pressure, Humidity\n   & Temperature sensor
$Comp
L RC0201JR-0710KL:RC0201JR-0710KL R1
U 1 1 5E51BC6B
P 2000 4200
F 0 "R1" V 2304 4288 50  0000 L CNN
F 1 "10k" V 2395 4288 50  0000 L CNN
F 2 "RESC0603X26N" H 2550 4250 50  0001 L CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RC0201_51_RoHS_L_8.pdf" H 2550 4150 50  0001 L CNN
F 4 "THICK FILM CHIP RESISTORS" H 2550 4050 50  0001 L CNN "Description"
F 5 "0.26" H 2550 3950 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 2550 3850 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-0710KL" H 2550 3750 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-0710KL" H 2550 3650 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-0710KL" H 2550 3550 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 2550 3450 50  0001 L CNN "RS Part Number"
F 11 "" H 2550 3350 50  0001 L CNN "RS Price/Stock"
	1    2000 4200
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5DB79DC6
P 3050 4500
F 0 "#PWR07" H 3050 4250 50  0001 C CNN
F 1 "GND" H 3055 4327 50  0000 C CNN
F 2 "" H 3050 4500 50  0001 C CNN
F 3 "" H 3050 4500 50  0001 C CNN
	1    3050 4500
	1    0    0    -1  
$EndComp
Wire Notes Line
	2600 5100 3000 5100
Text Notes 2550 4700 0    31   ~ 0
If mounted:\nAddr: 0x76
Wire Notes Line
	3150 3600 3150 7100
Connection ~ 5550 4450
Wire Wire Line
	5550 4150 5550 4450
$Comp
L C0603C103K4RACTU:C0603C103K4RACTU C4
U 1 1 5E37DC99
P 5550 4450
F 0 "C4" H 5800 4715 50  0000 C CNN
F 1 "10nF" H 5800 4624 50  0000 C CNN
F 2 "CAPC1608X87N" H 5900 4500 50  0001 L CNN
F 3 "https://api.kemet.com/component-edge/download/datasheet/C0603C103K4RACTU.pdf" H 5900 4400 50  0001 L CNN
F 4 "KEMET - C0603C103K4RACTU - CAP, 0.01F, 16V, 10%, X7R, 0603" H 5900 4300 50  0001 L CNN "Description"
F 5 "0.87" H 5900 4200 50  0001 L CNN "Height"
F 6 "Kemet" H 5900 4100 50  0001 L CNN "Manufacturer_Name"
F 7 "C0603C103K4RACTU" H 5900 4000 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "80-C0603C103K4R" H 5900 3900 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=80-C0603C103K4R" H 5900 3800 50  0001 L CNN "Mouser Price/Stock"
F 10 "1464174" H 5900 3700 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/1464174" H 5900 3600 50  0001 L CNN "RS Price/Stock"
F 12 "70097263" H 5900 3500 50  0001 L CNN "Allied_Number"
F 13 "https://www.alliedelec.com/kemet-c0603c103k4ractu/70097263/" H 5900 3400 50  0001 L CNN "Allied Price/Stock"
	1    5550 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 5850 6400 5700
Wire Wire Line
	6400 6400 6400 6350
$Comp
L C0402C104M8RACTU:C0402C104M8RACTU C5
U 1 1 5E315798
P 6400 5850
F 0 "C5" V 6604 5978 50  0000 L CNN
F 1 "100nF" V 6695 5978 50  0000 L CNN
F 2 "CAPC1005X55N" H 6750 5900 50  0001 L CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1002_X7R_SMD.pdf" H 6750 5800 50  0001 L CNN
F 4 "Multilayer Ceramic Capacitors MLCC - SMD/SMT 10volts 0.1uF X7R 20%" H 6750 5700 50  0001 L CNN "Description"
F 5 "0.55" H 6750 5600 50  0001 L CNN "Height"
F 6 "Kemet" H 6750 5500 50  0001 L CNN "Manufacturer_Name"
F 7 "C0402C104M8RACTU" H 6750 5400 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "80-C0402C104M8R" H 6750 5300 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=80-C0402C104M8R" H 6750 5200 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 6750 5100 50  0001 L CNN "RS Part Number"
F 11 "" H 6750 5000 50  0001 L CNN "RS Price/Stock"
	1    6400 5850
	0    1    1    0   
$EndComp
Wire Notes Line
	650  700  650  3200
Wire Notes Line
	650  3200 6000 3200
Wire Notes Line
	6000 3200 6000 700 
Wire Notes Line
	650  7100 3150 7100
Text Notes 4650 4300 3    31   ~ 0
If mounted:\nAddr: 0x69
Connection ~ 4750 6400
Wire Wire Line
	4450 6400 4750 6400
Wire Wire Line
	3800 5200 4750 5200
Wire Wire Line
	4450 5300 4750 5300
Wire Wire Line
	4450 5050 4450 5300
Text Notes 3900 3800 0    79   ~ 16
9 axis accel- + gyro- + magnetometer 
Connection ~ 5550 4150
Wire Wire Line
	5550 4050 5550 4150
$Comp
L power:GND #PWR015
U 1 1 5DB9304C
P 6050 4500
F 0 "#PWR015" H 6050 4250 50  0001 C CNN
F 1 "GND" H 6055 4327 50  0000 C CNN
F 2 "" H 6050 4500 50  0001 C CNN
F 3 "" H 6050 4500 50  0001 C CNN
	1    6050 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 6400 4750 6400
Wire Wire Line
	6150 5200 6300 5200
Text GLabel 6450 5200 2    50   Output ~ 0
INT_0
Wire Wire Line
	4750 6400 4750 5700
Wire Wire Line
	6150 6400 5450 6400
Connection ~ 6150 6400
Wire Wire Line
	6150 5900 6150 6400
Wire Wire Line
	6150 5800 6700 5800
$Comp
L power:+3.3V #PWR016
U 1 1 5DB8B60B
P 6700 5800
F 0 "#PWR016" H 6700 5650 50  0001 C CNN
F 1 "+3.3V" H 6715 5973 50  0000 C CNN
F 2 "" H 6700 5800 50  0001 C CNN
F 3 "" H 6700 5800 50  0001 C CNN
	1    6700 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 6400 6150 6400
Connection ~ 5450 6400
Wire Wire Line
	6150 5700 6400 5700
$Comp
L power:+3.3V #PWR013
U 1 1 5DB84AD8
P 5550 4050
F 0 "#PWR013" H 5550 3900 50  0001 C CNN
F 1 "+3.3V" H 5565 4223 50  0000 C CNN
F 2 "" H 5550 4050 50  0001 C CNN
F 3 "" H 5550 4050 50  0001 C CNN
	1    5550 4050
	1    0    0    -1  
$EndComp
Text Notes 750  7050 0    47   ~ 0
I2C communication only. Listening to I2C_0 non real time bus,\nI2C address: 0x77 (default) or 0x76 if optioal Rxx is mounted.
$Comp
L power:GND #PWR012
U 1 1 5DB66F49
P 5450 6500
F 0 "#PWR012" H 5450 6250 50  0001 C CNN
F 1 "GND" H 5455 6327 50  0000 C CNN
F 2 "" H 5450 6500 50  0001 C CNN
F 3 "" H 5450 6500 50  0001 C CNN
	1    5450 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 6400 5450 6500
Text Notes 3950 6950 0    47   ~ 0
I2C communication only. Listening to I2C_1 real time bus,\nI2C address: 0x68 (default) or 0x69 if optioal Rxx is mounted.
Wire Notes Line
	6850 3600 6850 7100
Wire Notes Line
	6850 7100 3200 7100
Wire Wire Line
	5550 4150 6300 4150
Wire Wire Line
	6300 5000 6300 5200
Connection ~ 6300 5200
Wire Wire Line
	6300 5200 6450 5200
Wire Notes Line
	3200 3600 6850 3600
Wire Notes Line
	650  3600 3150 3600
Wire Notes Line
	650  3600 650  7100
Wire Notes Line
	3200 3600 3200 7100
Wire Wire Line
	1300 5200 1500 5200
Wire Wire Line
	1300 5250 1300 5200
Wire Wire Line
	1500 5250 1500 5200
Text GLabel 2550 5950 2    50   BiDi ~ 0
I2C_0_SDA_3V
Text GLabel 2550 5750 2    50   Input ~ 0
I2C_0_SCL_3V
Text GLabel 3800 5400 0    50   Input ~ 0
I2C_1_SCL_3V
Text GLabel 3800 5200 0    50   BiDi ~ 0
I2C_1_SDA_3V
$Comp
L power:+3.3V #PWR06
U 1 1 5DB89254
P 2750 6150
F 0 "#PWR06" H 2750 6000 50  0001 C CNN
F 1 "+3.3V" V 2765 6278 50  0000 L CNN
F 2 "" H 2750 6150 50  0001 C CNN
F 3 "" H 2750 6150 50  0001 C CNN
	1    2750 6150
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5DB60E3B
P 1500 6700
F 0 "#PWR04" H 1500 6450 50  0001 C CNN
F 1 "GND" H 1505 6527 50  0000 C CNN
F 2 "" H 1500 6700 50  0001 C CNN
F 3 "" H 1500 6700 50  0001 C CNN
	1    1500 6700
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR03
U 1 1 5DB60678
P 1500 4200
F 0 "#PWR03" H 1500 4050 50  0001 C CNN
F 1 "+3.3V" H 1515 4373 50  0000 C CNN
F 2 "" H 1500 4200 50  0001 C CNN
F 3 "" H 1500 4200 50  0001 C CNN
	1    1500 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 6450 1500 6700
Wire Wire Line
	4450 4350 4450 4150
Wire Notes Line
	4650 4250 4350 4250
Wire Notes Line
	4350 4250 4350 5050
Wire Notes Line
	4350 5050 4650 5050
Wire Notes Line
	4650 4250 4650 5050
$Comp
L SML-D13FWT86:SML-D13FWT86 LED2
U 1 1 5EADBF55
P 8200 4050
F 0 "LED2" V 8546 3922 50  0000 R CNN
F 1 "GPS LCK" H 8455 3922 50  0000 R CNN
F 2 "Open_Telemetry:SMLD15YWT86" H 8700 4200 50  0001 L BNN
F 3 "http://www.rohm.com/web/global/datasheet/SML-D13FW/sml-d13x-e" H 8700 4100 50  0001 L BNN
F 4 "ROHM SML-D13FWT86, SML 566 nm Green LED, 1608 (0603) Milky White SMD package" H 8700 4000 50  0001 L BNN "Description"
F 5 "" H 8700 3900 50  0001 L BNN "Height"
F 6 "ROHM Semiconductor" H 8700 3800 50  0001 L BNN "Manufacturer_Name"
F 7 "SML-D13FWT86" H 8700 3700 50  0001 L BNN "Manufacturer_Part_Number"
F 8 "755-SML-D13FWT86" H 8700 3600 50  0001 L BNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=755-SML-D13FWT86" H 8700 3500 50  0001 L BNN "Mouser Price/Stock"
F 10 "1332874P" H 8700 3400 50  0001 L BNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/1332874P" H 8700 3300 50  0001 L BNN "RS Price/Stock"
	1    8200 4050
	0    -1   -1   0   
$EndComp
$Comp
L SML-D13DWT86A:SML-D13DWT86A LED1
U 1 1 5EB57589
P 7500 4050
F 0 "LED1" V 7846 3922 50  0000 R CNN
F 1 "ExtAnt" H 7755 3922 50  0000 R CNN
F 2 "Open_Telemetry:LEDC1608X65N" H 8000 4200 50  0001 L BNN
F 3 "https://docs-emea.rs-online.com/webdocs/156b/0900766b8156b2c9.pdf" H 8000 4100 50  0001 L BNN
F 4 "ROHM SML-D13DWT86A, SML 608 nm Orange LED, 1608 (0603) Milky White SMD package" H 8000 4000 50  0001 L BNN "Description"
F 5 "0.65" H 8000 3900 50  0001 L BNN "Height"
F 6 "ROHM Semiconductor" H 8000 3800 50  0001 L BNN "Manufacturer_Name"
F 7 "SML-D13DWT86A" H 8000 3700 50  0001 L BNN "Manufacturer_Part_Number"
F 8 "755-SML-D13DWT86A" H 8000 3600 50  0001 L BNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=755-SML-D13DWT86A" H 8000 3500 50  0001 L BNN "Mouser Price/Stock"
F 10 "1332873P" H 8000 3400 50  0001 L BNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/1332873P" H 8000 3300 50  0001 L BNN "RS Price/Stock"
	1    7500 4050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10150 4000 10150 4050
Wire Wire Line
	10150 3250 10150 3300
Wire Wire Line
	10150 2400 10150 2450
$Comp
L RC0201JR-071KL:RC0201JR-071KL R16
U 1 1 5E469F18
P 10150 3300
F 0 "R16" H 10500 3525 50  0000 C CNN
F 1 "1k" H 10500 3434 50  0000 C CNN
F 2 "RESC0603X26N" H 10700 3350 50  0001 L CNN
F 3 "https://www.digikey.se/en/datasheets/yageo/yageo-pyu-r_marking_2" H 10700 3250 50  0001 L CNN
F 4 "YAGEO - RC0201JR-071KL - RES, THICK FILM, 1K, 5%, 0.5W, 0201, REEL" H 10700 3150 50  0001 L CNN "Description"
F 5 "0.26" H 10700 3050 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 10700 2950 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-071KL" H 10700 2850 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-071KL" H 10700 2750 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-071KL" H 10700 2650 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 10700 2550 50  0001 L CNN "RS Part Number"
F 11 "" H 10700 2450 50  0001 L CNN "RS Price/Stock"
	1    10150 3300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR024
U 1 1 5DC177D5
P 10150 4050
F 0 "#PWR024" H 10150 3800 50  0001 C CNN
F 1 "GND" H 10155 3877 50  0000 C CNN
F 2 "" H 10150 4050 50  0001 C CNN
F 3 "" H 10150 4050 50  0001 C CNN
	1    10150 4050
	1    0    0    -1  
$EndComp
Text GLabel 10150 2400 1    50   Input ~ 0
RESET
Wire Wire Line
	10650 4000 10650 4050
Wire Wire Line
	10650 3250 10650 3300
Wire Wire Line
	10650 2400 10650 2450
$Comp
L RC0201JR-071KL:RC0201JR-071KL R17
U 1 1 5EC184BF
P 10650 3300
F 0 "R17" H 11000 3525 50  0000 C CNN
F 1 "1k" H 11000 3434 50  0000 C CNN
F 2 "RESC0603X26N" H 11200 3350 50  0001 L CNN
F 3 "https://www.digikey.se/en/datasheets/yageo/yageo-pyu-r_marking_2" H 11200 3250 50  0001 L CNN
F 4 "YAGEO - RC0201JR-071KL - RES, THICK FILM, 1K, 5%, 0.5W, 0201, REEL" H 11200 3150 50  0001 L CNN "Description"
F 5 "0.26" H 11200 3050 50  0001 L CNN "Height"
F 6 "YAGEO (PHYCOMP)" H 11200 2950 50  0001 L CNN "Manufacturer_Name"
F 7 "RC0201JR-071KL" H 11200 2850 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "603-RC0201JR-071KL" H 11200 2750 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-071KL" H 11200 2650 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 11200 2550 50  0001 L CNN "RS Part Number"
F 11 "" H 11200 2450 50  0001 L CNN "RS Price/Stock"
	1    10650 3300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR026
U 1 1 5EC184C5
P 10650 4050
F 0 "#PWR026" H 10650 3800 50  0001 C CNN
F 1 "GND" H 10655 3877 50  0000 C CNN
F 2 "" H 10650 4050 50  0001 C CNN
F 3 "" H 10650 4050 50  0001 C CNN
	1    10650 4050
	1    0    0    -1  
$EndComp
$Comp
L LED:ASMB-MTB1-0A3A2 D1
U 1 1 5DBE4DF6
P 9300 3750
F 0 "D1" V 9300 4180 50  0000 L CNN
F 1 "ASMB-MTB1-0A3A2" V 9345 4180 50  0001 L CNN
F 2 "Open_Telemetry:AVAGO_PLCC4" H 9300 4350 50  0001 C CNN
F 3 "https://docs.broadcom.com/docs/AV02-4194EN" H 9300 3300 50  0001 C CNN
	1    9300 3750
	0    1    1    0   
$EndComp
$Comp
L ATS2D1G_NC_LFS:ATS2D1G_NC_LFS S1
U 1 1 5DC11E0D
P 10150 2450
F 0 "S1" V 10504 2578 50  0000 L CNN
F 1 "RST" V 10595 2578 50  0000 L CNN
F 2 "Open_Telemetry:ATS2D1G" H 10800 2550 50  0001 L CNN
F 3 "http://www.mouser.com/ds/2/60/ats-1100738.pdf" H 10800 2450 50  0001 L CNN
F 4 "Tactile Switches 1VA 32VDC 50mA On-(On) Sldr IP54" H 10800 2350 50  0001 L CNN "Description"
F 5 "" H 10800 2250 50  0001 L CNN "Height"
F 6 "C & K COMPONENTS" H 10800 2150 50  0001 L CNN "Manufacturer_Name"
F 7 "ATS2D1G NC LFS" H 10800 2050 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "611-ATS2D1GNCLFS" H 10800 1950 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=611-ATS2D1GNCLFS" H 10800 1850 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 10800 1750 50  0001 L CNN "RS Part Number"
F 11 "" H 10800 1650 50  0001 L CNN "RS Price/Stock"
	1    10150 2450
	0    1    1    0   
$EndComp
$Comp
L ATS2D1G_NC_LFS:ATS2D1G_NC_LFS S2
U 1 1 5DC296C0
P 10650 2450
F 0 "S2" V 11004 2578 50  0000 L CNN
F 1 "CALIB" V 11095 2578 50  0000 L CNN
F 2 "Open_Telemetry:ATS2D1G" H 11300 2550 50  0001 L CNN
F 3 "http://www.mouser.com/ds/2/60/ats-1100738.pdf" H 11300 2450 50  0001 L CNN
F 4 "Tactile Switches 1VA 32VDC 50mA On-(On) Sldr IP54" H 11300 2350 50  0001 L CNN "Description"
F 5 "" H 11300 2250 50  0001 L CNN "Height"
F 6 "C & K COMPONENTS" H 11300 2150 50  0001 L CNN "Manufacturer_Name"
F 7 "ATS2D1G NC LFS" H 11300 2050 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "611-ATS2D1GNCLFS" H 11300 1950 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=611-ATS2D1GNCLFS" H 11300 1850 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 11300 1750 50  0001 L CNN "RS Part Number"
F 11 "" H 11300 1650 50  0001 L CNN "RS Price/Stock"
	1    10650 2450
	0    1    1    0   
$EndComp
Wire Wire Line
	5550 4450 5550 4600
Wire Wire Line
	5350 4450 5550 4450
Wire Wire Line
	5350 4450 5350 4600
Wire Wire Line
	8600 1450 10200 1450
Wire Wire Line
	8350 850  9500 850 
$Comp
L C0603C103K4RACTU:C0603C103K4RACTU C1
U 1 1 5DC82D81
P 800 5000
F 0 "C1" V 1004 5128 50  0000 L CNN
F 1 "10nF" V 1095 5128 50  0000 L CNN
F 2 "CAPC1608X87N" H 1150 5050 50  0001 L CNN
F 3 "https://api.kemet.com/component-edge/download/datasheet/C0603C103K4RACTU.pdf" H 1150 4950 50  0001 L CNN
F 4 "KEMET - C0603C103K4RACTU - CAP, 0.01F, 16V, 10%, X7R, 0603" H 1150 4850 50  0001 L CNN "Description"
F 5 "0.87" H 1150 4750 50  0001 L CNN "Height"
F 6 "Kemet" H 1150 4650 50  0001 L CNN "Manufacturer_Name"
F 7 "C0603C103K4RACTU" H 1150 4550 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "80-C0603C103K4R" H 1150 4450 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=80-C0603C103K4R" H 1150 4350 50  0001 L CNN "Mouser Price/Stock"
F 10 "1464174" H 1150 4250 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/1464174" H 1150 4150 50  0001 L CNN "RS Price/Stock"
F 12 "70097263" H 1150 4050 50  0001 L CNN "Allied_Number"
F 13 "https://www.alliedelec.com/kemet-c0603c103k4ractu/70097263/" H 1150 3950 50  0001 L CNN "Allied Price/Stock"
	1    800  5000
	0    1    1    0   
$EndComp
Wire Wire Line
	800  5500 800  6450
Wire Wire Line
	800  6450 1300 6450
Connection ~ 1300 6450
Wire Wire Line
	1900 1650 2000 1650
Connection ~ 1900 2150
Wire Wire Line
	1900 2150 4150 2150
$Comp
L C0603C103K4RACTU:C0603C103K4RACTU C2
U 1 1 5DCAC25D
P 1500 1650
F 0 "C2" V 1704 1778 50  0000 L CNN
F 1 "10nF" V 1795 1778 50  0000 L CNN
F 2 "CAPC1608X87N" H 1850 1700 50  0001 L CNN
F 3 "https://api.kemet.com/component-edge/download/datasheet/C0603C103K4RACTU.pdf" H 1850 1600 50  0001 L CNN
F 4 "KEMET - C0603C103K4RACTU - CAP, 0.01F, 16V, 10%, X7R, 0603" H 1850 1500 50  0001 L CNN "Description"
F 5 "0.87" H 1850 1400 50  0001 L CNN "Height"
F 6 "Kemet" H 1850 1300 50  0001 L CNN "Manufacturer_Name"
F 7 "C0603C103K4RACTU" H 1850 1200 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "80-C0603C103K4R" H 1850 1100 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=80-C0603C103K4R" H 1850 1000 50  0001 L CNN "Mouser Price/Stock"
F 10 "1464174" H 1850 900 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/1464174" H 1850 800 50  0001 L CNN "RS Price/Stock"
F 12 "70097263" H 1850 700 50  0001 L CNN "Allied_Number"
F 13 "https://www.alliedelec.com/kemet-c0603c103k4ractu/70097263/" H 1850 600 50  0001 L CNN "Allied Price/Stock"
	1    1500 1650
	0    1    1    0   
$EndComp
Connection ~ 1500 2150
Wire Wire Line
	1500 2150 1900 2150
Wire Wire Line
	1500 1650 1900 1650
Connection ~ 1900 1650
Connection ~ 1200 2150
Connection ~ 1500 1650
Wire Wire Line
	1200 2150 1500 2150
Wire Wire Line
	800  2150 1200 2150
Wire Wire Line
	1200 1550 2750 1550
Wire Wire Line
	1200 1550 1200 2150
Wire Wire Line
	800  1650 1500 1650
Wire Wire Line
	800  1650 800  1550
$Comp
L power:+3.3V #PWR01
U 1 1 5DCDA38D
P 800 1550
F 0 "#PWR01" H 800 1400 50  0001 C CNN
F 1 "+3.3V" H 815 1723 50  0000 C CNN
F 2 "" H 800 1550 50  0001 C CNN
F 3 "" H 800 1550 50  0001 C CNN
	1    800  1550
	1    0    0    -1  
$EndComp
Text GLabel 1900 1450 0    50   Input ~ 0
UART_1_CLIENT_TXD
Text GLabel 1900 1350 0    50   Input ~ 0
UART_1_CLIENT_RXD
Wire Wire Line
	10000 5950 9150 5950
Wire Wire Line
	9150 5950 9150 6200
Wire Wire Line
	2000 5750 2550 5750
Wire Wire Line
	2000 5950 2550 5950
Connection ~ 1500 5200
Connection ~ 1500 4200
Wire Wire Line
	1500 4200 1500 5000
Wire Wire Line
	800  5000 1500 5000
Connection ~ 1500 5000
Wire Wire Line
	1500 5000 1500 5200
Wire Wire Line
	2350 5000 2000 5000
Connection ~ 2000 5000
Wire Wire Line
	2000 5000 2000 4900
Wire Wire Line
	3800 5400 4750 5400
Wire Wire Line
	4450 4150 4700 4150
Text Notes 4550 1850 0    50   ~ 0
50 Ohm impedience strip
Wire Wire Line
	4750 5500 4700 5500
Wire Wire Line
	4700 5500 4700 4150
Connection ~ 4700 4150
Wire Wire Line
	4700 4150 5550 4150
$EndSCHEMATC
