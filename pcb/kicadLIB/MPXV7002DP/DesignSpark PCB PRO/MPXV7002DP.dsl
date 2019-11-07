SamacSys ECAD Model
1037825/190061/2.44/8/4/Integrated Circuit

DESIGNSPARK_INTERMEDIATE_ASCII

(asciiHeader
	(fileUnits MM)
)
(library Library_1
	(padStyleDef "r235_120"
		(holeDiam 0)
		(padShape (layerNumRef 1) (padShapeType Rect)  (shapeWidth 1.200) (shapeHeight 2.350))
		(padShape (layerNumRef 16) (padShapeType Ellipse)  (shapeWidth 0) (shapeHeight 0))
	)
	(textStyleDef "Default"
		(font
			(fontType Stroke)
			(fontFace "Helvetica")
			(fontHeight 50 mils)
			(strokeWidth 5 mils)
		)
	)
	(patternDef "MPXV7002DP" (originalName "MPXV7002DP")
		(multiLayer
			(pad (padNum 1) (padStyleRef r235_120) (pt 8.100, 2.190) (rotation 90))
			(pad (padNum 2) (padStyleRef r235_120) (pt 8.100, 4.730) (rotation 90))
			(pad (padNum 3) (padStyleRef r235_120) (pt 8.100, 7.270) (rotation 90))
			(pad (padNum 4) (padStyleRef r235_120) (pt 8.100, 9.810) (rotation 90))
			(pad (padNum 5) (padStyleRef r235_120) (pt -8.100, 9.810) (rotation 90))
			(pad (padNum 6) (padStyleRef r235_120) (pt -8.100, 7.270) (rotation 90))
			(pad (padNum 7) (padStyleRef r235_120) (pt -8.100, 4.730) (rotation 90))
			(pad (padNum 8) (padStyleRef r235_120) (pt -8.100, 2.190) (rotation 90))
		)
		(layerContents (layerNumRef 18)
			(attr "RefDes" "RefDes" (pt 0.263, 2.825) (textStyleRef "Default") (isVisible True))
		)
		(layerContents (layerNumRef 28)
			(line (pt -6 12) (pt 6 12) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt 6 12) (pt 6 0) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt 6 0) (pt -6 0) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt -6 0) (pt -6 12) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt -6 12) (pt 6 12) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt 6 12) (pt 6 0) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt 6 0) (pt -6 0) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt -6 0) (pt -6 12) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt -10.275 13) (pt 10.8 13) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt 10.8 13) (pt 10.8 -7.35) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt 10.8 -7.35) (pt -10.275 -7.35) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt -10.275 -7.35) (pt -10.275 13) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt -4.05 0) (pt -4.05 -6.35) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt -4.05 -6.35) (pt -0.5 -6.35) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt -0.5 -6.35) (pt -0.5 0) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt 0.5 0) (pt 0.5 -6.35) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt 0.5 -6.35) (pt 4.05 -6.35) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt 4.05 -6.35) (pt 4.05 0) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt 9.7 2.1) (pt 9.7 2.1) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(arc (pt 9.7, 2.2) (radius 0.1) (startAngle 90) (sweepAngle 180) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt 9.7 2.3) (pt 9.7 2.3) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(arc (pt 9.7, 2.2) (radius 0.1) (startAngle 90.0) (sweepAngle -180.0) (width 0.2))
		)
	)
	(symbolDef "MPXV7002DP" (originalName "MPXV7002DP")

		(pin (pinNum 1) (pt 0 mils 0 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -25 mils) (rotation 0]) (justify "Left") (textStyleRef "Default"))
		))
		(pin (pinNum 2) (pt 0 mils -100 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -125 mils) (rotation 0]) (justify "Left") (textStyleRef "Default"))
		))
		(pin (pinNum 3) (pt 0 mils -200 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -225 mils) (rotation 0]) (justify "Left") (textStyleRef "Default"))
		))
		(pin (pinNum 4) (pt 0 mils -300 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -325 mils) (rotation 0]) (justify "Left") (textStyleRef "Default"))
		))
		(pin (pinNum 5) (pt 1200 mils 0 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 970 mils -25 mils) (rotation 0]) (justify "Right") (textStyleRef "Default"))
		))
		(pin (pinNum 6) (pt 1200 mils -100 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 970 mils -125 mils) (rotation 0]) (justify "Right") (textStyleRef "Default"))
		))
		(pin (pinNum 7) (pt 1200 mils -200 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 970 mils -225 mils) (rotation 0]) (justify "Right") (textStyleRef "Default"))
		))
		(pin (pinNum 8) (pt 1200 mils -300 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 970 mils -325 mils) (rotation 0]) (justify "Right") (textStyleRef "Default"))
		))
		(line (pt 200 mils 100 mils) (pt 1000 mils 100 mils) (width 6 mils))
		(line (pt 1000 mils 100 mils) (pt 1000 mils -400 mils) (width 6 mils))
		(line (pt 1000 mils -400 mils) (pt 200 mils -400 mils) (width 6 mils))
		(line (pt 200 mils -400 mils) (pt 200 mils 100 mils) (width 6 mils))
		(attr "RefDes" "RefDes" (pt 1050 mils 300 mils) (justify Left) (isVisible True) (textStyleRef "Default"))

	)
	(compDef "MPXV7002DP" (originalName "MPXV7002DP") (compHeader (numPins 8) (numParts 1) (refDesPrefix IC)
		)
		(compPin "1" (pinName "N/C_1") (partNum 1) (symPinNum 1) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "2" (pinName "VS") (partNum 1) (symPinNum 2) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "3" (pinName "GND") (partNum 1) (symPinNum 3) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "4" (pinName "VOUT") (partNum 1) (symPinNum 4) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "5" (pinName "N/C_2") (partNum 1) (symPinNum 5) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "6" (pinName "N/C_3") (partNum 1) (symPinNum 6) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "7" (pinName "N/C_4") (partNum 1) (symPinNum 7) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "8" (pinName "N/C_5") (partNum 1) (symPinNum 8) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(attachedSymbol (partNum 1) (altType Normal) (symbolName "MPXV7002DP"))
		(attachedPattern (patternNum 1) (patternName "MPXV7002DP")
			(numPads 8)
			(padPinMap
				(padNum 1) (compPinRef "1")
				(padNum 2) (compPinRef "2")
				(padNum 3) (compPinRef "3")
				(padNum 4) (compPinRef "4")
				(padNum 5) (compPinRef "5")
				(padNum 6) (compPinRef "6")
				(padNum 7) (compPinRef "7")
				(padNum 8) (compPinRef "8")
			)
		)
		(attr "Manufacturer_Name" "Nexperia")
		(attr "Manufacturer_Part_Number" "MPXV7002DP")
		(attr "Mouser Part Number" "841-MPXV7002DP")
		(attr "Mouser Price/Stock" "https://www.mouser.com/Search/Refine.aspx?Keyword=841-MPXV7002DP")
		(attr "RS Part Number" "7191197P")
		(attr "RS Price/Stock" "http://uk.rs-online.com/web/p/products/7191197P")
		(attr "Description" "Pressure Sensor 7kPa Differential 2-Port")
		(attr "Datasheet Link" "https://componentsearchengine.com/Datasheets/2/MPXV7002DP.pdf")
		(attr "Height" "9.906 mm")
	)

)
