SamacSys ECAD Model
327257/190061/2.44/2/3/Capacitor Polarised

DESIGNSPARK_INTERMEDIATE_ASCII

(asciiHeader
	(fileUnits MM)
)
(library Library_1
	(padStyleDef "r160_125"
		(holeDiam 0)
		(padShape (layerNumRef 1) (padShapeType Rect)  (shapeWidth 1.25) (shapeHeight 1.6))
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
	(patternDef "CAPPM3216X160N" (originalName "CAPPM3216X160N")
		(multiLayer
			(pad (padNum 1) (padStyleRef r160_125) (pt -1.4, 0) (rotation 90))
			(pad (padNum 2) (padStyleRef r160_125) (pt 1.4, 0) (rotation 90))
		)
		(layerContents (layerNumRef 18)
			(attr "RefDes" "RefDes" (pt 0, 0) (textStyleRef "Default") (isVisible True))
		)
		(layerContents (layerNumRef 30)
			(line (pt -2.45 1.05) (pt 2.45 1.05) (width 0.05))
		)
		(layerContents (layerNumRef 30)
			(line (pt 2.45 1.05) (pt 2.45 -1.05) (width 0.05))
		)
		(layerContents (layerNumRef 30)
			(line (pt 2.45 -1.05) (pt -2.45 -1.05) (width 0.05))
		)
		(layerContents (layerNumRef 30)
			(line (pt -2.45 -1.05) (pt -2.45 1.05) (width 0.05))
		)
		(layerContents (layerNumRef 28)
			(line (pt -1.6 0.8) (pt 1.6 0.8) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt 1.6 0.8) (pt 1.6 -0.8) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt 1.6 -0.8) (pt -1.6 -0.8) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt -1.6 -0.8) (pt -1.6 0.8) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt -1.6 0.175) (pt -0.975 0.8) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt 1.6 0.8) (pt -2.2 0.8) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt -1.6 -0.8) (pt 1.6 -0.8) (width 0.2))
		)
	)
	(symbolDef "T491A106M016AT" (originalName "T491A106M016AT")

		(pin (pinNum 1) (pt 0 mils 0 mils) (rotation 0) (pinLength 100 mils) (pinDisplay (dispPinName false)) (pinName (text (pt 0 mils -35 mils) (rotation 0]) (justify "UpperLeft") (textStyleRef "Default"))
		))
		(pin (pinNum 2) (pt 500 mils 0 mils) (rotation 180) (pinLength 100 mils) (pinDisplay (dispPinName false)) (pinName (text (pt 500 mils -35 mils) (rotation 0]) (justify "UpperRight") (textStyleRef "Default"))
		))
		(line (pt 200 mils 100 mils) (pt 200 mils -100 mils) (width 6 mils))
		(line (pt 200 mils -100 mils) (pt 230 mils -100 mils) (width 6 mils))
		(line (pt 230 mils -100 mils) (pt 230 mils 100 mils) (width 6 mils))
		(line (pt 230 mils 100 mils) (pt 200 mils 100 mils) (width 6 mils))
		(line (pt 180 mils 50 mils) (pt 140 mils 50 mils) (width 6 mils))
		(line (pt 160 mils 70 mils) (pt 160 mils 30 mils) (width 6 mils))
		(line (pt 100 mils 0 mils) (pt 200 mils 0 mils) (width 6 mils))
		(line (pt 300 mils 0 mils) (pt 400 mils 0 mils) (width 6 mils))
		(poly (pt 300 mils 100 mils) (pt 300 mils -100 mils) (pt 270 mils -100 mils) (pt 270 mils 100 mils) (pt 300 mils 100 mils) (width 10  mils))
		(attr "RefDes" "RefDes" (pt 350 mils 250 mils) (justify 24) (isVisible True) (textStyleRef "Default"))

	)
	(compDef "T491A106M016AT" (originalName "T491A106M016AT") (compHeader (numPins 2) (numParts 1) (refDesPrefix C)
		)
		(compPin "1" (pinName "+") (partNum 1) (symPinNum 1) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "2" (pinName "-") (partNum 1) (symPinNum 2) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(attachedSymbol (partNum 1) (altType Normal) (symbolName "T491A106M016AT"))
		(attachedPattern (patternNum 1) (patternName "CAPPM3216X160N")
			(numPads 2)
			(padPinMap
				(padNum 1) (compPinRef "1")
				(padNum 2) (compPinRef "2")
			)
		)
		(attr "Manufacturer_Name" "Kemet")
		(attr "Manufacturer_Part_Number" "T491A106M016AT")
		(attr "Mouser Part Number" "80-T491A106M016")
		(attr "Mouser Price/Stock" "https://www.mouser.com/Search/Refine.aspx?Keyword=80-T491A106M016")
		(attr "RS Part Number" "8685839")
		(attr "RS Price/Stock" "https://uk.rs-online.com/web/p/products/8685839")
		(attr "Allied_Number" "70096233")
		(attr "Allied Price/Stock" "https://www.alliedelec.com/kemet-t491a106m016at/70096233/")
		(attr "Description" "KEMET - T491A106M016AT - CAP, TANT, 10UF, 16V, CASE A")
		(attr "Datasheet Link" "https://componentsearchengine.com/Datasheets/2/T491A106M016AT.pdf")
		(attr "Height" "1.6 mm")
	)

)
