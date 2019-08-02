unit functions;

interface
  uses objects, Graphics;

  type TMasBL = array[0..60] of TBullet;
  type TMasEN = array[0..10] of Tenemy;

  function Collision(obj1:TBase; obj2:TBase; w1,h1,w2,h2:integer):boolean;
  procedure mapColider(player0:TPlayer);
  procedure newBullet(var mas0 : TMasBL; pict : TBitmap; x0,y0,speed0 : integer);
  procedure colBullet(player0:TPlayer);
  procedure newEnemy(var mas0 : TmasEN; tag:string);
  procedure restart;

implementation

  uses main;


function Collision(obj1:TBase; obj2:TBase; w1,h1,w2,h2:integer):boolean;
begin
  if(((obj2.getX <= obj1.getX) and (obj2.getX+w2 >= obj1.getx))or
   ((obj2.getX<=obj1.getX+w1) and (obj2.getX+w2>=obj1.getX+h1)))and
   (obj2.getY+h2 >= obj1.getY)and(obj2.getY <= obj1.getY+h1)
    then result := true else result := false;
end;

procedure mapColider(player0:TPlayer);
var i : integer;
begin
  if (Player0.getX <= 0) and ((moveL)or(moveL2))
    then Player0.setSpeed(0,plSpeed)
  else if (Player0.getX >= 520) and ((moveR)or(moveR2))
    then Player0.setSpeed(0,plSpeed)
  else if (Player0.getY>=700) and ((moveD)or(moveD2))
    then Player0.setSpeed(plSpeed,0)
  else if (Player0.getY<=250) and ((moveU)or(moveU2))
    then begin
      Player0.setSpeed(plSpeed,0);
      for i:=0 to 2 do
        BGrounds[i].setSpeed(7);
      Clouds[0].setSpeed(7);
      Clouds[1].setSpeed(7);
      for I := 0 to 10 do
        if (Enemies[i]<>nil)and(not(boss))then
        Enemies[i].setSpeed(Enemies[i].getSpeedX,8);

    end
  else begin
    Player0.setSpeed(plSpeed,plSpeed);
    for i:=0 to 2 do
        BGrounds[i].setSpeed(5);
    Clouds[0].setSpeed(5);
    Clouds[1].setSpeed(5);
  end;
  if collision(player0,hp,80,50,20,20) then begin
    player0.setHP(player0.getHP+20);
    hp.setY(random(2000)-6000);
    hp.setX(20+(Random(420)));
  end;
end;

procedure newBullet(var mas0 : TMasBL; pict : TBitmap; x0,y0,speed0 : integer);
var i : integer;
begin
  for i := 0 to 60 do
    if mas0[i]=nil then
      begin
        mas0[i] := TBullet.Create(x0, y0, pict );
        mas0[i].setSpeed(speed0);
        break;
      end;
end;







procedure colBullet(player0:TPlayer);
var i,j,f:integer;
begin

  { BULLET - ENEMY }
  for i := 0 to 10 do
      for j := 0 to 60 do
        if (Bullets[j]<>nil) and (Enemies[i]<>nil) then  begin


          if Enemies[i].getTag = 'BB' then
              if Collision(Bullets[j],Enemies[i],10,10,220,170)then begin
                Enemies[i].setHP(Enemies[i].getHP-1);
                if Enemies[i].getHP < 1 then begin Enemies[i] := nil; score := score + 40; end;
                Bullets[j]:=nil;
                continue;
              end;

          if Enemies[i].getTag = 'normal' then
              if Collision(Bullets[j],Enemies[i],10,10,80,50)then begin
                Enemies[i].setHP(Enemies[i].getHP-1);
                if Enemies[i].getHP = 2 then Enemies[i].setFrame(4,6);
                if Enemies[i].getHP = 1 then Enemies[i].setFrame(7,9);
                if Enemies[i].getHP < 1 then begin Enemies[i] := nil; score := score + 10; end;
                Bullets[j]:=nil;
                continue;
              end;

          if Enemies[i].getTag = 'fast' then
              if Collision(Bullets[j],Enemies[i],10,10,80,50)then begin
                Enemies[i].setHP(Enemies[i].getHP-1);
                if Enemies[i].getHP = 1 then Enemies[i].setFrame(4,6);
                if Enemies[i].getHP < 1 then begin Enemies[i] := nil; score := score + 15; end;
                Bullets[j]:=nil;
                continue;
              end;

          if Enemies[i].getTag = 'boss' then
              if Collision(Bullets[j],Enemies[i],10,10,400,240)then begin
                Enemies[i].setHP(Enemies[i].getHP-1);
                if Enemies[i].getHP < 1 then begin Enemies[i] := nil; score := score + 500; boss:=false; end;
                Bullets[j]:=nil;
                Form4.PBar1.Visible:=False;
                continue;
              end;
        end;





  for j := 0 to 60 do begin

  { BULLET - BULLET }
    for f := 0 to 60 do
      if (Bullets[j]<>nil)and(BulletsEn[f]<>nil) then
        if Collision(Bullets[j],BulletsEn[f],10,10,8,8)
          then begin
            Bullets[j]:=nil;
            BulletsEn[f]:=nil;
            continue;
          end;

  { BULLET - PLAYER }
    if (BulletsEN[j]<>nil) then
      if Collision(BulletsEn[j],Player0,8,8,80,50) then begin
          player0.setHP(player0.getHP-5);
          bulletsen[j]:= nil;
        end else if BulletsEn[j].getY > 800 then bulletsen[j]:= nil;

  { FRIENDLY FIRE }
    if (Bullets[j]<>nil) then
      if Collision(Bullets[j],Player0,10,10,80,50) then begin
            //player0.setHP(player0.getHP-5);
            Bullets[j]:=nil;
      end else if Bullets[j].getY < 0 then bullets[j]:= nil;

  end;

