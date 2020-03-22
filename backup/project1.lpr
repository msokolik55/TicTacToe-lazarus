program project1;
uses wincrt, graph;

type
  matica = array [1..3, 1..3] of integer;

var gd, gm: smallint;
    ch: char;
    x1, y1, rozmer, vitaz: integer;
    koniec: boolean;

procedure krizik(x, y, rozmer: integer);
begin
  setcolor(red);
  line(x, y, x - rozmer div 2, y - rozmer div 2);
  line(x, y, x + rozmer div 2, y - rozmer div 2);
  line(x, y, x - rozmer div 2, y + rozmer div 2);
  line(x, y, x + rozmer div 2, y + rozmer div 2);
end;

procedure kruzok(x, y, rozmer: integer);
begin
  setcolor(blue);
  circle(x, y, rozmer div 2);
end;

procedure nakresliPlochu(x1, y1, rozmer: integer; plocha: matica);
var i, j: integer;
begin
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
    begin
      setcolor(white);
      rectangle(x1, y1, x1 + rozmer, y1 + rozmer);

      if(plocha[i, j] = 1) then krizik(x1 + rozmer div 2, y1 + rozmer div 2, rozmer - 1)
      else if(plocha[i, j] = 2) then kruzok(x1 + rozmer div 2, y1 + rozmer div 2, rozmer - 1);

      x1 := x1 + rozmer;
    end;

    x1 := x1 - 3 * rozmer;
    y1 := y1 + rozmer;
  end;
end;

procedure skontrolujVitaza(plocha: matica; var vitaz: integer);
var i: integer;
begin
  // kontrola riadkov
  for i := 1 to 3 do
    if(plocha[i, 1] <> 0) and
      (plocha[i, 1] = plocha[i, 2]) and (plocha[i, 2] = plocha[i, 3]) then
      vitaz := plocha[i, 1];

  // kontrola stlpcov
  for i := 1 to 3 do
    if(plocha[1, i] <> 0) and
      (plocha[1, i] = plocha[2, i]) and (plocha[2, i] = plocha[3, i]) then
      vitaz := plocha[1, i];

  // kontrola hlavnej diagonaly
  if(plocha[1, 1] <> 0) and
    (plocha[1, 1] = plocha[2, 2]) and (plocha[2, 2] = plocha[3, 3]) then
    vitaz := plocha[1, 1];

  // kontrola vedlajsej diagonaly
  if(plocha[1, 3] <> 0) and
    (plocha[1, 3] = plocha[2, 2]) and (plocha[2, 2] = plocha[3, 1]) then
    vitaz := plocha[1, 3];
end;

procedure hra(x1, y1, rozmer: integer; var vitaz: integer);
var plocha: matica;
    i, j, hrac, pohyby: integer;
    koniec: boolean;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      plocha[i, j] := 0;

  koniec := False;
  hrac := 1;
  pohyby := 0; 
  nakresliPlochu(x1, y1, rozmer, plocha);

  repeat
    ch := readkey;

    if(ch = '7') and (plocha[1, 1] = 0) then
    begin
      plocha[1, 1] := hrac;
      pohyby := pohyby + 1;  

      if(hrac = 1) then hrac := 2
      else hrac := 1;
    end;

    if(ch = '8') and (plocha[1, 2] = 0) then
    begin
      plocha[1, 2] := hrac;
      pohyby := pohyby + 1;   

      if(hrac = 1) then hrac := 2
      else hrac := 1;
    end;

    if(ch = '9') and (plocha[1, 3] = 0) then
    begin
      plocha[1, 3] := hrac;
      pohyby := pohyby + 1; 

      if(hrac = 1) then hrac := 2
      else hrac := 1;
    end;

    if(ch = '4') and (plocha[2, 1] = 0) then
    begin
      plocha[2, 1] := hrac;
      pohyby := pohyby + 1; 

      if(hrac = 1) then hrac := 2
      else hrac := 1;
    end;

    if(ch = '5') and (plocha[2, 2] = 0) then
    begin
      plocha[2, 2] := hrac;
      pohyby := pohyby + 1;  

      if(hrac = 1) then hrac := 2
      else hrac := 1;
    end;

    if(ch = '6') and (plocha[2, 3] = 0) then
    begin
      plocha[2, 3] := hrac;
      pohyby := pohyby + 1; 

      if(hrac = 1) then hrac := 2
      else hrac := 1;
    end;

    if(ch = '1') and (plocha[3, 1] = 0) then
    begin
      plocha[3, 1] := hrac;
      pohyby := pohyby + 1; 

      if(hrac = 1) then hrac := 2
      else hrac := 1;
    end;

    if(ch = '2') and (plocha[3, 2] = 0) then
    begin
      plocha[3, 2] := hrac;
      pohyby := pohyby + 1; 

      if(hrac = 1) then hrac := 2
      else hrac := 1;
    end;

    if(ch = '3') and (plocha[3, 3] = 0) then
    begin
      plocha[3, 3] := hrac;
      pohyby := pohyby + 1;

      if(hrac = 1) then hrac := 2
      else hrac := 1;
    end;

    nakresliPlochu(x1, y1, rozmer, plocha);
    skontrolujVitaza(plocha, vitaz);

    if(pohyby = 9) or (vitaz <> 0) then koniec := True;
  until koniec;
end;

procedure vypisVitaza(x1, y1, vitaz: integer);
var s: string;
begin
  setcolor(white);
  settextstyle(1, 0, 3);
  if(vitaz <> 0) then
  begin
    str(vitaz, s);
    s := 'WINNER: ' + s;
  end
  else s := 'Remiza'; 

  outtextxy(x1, y1, s);
end;

begin
  gd := detect;
  initgraph(gd, gm, '');

  repeat
    // default hodnoty, obrazovka
    setfillstyle(1, black);
    bar(1, 1, 2000, 1000);

    x1 := 100;
    y1 := 150;
    rozmer := 100;
    vitaz := 0;

    settextstyle(1, 0, 3);
    outtextxy(x1 + 20, y1 - 70, 'Tic-Tac-Toe');

    hra(x1, y1, rozmer, vitaz);

    y1 := y1 + 3 * rozmer + 20;
    vypisVitaza(x1 + 50, y1, vitaz);

    settextstyle(1, 0, 2);
    y1 := y1 + 50;
    outtextxy(x1, y1, 'Enter - Play Again');
    y1 := y1 + 30;
    outtextxy(x1, y1, 'ESC - Quit');

    // stlacena klaves na konci hry
    repeat
      ch := readkey;
    until (ch = chr(13)) or (ch = chr(27));
    if(ch = chr(27)) then koniec := True
    else koniec := False;

    until koniec;

  closegraph();
end.

