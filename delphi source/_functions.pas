unit _functions;
interface

 uses functions, sysutils, Winapi.Windows;

 { � � � � � � �   � � � � � � �}

  procedure bgroundAct;              // ������� ���������
  procedure bulletsAct;              // ����
  procedure enemiesAct;              // ���������
  procedure playerAct;               // ����� 1
  procedure player2Act;              // ����� 2
  procedure GUI;                     // ���������
  procedure spawnEN;                 // �������� ����������
  procedure controlsKD(key0:word);   // ����������
  procedure controlsKU(key0:word);   // ����������

implementation

  {
      � ������ ����� ������������ ������� ������� ��� ��������,
    ����������������� ���������� � ���������, ����������� ������������
    ������������� ���� � �������� �������� � ���������� ������� ������� ���������.                }


  uses main,menu;

  procedure bgroundAct;
  begin
    Bgrounds[0].scroll;
    Bgrounds[1].scroll;
    Bgrounds[2].scroll;

    Clouds[0].scroll('l');
    Clouds[1].scroll('r');

    hp.Scroll;

    inc(DelayBG);
    if DelayBG>14 then begin
      DelayBG:=0;
      Bgrounds[0].nextFrame;
      Bgrounds[1].nextFrame;
      Bgrounds[2].nextFrame;
    end;

    Form4.Image1.Canvas.Draw(Bgrounds[0].getX, Bgrounds[0].getY, Bgrounds[0].getBitmap);
    Form4.Image1.Canvas.Draw(Bgrounds[1].getX, Bgrounds[1].getY, Bgrounds[1].getBitmap);
    Form4.Image1.Canvas.Draw(Bgrounds[2].getX, Bgrounds[2].getY, Bgrounds[2].getBitmap);
    Form4.Image1.Canvas.Draw(Clouds[1].getX, Clouds[1].getY, Clouds[1].getBitmap);
    Form4.Image1.Canvas.Draw(hp.getX, hp.getY, hp.getBitmap);

  end;

  procedure bulletsAct;
  var i : integer;
  begin
    for i := 0 to 60 do
    begin

      if Bullets[i]<>nil then begin
        Bullets[i].moveY;
        Form4.Image1.Canvas.Draw(Bullets[i].getX, Bullets[i].getY, Bullets[i].getBitmap);
      end;

      if BulletsEn[i]<>nil then begin
        BulletsEn[i].moveY;
        Form4.Image1.Canvas.Draw(BulletsEn[i].getX, BulletsEn[i].getY, BulletsEn[i].getBitmap);
      end;

    end;

    if isExist then
      colBullet(player);

    if isExist2 then
      colBullet(player2);

  end;

  procedure enemiesAct;
  var i : integer;
  begin
    for i := 0 to 10 do
      if Enemies[i]<>nil then begin
        Enemies[i].shoot;
        Enemies[i].move;
        Enemies[i].nextFrame;
        Form4.Image1.Canvas.Draw(Enemies[i].getX, Enemies[i].getY, Enemies[i].getBitmap);
        if Enemies[i].getY > 800 then Enemies[i]:=nil ;

      end;
  end;

  procedure playerAct;
  begin
    if isExist then begin
        mapColider(player);
        player.move(MoveL,MoveR,MoveU,MoveD);
        Player.shoot(fire, bulSprite);
        Player.nextFrame;
        Form4.Image1.Canvas.Draw(Player.getX, Player.getY, Player.getBitmap);
    end;
  end;

  procedure player2Act;
  begin
    if isExist2 then begin
        mapColider(player2);
        player2.move(MoveL2,MoveR2,MoveU2,MoveD2);
        Player2.shoot(fire2, bulSprite2);
        Player2.nextFrame;
        Form4.Image1.Canvas.Draw(Player2.getX, Player2.getY, Player2.getBitmap);
    end;
  end;

  { � � � � � � � � � }
  procedure GUI;
  var i:integer;
  begin
    if isExist then begin
      Form4.label4.Visible:=True;
      Form4.label2.Visible:=true;
      Form4.label1.Caption := inttostr(player.getHP)+' HP';
      if player.getHP<1 then begin
        isExist := false;
        killed:=true;
        Form4.label1.Caption := 'DEAD'
      end;
    end;

    for i := 0 to 10 do
      if (Enemies[i]<>nil) and (Enemies[i].getTag = 'boss') then begin
        Form4.PBar1.Visible:=True;
        Form4.PBar1.Position:= Enemies[i].getHP;
      end;


    if ((killed) and (killed2)) or ((killed) and (not(isExist2))) then begin
      Form4.label3.Visible:=true;
      Form4.label5.Visible:=true;
      Form4.label4.Visible:=false;
      Form4.label5.Caption:=' YOUR SCORE :  '+inttostr(Score);
      Form4.Label9.Visible:=true;
      Form4.Label1.Caption:='R to RESTART';
      Form4.Label2.Visible := false;

    end;


    if isExist2 then begin

      Form4.label2.Caption := inttostr(player2.getHP)+' HP';
      if player2.getHP<1 then begin
        isExist2 := false;
        killed2:=true;
        Form4.label2.Caption := 'DEAD'
      end;
    end;

    Form4.label4.Caption := 'SCORE : '+inttostr(Score);

  end;

  { � � � � �  � � � � � � � � � � }
  procedure spawnEN;
  var i:integer;
  begin
    if (isExist) or (isExist2) then begin

    inc(delayFS);
    if delayFS>2 then begin
      delayFS:=0;
      newEnemy(Enemies, 'fast');
    end;

    inc(delayBB);
    if delayBB>7 then begin
      delayBB:=0;
      newEnemy(Enemies, 'BB');
    end;

    for i := 1 to kof do
      newEnemy(Enemies, 'normal');

    Form4.Spawn.Interval := Form4.Spawn.Interval -5;

    if Form4.Spawn.Interval <500 then
    begin
      inc(kof);
      Form4.Spawn.Interval:=950;
    end;

  end;

  if (isExist) or (isExist2) then begin
    if (Form4.Spawn.Interval = 800) or (Form4.Spawn.Interval = 600) or
       (Form4.Spawn.Interval = 700)or  (Form4.Spawn.Interval = 500)
      then begin
        player.setDelay(player.getDelay-1);
        for i := 0 to 2 do
          Bgrounds[i].setSpeed(Bgrounds[i].getSpeed+1);
        for i := 0 to 1 do
          Clouds[i].setSpeed(Clouds[i].getSpeed+1);
      end;

      if player.getDelay<4 then player.setDelay(4);
      if isExist2 then
        player2.setDelay(player.getDelay);
  end;

  if (isExist2) then begin
    if (Form4.Spawn.Interval = 800) or (Form4.Spawn.Interval = 600) or
       (Form4.Spawn.Interval = 700)or  (Form4.Spawn.Interval = 500)
      then begin
        player2.setDelay(player.getDelay-1);
        for i := 0 to 2 do
          Bgrounds[i].setSpeed(Bgrounds[i].getSpeed+1);
        for i := 0 to 1 do
          Clouds[i].setSpeed(Clouds[i].getSpeed+1);
      end;

      if player2.getDelay<4 then player2.setDelay(4);
      if isExist then
        player.setDelay(player2.getDelay);
  end;

  end;

  { � � � � � � � � � � }
  procedure controlsKD(Key0:word);
