# OMR_aTNM034Project

Bild läses in.
Bild görs till double (värden mellan 0-1).

(Preprocessing)

Rotation (lägg in i main)

(Hitta och spara staffline-information)

Ta bort stafflines (lägg in i main)

(Dela upp bild i rader.)

För varje rad: 

G-klav tas bort med template matching. 

Hitta nothuvud
	Allt utom cirklar tas bort med open och str. element
	Houghtransform för att hitta center
	Nothuvud sorteras efter x-led

Bilden delas upp i små bilder (en not i varje bild)

För varje not-bild (ackord = 1 notbild): 

Center av nothuvud hittas
	Allt utom cirklar tas bort med open och str. element
	Houghtransform för att hitta center
	Nothuvud sorteras efter y-led

Rytm hittas
	Allt utom flaggor och beams tas bort
	Mha två kolumner räknas antalet flaggor och beams 

Notnamn hittas (jämför centerposition med stafflines-kordinater)


	


