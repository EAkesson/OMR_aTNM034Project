# OMR_aTNM034Project

Bild l�ses in.
Bild g�rs till double (v�rden mellan 0-1).

(Preprocessing)

Rotation (l�gg in i main)

(Hitta och spara staffline-information)

Ta bort stafflines (l�gg in i main)

(Dela upp bild i rader.)

F�r varje rad: 

G-klav tas bort med template matching. 

Hitta nothuvud
	Allt utom cirklar tas bort med open och str. element
	Houghtransform f�r att hitta center
	Nothuvud sorteras efter x-led

Bilden delas upp i sm� bilder (en not i varje bild)

F�r varje not-bild (ackord = 1 notbild): 

Center av nothuvud hittas
	Allt utom cirklar tas bort med open och str. element
	Houghtransform f�r att hitta center
	Nothuvud sorteras efter y-led

Rytm hittas
	Allt utom flaggor och beams tas bort
	Mha tv� kolumner r�knas antalet flaggor och beams 

Notnamn hittas (j�mf�r centerposition med stafflines-kordinater)


	


