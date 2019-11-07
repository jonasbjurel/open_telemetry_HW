PULSONIX_LIBRARY_ASCII "SamacSys ECAD Model"
//348701/190061/2.44/4/3/Switch

(asciiHeader
	(fileUnits MM)
)
(library Library_1
	(padStyleDef "r300_200"
		(holeDiam 0)
		(padShape (layerNumRef 1) (padShapeType Rect)  (shapeWidth 2) (shapeHeight 3))
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
	(patternDef "SMS-GULLWING" (originalName "SMS-GULLWING")
		(multiLayer
			(pad (padNum 1) (padStyleRef r300_200) (pt -7, -3.75) (rotation 90))
			(pad (padNum 2) (padStyleRef r300_200) (pt 7, -3.75) (rotation 90))
			(pad (padNum 3) (padStyleRef r300_200) (pt 7, 3.75) (rotation 90))
			(pad (padNum 4) (padStyleRef r300_200) (pt -7, 3.75) (rotation 90))
		)
		(layerContents (layerNumRef 18)
			(attr "RefDes" "RefDes" (pt -0.232, -0.196) (textStyleRef "Normal") (isVisible True))
		)
		(layerContents (layerNumRef 28)
			(line (pt -5.7 5.7) (pt 5.7 5.7) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt 5.7 5.7) (pt 5.7 -5.7) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt 5.7 -5.7) (pt -5.7 -5.7) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt -5.7 -5.7) (pt -5.7 5.7) (width 0.025))
		)
		(layerContents (layerNumRef 18)
			(line (pt -5.7 -5.7) (pt 5.7 -5.7) (width 0.254))
		)
		(layerContents (layerNumRef 18)
			(line (pt -5.7 5.7) (pt 5.7 5.7) (width 0.254))
		)
		(layerContents (layerNumRef 18)
			(line (pt -5.7 2.4) (pt -5.7 -2.4) (width 0.254))
		)
		(layerContents (layerNumRef 18)
			(line (pt 5.7 2.4) (pt 5.7 -2.4) (width 0.254))
		)
	)
	(symbolDef "1241.1612.11" (originalName "1241.1612.11")

		(pin (pinNum 1) (pt 0 mils 0 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -25 mils) (rotation 0]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 2) (pt 0 mils -100 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -125 mils) (rotation 0]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 3) (pt 800 mils 0 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 570 mils -25 mils) (rotation 0]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 4) (pt 800 mils -100 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 570 mils -125 mils) (rotation 0]) (justify "Right") (textStyleRef "Normal"))
		))
		(line (pt 200 mils 100 mils) (pt 600 mils 100 mils) (width 6 mils))
		(line (pt 600 mils 100 mils) (pt 600 mils -200 mils) (width 6 mils))
		(line (pt 600 mils -200 mils) (pt 200 mils -200 mils) (width 6 mils))
		(line (pt 200 mils -200 mils) (pt 200 mils 100 mils) (width 6 mils))
		(attr "RefDes" "RefDes" (pt 650 mils 300 mils) (justify Left) (isVisible True) (textStyleRef "Normal"))
		(attr "Type" "Type" (pt 650 mils 200 mils) (justify Left) (isVisible True) (textStyleRef "Normal"))

	)
	(compDef "1241.1612.11" (originalName "1241.1612.11") (compHeader (numPins 4) (numParts 1) (refDesPrefix S)
		)
		(compPin "1" (pinName "1") (partNum 1) (symPinNum 1) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "2" (pinName "2") (partNum 1) (symPinNum 2) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "3" (pinName "3") (partNum 1) (symPinNum 3) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "4" (pinName "4") (partNum 1) (symPinNum 4) (gateEq 0) (pinEq 0) (pinType Unknown))
		(attachedSymbol (partNum 1) (altType Normal) (symbolName "1241.1612.11"))
		(attachedPattern (patternNum 1) (patternName "SMS-GULLWING")
			(numPads 4)
			(padPinMap
				(padNum 1) (compPinRef "1")
				(padNum 2) (compPinRef "2")
				(padNum 3) (compPinRef "3")
				(padNum 4) (compPinRef "4")
			)
		)
		(attr "Manufacturer_Name" "SCHURTER")
		(attr "Manufacturer_Part_Number" "1241.1612.11")
		(attr "Mouser Part Number" "693-1241.1612.11")
		(attr "Mouser Price/Stock" "https://www.mouser.com/Search/Refine.aspx?Keyword=693-1241.1612.11")
		(attr "RS Part Number" "")
		(attr "RS Price/Stock" "")
		(attr "Description" "SCHURTER - 1241.1612.11 - SWITCH, SPST-NO, 0.05A, 42VDC/30VAC, SMD")
		(attr "<Hyperlink>" "http://docs-emea.rs-online.com/webdocs/1441/0900766b81441fba.pdf")
	)

)