end;

procedure newEnemy(var mas0 : TmasEN; tag:string);
var i,randx,hpn,hpf,hpb,hpm : integer;
begin
  hpn:=3;
  hpf:=2;
  hpb:=5;


  hpm:=100+(100*kof div 2);
  if isExist and isExist2 then
  hpm:=150+(150*kof div 2);


  Form4.PBar1.Max:=hpm;

  if (isExist)and(isExist2) then begin
    hpn:=hpn+1;
    hpb:=hpb+2;
  end;

  if player.getDelay < 6 then begin
    hpn:=hpn+1;
    hpf:=hpf+1;
    hpb:=hpb+1;
  end;

  randomize;
  for i:=0 to 10 do
    if mas0[i]=nil then begin

      // ������� ����
      if tag ='normal' then
        begin
          randx:=50+Random(450);
          if kof = 1 then
            mas0[i] := TEnemy.CreateEN(randx,-60, enemyModel, 3, hpn, 40, 7, 9, tag )else
            mas0[i] := TEnemy.CreateEN(randx,random(340)-400, enemyModel, 3, hpn, 40, 7, 9, tag );
          mas0[i].setMid(False);
          if randx<150 then
            mas0[i].setSpeed(1,7);
          if randx>450 then
            mas0[i].setSpeed(-1,7);
          if (randx>150) and (randx<450) then
          begin
            mas0[i].setMid(True); mas0[i].setSpeed(0,7);
          end;

          break;
        end;

      // �����������
      if tag ='fast' then
        begin
          randx:=player.getX+player.getSpeed*10;
          mas0[i] := TEnemy.CreateEN(randx,-60, enemyModel2, 3, hpf, 10, 9, 15, tag );
          mas0[i].setMid(True); mas0[i].setSpeed(0,9);
          break;
        end;

      // ��������������
      if tag ='BB' then
        begin
          randx:=player.getX+player.getSpeed*10;
          mas0[i] := TEnemy.CreateEN(randx,-200, enemyModel3, 3, hpb, 30, 1, 9, tag );
          mas0[i].setMid(False); mas0[i].setSpeed(0,6);
          break;
        end;

      if tag ='boss' then
        begin
          mas0[i] := TEnemy.CreateEN(200,-500, enemyModel4, 3, hpm, 2, 1, 9, tag );
          break;
        end;

    end;


end;

procedure restart;
var i:integer;
begin
  isExist := False; isExist2 := False;
        Spawned := False; Spawned2 := False;
        Killed := False; Killed2 := False;
        Score := 0; KOF := 1;
        player.setDelay(12);
        player2.setDelay(12);
        Form4.Spawn.Interval:=1000;
        for i := 0 to 10 do
          Enemies[i]:=nil;
        boss := false;
        Form4.PBar1.Visible := false;
        Form4.label3.Visible := False;
        Form4.label4.Visible := False;
        Form4.label5.Visible := False;
        Form4.label5.Visible := False;
        Form4.label2.Visible := False;
        Form4.label1.Caption := 'Press I to START';
        Form4.label2.Caption := 'Press O     to join';
        Form4.label9.Visible :=false;

end;


end.
