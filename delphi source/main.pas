unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, objects, graphic, functions,_functions,menu, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls;

type

  //TMasBL = array[0..30] of TBullet;
  //TMasEN = array[0..10] of Tenemy;

  TForm4 = class(TForm)
    Image1: TImage;
    Update: TTimer;
    Spawn: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PBar1: TProgressBar;
    Label8: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UpdateTimer(Sender: TObject);
    procedure SpawnTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

  // ������������ �������
  PlayerModel,PlayerModel2 : TMasBM;
  EnemyModel,EnemyModel2,EnemyModel3,EnemyModel4 : TMasBM;
  bgSprite0,bgSprite1,bgSprite2,bgClouds : TMasBM;

  // ��������� �������
  bulSprite,bulSprite2,bulSpriteEN,hpSprite : TBitmap;

  // �������
  Player,Player2  : TPlayer;
  Bgrounds : array[0..2] of TBground;
  Clouds : array[0..1] of TClouds;
  Bullets,BulletsEn : TMasBL;
  Enemies : TMasEN;
  HP:TItem;

  // ��� ���������
  MoveR, MoveL, MoveU, MoveD, Fire : boolean;
  MoveR2, MoveL2, MoveU2, MoveD2, Fire2 : boolean;

  // �������
  Pause,isExist,isExist2,Killed,Killed2,Spawned,Spawned2,Boss :boolean;

  // ��������
  plSpeed,KOF,Score,DelayFS,DelayBB,DelayBG : integer;

implementation

{$R *.dfm}

uses result;





procedure TForm4.FormCreate(Sender: TObject);
var i:integer;
begin
  randomize;
  { � � � � � � � � � � � � � }

  plSpeed := 4;     // ��������� �������� ������
  Score := 0;       // ������� �����
  KOF:=1;           // ����������� ���-�� ������
  Pause := true;
  isExist:= false; isExist2:=false;
  Killed:=false; Killed2:=false;
  Boss := False;

  DelayFS:=0;    // �������� ��������� 'FAST' ������
  DelayBB:=0;    // �������� ��������� ' BB ' ������
  DelayBG:=0;    // ���������� �������� ����

  // �������� �������
  DoubleBuffered := True; // ���������� ��������
  loadGraphics;           // �������� �������

  // �������� �������� ���������
  Bgrounds[0] := TBground.Create(0, -400, bgSprite0,4); Bgrounds[0].setSpeed(5);
  Bgrounds[1] := TBground.Create(0, 400, bgSprite1,4); Bgrounds[1].setSpeed(5);
  Bgrounds[2] := TBground.Create(0, -1200, bgSprite2,4); Bgrounds[2].setSpeed(5);
  Clouds[0] := TClouds.Create(Random(600), -400, bgClouds, 17); Clouds[0].setSpeed(5);
  Clouds[1] := TClouds.Create(Random(600), -600, bgClouds, 17); Clouds[1].setSpeed(5);
  HP := TItem.Create(20+(Random(420)), -20, hpSprite); HP.setSpeed(5);


  // �������� �������� �������
  Player := TPlayer.Create(300,600,playerModel,7);
  Player2 := TPlayer.Create(200,600,playerModel2,7);


end;


procedure TForm4.FormKeyDown(Sender: TObject; var Key: Word;

  Shift: TShiftState);
var i:integer;
begin
  controlsKD(key);

  If Key = VK_Escape then begin
    button1.Caption := 'CONTINUE';
    label8.Caption := 'PAUSE';
    pause := not(pause);
    Spawn.Enabled:=pause;
    Update.Enabled:=pause;   // ��������� ��������
    label8.Visible := not(label8.Visible);
    button1.Visible := not(button1.Visible);
    button2.Visible := not(button2.Visible);
    button3.Visible := not(button3.Visible);
  end;

  If (Key = VK_RETURN) and (label5.Visible = true) then begin
    Form2.ShowModal;
  end;

  If (Key = $52) then begin
    restart;
  end;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  pause := not(pause);
  Spawn.Enabled:=pause;
  Update.Enabled:=pause;   // ��������� ��������
  label8.Visible := not(label8.Visible);
  button1.Visible := not(button1.Visible);
  button2.Visible := not(button2.Visible);
  button3.Visible := not(button3.Visible);
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Form1.Show;
  Form4.Close;
end;


procedure TForm4.Button3Click(Sender: TObject);
begin
  Application.Terminate;
end;



procedure TForm4.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  controlsKU(key);
end;




procedure TForm4.UpdateTimer(Sender: TObject);
var i,nen,nbl,ebl:integer;
begin

    bgroundAct;
    enemiesAct;
    playerAct;
    player2Act;
    bulletsAct;
    GUI;



  // ��������� ������ �������� ��������� ��� ������� ������� ��� ��� !
  Image1.Canvas.Draw(Clouds[0].getX, Clouds[0].getY, Clouds[0].getBitmap);
end;

procedure TForm4.SpawnTimer(Sender: TObject);
begin
  if not(boss) then
    spawnEN;
  if ((Score >= 500)and(Score<1000))or((Score >=  2000)and(Score<2500))or((Score >= 4000)and(Score<4500))
  then
    if not(boss) then begin
      boss := true;
      newEnemy(Enemies, 'boss');
    end;
end;
end.

