Promijenjena verzija pogodi_bistabil.vhd za provjeru rješenja.
Radi ovako:
Ak je onaj lijevo switch dolje bit ce prikazani svi bistabili, 
ak je onaj lijevo switch dolje, onda ce, ovisno o preostala 3 svijetliti najvise bistabil,
ali na puno drukciji nacin nego inace. 
za ostala 3 switcha ce po tablici danoj nize svijetliti bistabil NA SVOM MJESTU.

000: SR

001: D latch

010: D flip-flop

011: D flip-flop, asinkroni SR

100: D flip-flop, sinkroni SR

101: D flip-flop s enable ulazom, sinkroni SR

111: JK

110: T

0 znaci da je switch dolje, a 1 da je gore.

Primjer:
Ako je switch(2) gore, switch(1) gore, i switch(0) dolje, to znaci da ako stiscemo tipke levo i desno,
i zasvijetli lampica led(2), da u tablicu pod T bistabil pisemo 2.

Procitajte pripremu jos jednom ako je nejasno kako stvari funkcioniraju.
Ako ima i daljnjih nejasnoca posaljite mi PM.