var
  i: Integer;        // K E Y   D O W N
  begin
    if isExist then begin
      If Key0 = ord('W') then MoveU := True;
      If Key0 = ord('S') then MoveD := True;
      If Key0 = ord('A') then begin MoveL := True; Player.setFrame(8,10) end;
      If Key0 = ord('D') then begin MoveR := True; Player.setFrame(11,13) end;
      If Key0 = VK_Space then Fire := True;
    end;

    if isExist2 then begin
      If Key0 = VK_Numpad8 then MoveU2 := True;
      If Key0 = VK_Numpad5 then MoveD2 := True;
      If Key0 = VK_Numpad4 then begin MoveL2 := True; Player2.setFrame(8,10) end;
      If Key0 = VK_Numpad6 then begin MoveR2 := True; Player2.setFrame(11,13) end;
      If Key0 = VK_Numpad0 then Fire2 := True;
    end;

    if (Key0 = ord('I')) and (not(Spawned)) then begin
        Spawned := True;
        isExist:=not(isExist);     // ����� ������ 1
        Player.setHP(300);
    end;

    if (Key0 = ord('O')) and (not(Spawned2)) and (isExist) then begin
        Spawned2 := True;
        isExist2:=not(isExist2);   // ����� ������ 2
        Player2.setHP(300);
    end;







    end;
  procedure controlsKU(key0:word);        // K E Y   U P
  begin
    if isExist then begin
    If Key0 = ord('W') then MoveU := False;
    If Key0 = ord('S') then MoveD := False;
    If Key0 = ord('A') then begin MoveL := False; Player.setFrame(0,7) end;
    If Key0 = ord('D') then begin MoveR := False; Player.setFrame(0,7) end;
    If Key0 = VK_Space then Fire := False;
  end;

  if isExist2 then begin
    If Key0 = VK_Numpad8 then MoveU2 := False;
    If Key0 = VK_Numpad5 then MoveD2 := False;
    If Key0 = VK_Numpad4 then begin MoveL2 := False; Player2.setFrame(0,7) end;
    If Key0 = VK_Numpad6 then begin MoveR2 := False; Player2.setFrame(0,7) end;
    If Key0 = VK_Numpad0 then Fire2 := False;
  end;

  end;

end.
