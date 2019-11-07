SamacSys ECAD Model
636688/190061/2.44/2/5/Resistor

DESIGNSPARK_INTERMEDIATE_ASCII

(asciiHeader
	(fileUnits MM)
)
(library Library_1
	(padStyleDef "r44_42"
		(holeDiam 0)
		(padShape (layerNumRef 1) (padShapeType Rect)  (shapeWidth 0.42) (shapeHeight 0.44))
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
	(patternDef "RESC0603X26N" (originalName "RESC0603X26N")
		(multiLayer
			(pad (padNum 1) (padStyleRef r44_42) (pt -0.34, 0) (rotation 90))
			(pad (padNum 2) (padStyleRef r44_42) (pt 0.34, 0) (rotation 90))
		)
		(layerContents (layerNumRef 18)
			(attr "RefDes" "RefDes" (pt 0, 0) (textStyleRef "Default") (isVisible True))
		)
		(layerContents (layerNumRef 30)
			(line (pt -0.315 -0.165) (pt 0.315 -0.165) (width 0.001))
		)
		(layerContents (layerNumRef 30)
			(line (pt 0.315 -0.165) (pt 0.315 0.165) (width 0.001))
		)
		(layerContents (layerNumRef 30)
			(line (pt 0.315 0.165) (pt -0.315 0.165) (width 0.001))
		)
		(layerContents (layerNumRef 30)
			(line (pt -0.315 0.165) (pt -0.315 -0.165) (width 0.001))
		)
		(layerContents (layerNumRef 30)
			(line (pt -0.71 -0.36) (pt 0.71 -0.36) (width 0.05))
		)
		(layerContents (layerNumRef 30)
			(line (pt 0.71 -0.36) (pt 0.71 0.36) (width 0.05))
		)
		(layerContents (layerNumRef 30)
			(line (pt 0.71 0.36) (pt -0.71 0.36) (width 0.05))
		)
		(layerContents (layerNumRef 30)
			(line (pt -0.71 0.36) (pt -0.71 -0.36) (width 0.05))
		)
		(layerContents (layerNumRef 30)
			(arc (pt 0, 0) (radius 0.35) (startAngle 0.0) (sweepAngle 0.0) (width 0.05))
		)
		(layerContents (layerNumRef 30)
			(arc (pt 0, 0) (radius 0.35) (startAngle 180.0) (sweepAngle 180.0) (width 0.05))
		)
		(layerContents (layerNumRef 30)
			(line (pt 0 -0.5) (pt 0 0.5) (width 0.05))
		)
		(layerContents (layerNumRef 30)
			(line (pt -0.5 0) (pt 0.5 0) (width 0.05))
		)
		(layerContents (layerNumRef 28)
			(line (pt -0.7 -0.35) (pt 0.7 -0.35) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt 0.7 -0.35) (pt 0.7 0.35) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt 0.7 0.35) (pt -0.7 0.35) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt -0.7 0.35) (pt -0.7 -0.35) (width 0.1))
		)
	)
	(symbolDef "RC0201JR-07100KL" (originalName "RC0201JR-07100KL")

		(pin (pinNum 1) (pt 0 mils 0 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName false)) (pinName (text (pt 0 mils -35 mils) (rotation 0]) (justify "UpperLeft") (textStyleRef "Default"))
		))
		(pin (pinNum 2) (pt 700 mils 0 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName false)) (pinName (text (pt 700 mils -35 mils) (rotation 0]) (justify "UpperRight") (textStyleRef "Default"))
		))
		(line (pt 200 mils 50 mils) (pt 500 mils 50 mils) (width 6 mils))
		(line (pt 500 mils 50 mils) (pt 500 mils -50 mils) (width 6 mils))
		(line (pt 500 mils -50 mils) (pt 200 mils -50 mils) (width 6 mils))
		(line (pt 200 mils -50 mils) (pt 200 mils 50 mils) (width 6 mils))
		(attr "RefDes" "RefDes" (pt 550 mils 250 mils) (justify Left) (isVisible True) (textStyleRef "Default"))

	)
	(compDef "RC0201JR-07100KL" (originalName "RC0201JR-07100KL") (compHeader (numPins 2) (numParts 1) (refDesPrefix R)
		)
		(compPin "1" (pinName "1") (partNum 1) (symPinNum 1) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "2" (pinName "2") (partNum 1) (symPinNum 2) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(attachedSymbol (partNum 1) (altType Normal) (symbolName "RC0201JR-07100KL"))
		(attachedPattern (patternNum 1) (patternName "RESC0603X26N")
			(numPads 2)
			(padPinMap
				(padNum 1) (compPinRef "1")
				(padNum 2) (compPinRef "2")
			)
		)
		(attr "Manufacturer_Name" "YAGEO (PHYCOMP)")
		(attr "Manufacturer_Part_Number" "RC0201JR-07100KL")
		(attr "Mouser Part Number" "603-RC0201JR-07100KL")
		(attr "Mouser Price/Stock" "https://www.mouser.com/Search/Refine.aspx?Keyword=603-RC0201JR-07100KL")
		(attr "RS Part Number" "")
		(attr "RS Price/Stock" "")
		(attr "Description" "YAGEO - RC0201JR-07100KL - RES, THICK FILM, 100K, 5%, 0.5W, 0201")
		(attr "Datasheet Link" "http://www.yageo.com/documents/recent/PYu-RC0201_51_RoHS_L_8.pdf")
		(attr "Height" "0.26 mm")
	)

)
