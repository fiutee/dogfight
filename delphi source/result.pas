unit result;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Data.DB, Data.Win.ADODB, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses DM, main, menu;

procedure TForm2.Button1Click(Sender: TObject);
var i,newmax:integer; newmaxname:string;
begin
  with ADOQuery1 do begin
        SQL.Clear();
        SQL.Add('SELECT * FROM score');
        Open();
        Active:=true;
        Insert;
        FieldByName('�����').AsString:=edit1.Text;
        FieldByName('����').AsString:=Score.ToString;
        Post;
  end;

  Form2.Close;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Form2.Close;
end;

end.
