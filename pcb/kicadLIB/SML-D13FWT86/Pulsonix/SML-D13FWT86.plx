PULSONIX_LIBRARY_ASCII "SamacSys ECAD Model"
//939264/190061/2.44/2/4/LED

(asciiHeader
	(fileUnits MM)
)
(library Library_1
	(padStyleDef "s80"
		(holeDiam 0)
		(padShape (layerNumRef 1) (padShapeType Rect)  (shapeWidth 0.800) (shapeHeight 0.800))
		(padShape (layerNumRef 16) (padShapeType Ellipse)  (shapeWidth 0) (shapeHeight 0))
	)
	(textStyleDef "Normal"
		(font
			(fontType Stroke)
			(fontFace "Helvetica")
			(fontHeight 1.27)
			(strokeWidth 0.127)
		)
	)
	(patternDef "SMLD15YWT86" (originalName "SMLD15YWT86")
		(multiLayer
			(pad (padNum 1) (padStyleRef s80) (pt 0.000, 0.825) (rotation 90))
			(pad (padNum 2) (padStyleRef s80) (pt 0.000, -0.825) (rotation 90))
		)
		(layerContents (layerNumRef 18)
			(attr "RefDes" "RefDes" (pt 0.000, 0.238) (textStyleRef "Normal") (isVisible True))
		)
		(layerContents (layerNumRef 28)
			(line (pt -0.4 0.8) (pt 0.4 0.8) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt 0.4 0.8) (pt 0.4 -0.8) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt 0.4 -0.8) (pt -0.4 -0.8) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt -0.4 -0.8) (pt -0.4 0.8) (width 0.025))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt -0.9 2.2) (pt 0.9 2.2) (width 0.1))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt 0.9 2.2) (pt 0.9 -1.725) (width 0.1))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt 0.9 -1.725) (pt -0.9 -1.725) (width 0.1))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt -0.9 -1.725) (pt -0.9 2.2) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt -0.1 1.6) (pt -0.1 1.6) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(arc (pt -2.7755575615629E-17, 1.6) (radius 0.1) (startAngle 180.0) (sweepAngle -180.0) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt 0.1 1.6) (pt 0.1 1.6) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(arc (pt -2.7755575615629E-17, 1.6) (radius 0.1) (startAngle .0) (sweepAngle -180.0) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt -0.4 0.3) (pt -0.4 -0.3) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt 0.4 0.3) (pt 0.4 -0.3) (width 0.1))
		)
	)
	(symbolDef "SML-D13FWT86" (originalName "SML-D13FWT86")

		(pin (pinNum 1) (pt 0 mils 0 mils) (rotation 0) (pinLength 100 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 10 mils -35 mils) (rotation 0]) (justify "UpperLeft") (textStyleRef "Normal"))
		))
		(pin (pinNum 2) (pt 600 mils 0 mils) (rotation 180) (pinLength 100 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 590 mils -35 mils) (rotation 0]) (justify "UpperRight") (textStyleRef "Normal"))
		))
		(line (pt 200 mils 0 mils) (pt 400 mils 100 mils) (width 6 mils))
		(line (pt 400 mils 100 mils) (pt 400 mils -100 mils) (width 6 mils))
		(line (pt 400 mils -100 mils) (pt 200 mils 0 mils) (width 6 mils))
		(line (pt 200 mils 100 mils) (pt 200 mils -100 mils) (width 6 mils))
		(line (pt 250 mils 100 mils) (pt 150 mils 200 mils) (width 6 mils))
		(line (pt 350 mils 100 mils) (pt 250 mils 200 mils) (width 6 mils))
		(line (pt 100 mils 0 mils) (pt 200 mils 0 mils) (width 6 mils))
		(line (pt 400 mils 0 mils) (pt 500 mils 0 mils) (width 6 mils))
		(poly (pt 210 mils 170 mils) (pt 180 mils 140 mils) (pt 150 mils 200 mils) (pt 210 mils 170 mils) (width 10  mils))
		(poly (pt 310 mils 170 mils) (pt 280 mils 140 mils) (pt 250 mils 200 mils) (pt 310 mils 170 mils) (width 10  mils))
		(attr "RefDes" "RefDes" (pt 500 mils 350 mils) (justify LowerLeft) (isVisible True) (textStyleRef "Normal"))
		(attr "Type" "Type" (pt 500 mils 250 mils) (justify LowerLeft) (isVisible True) (textStyleRef "Normal"))

	)
	(compDef "SML-D13FWT86" (originalName "SML-D13FWT86") (compHeader (numPins 2) (numParts 1) (refDesPrefix LED)
		)
		(compPin "1" (pinName "K") (partNum 1) (symPinNum 1) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "2" (pinName "A") (partNum 1) (symPinNum 2) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(attachedSymbol (partNum 1) (altType Normal) (symbolName "SML-D13FWT86"))
		(attachedPattern (patternNum 1) (patternName "SMLD15YWT86")
			(numPads 2)
			(padPinMap
				(padNum 1) (compPinRef "1")
				(padNum 2) (compPinRef "2")
			)
		)
		(attr "Manufacturer_Name" "ROHM Semiconductor")
		(attr "Manufacturer_Part_Number" "SML-D13FWT86")
		(attr "Mouser Part Number" "755-SML-D13FWT86")
		(attr "Mouser Price/Stock" "https://www.mouser.com/Search/Refine.aspx?Keyword=755-SML-D13FWT86")
		(attr "RS Part Number" "1332874P")
		(attr "RS Price/Stock" "http://uk.rs-online.com/web/p/products/1332874P")
		(attr "Description" "ROHM SML-D13FWT86, SML 566 nm Green LED, 1608 (0603) Milky White SMD package")
		(attr "<Hyperlink>" "http://www.rohm.com/web/global/datasheet/SML-D13FW/sml-d13x-e")
	)

)
