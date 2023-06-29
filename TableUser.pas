unit TableUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZAbstractConnection, ZConnection, Grids, DBGrids, StdCtrls;

type
  TForm7 = class(TForm)
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    e1: TEdit;
    e2: TEdit;
    b1: TButton;
    b2: TButton;
    b3: TButton;
    b4: TButton;
    b5: TButton;
    dg1: TDBGrid;
    b6: TButton;
    e3: TEdit;
    e4: TEdit;
    DSds1: TDataSource;
    con1: TZConnection;
    zqry1: TZQuery;
    frxdbdtst1: TfrxDBDataset;
    frxrprt1: TfrxReport;
    procedure bersih;
    procedure enable;
    procedure posisiawal;
    procedure b1Click(Sender: TObject);
    procedure b2Click(Sender: TObject);
    procedure b3Click(Sender: TObject);
    procedure b4Click(Sender: TObject);
    procedure b5Click(Sender: TObject);
    procedure b6Click(Sender: TObject);
    procedure dg1CellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;
  id : string;

implementation

{$R *.dfm}

procedure TForm7.bersih;
begin
e1.Clear;
e2.Clear;
e3.Clear;
e4.Clear;
end;

procedure TForm7.enable;
begin
e1.Enabled:= True;
e2.Enabled:= True;
e3.Enabled:= True;
e4.Enabled:= True;
end;

procedure TForm7.posisiawal;
begin
bersih;

e1.Enabled:= false;
e2.Enabled:= false;
e3.Enabled:= false;
e4.Enabled:= false;

b1.Enabled:= True;
b2.Enabled:= False;
b3.Enabled:= False;
b4.Enabled:= False;
b5.Enabled:= False;
end;

procedure TForm7.b1Click(Sender: TObject);
begin
bersih;

b1.Enabled:= false;
b2.Enabled:= True;
b3.Enabled:= False;
b4.Enabled:= False;
b5.Enabled:= True;

enable;
end;

procedure TForm7.b2Click(Sender: TObject);
begin
if (e1.Text= '')or (e2.Text ='')or(e3.Text= '')or (e4.Text ='')then
begin
ShowMessage('DATA TIDAK BOLEH KOSONG!');
end else
if (zqry1.Locate('username',e1.Text,[])) and (zqry1.Locate('password',e2.Text,[])) then
begin
ShowMessage('DATA USER SUDAH DIGUNAKAN');
posisiawal;
end else
begin
//simpan
zqry1.SQL.Clear;
zqry1.SQL.Add('insert into table_user values (null,"'+e1.Text+'","'+e2.Text+'","'+e3.Text+'","'+e4.Text+'")');
zqry1.ExecSQL;

zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_user');
zqry1.Open;
ShowMessage('DATA BERHASIL DISIMPAN!');
posisiawal;

end;
end;
procedure TForm7.b3Click(Sender: TObject);
begin
if (e1.Text= '')or (e2.Text ='')or (e3.Text= '')or (e4.Text ='') then
begin
ShowMessage('INPUTAN WAJIB DIISI!');
end else
if (e1.Text = zqry1.Fields[1].AsString) and (e2.Text = zqry1.Fields[2].AsString) and (e3.Text = zqry1.Fields[3].AsString) and (e4.Text = zqry1.Fields[4].AsString)then
begin
ShowMessage('DATA TIDAK ADA PERUBAHAN');
posisiawal;
end else
begin
id:=dg1.DataSource.DataSet.FieldByName('id_user').AsString;
ShowMessage('DATA BERHASIL DIUPDATE!'); //UPDATE
zqry1.SQL.Clear;
zqry1.SQL.Add('Update table_user set username= "'+e1.Text+'",password="'+e2.Text+'",level="'+e3.Text+'",status="'+e4.Text+'" where id_user="'+id+'"');
zqry1. ExecSQL;

zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_user');
zqry1.Open;
posisiawal;
end;
end;

procedure TForm7.b4Click(Sender: TObject);
begin
if MessageDlg('APAKAH YAKIN MENGHAPUS DATA INI?',mtWarning,[mbYes,mbNo],0)= mryes then
begin
id:=dg1.DataSource.DataSet.FieldByName('id_user').AsString;
zqry1.SQL.Clear;
zqry1.SQL.Add(' delete from table_user where id_user="'+id+'"');
zqry1. ExecSQL;
zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_user');
zqry1.Open;
ShowMessage('DATA BERHASIL DIHAPUS');
posisiawal;
end else
begin
ShowMessage('DATA BATAL DIHAPUS');
posisiawal;
end;
end;

procedure TForm7.b5Click(Sender: TObject);
begin
posisiawal;
end;

procedure TForm7.b6Click(Sender: TObject);
begin
frxrprt1.ShowReport();
end;

procedure TForm7.dg1CellClick(Column: TColumn);
begin
enable;
b1.Enabled:= true;
b2.Enabled:= False;
b3.Enabled:= True;
b4.Enabled:= True;
b5.Enabled:= True;
id:=zqry1.Fields[0].AsString;
e1.Text:= zqry1.FieldList[1].AsString;
e2.Text:= zqry1.FieldList[2].AsString;
e3.Text:= zqry1.FieldList[3].AsString;
e4.Text:= zqry1.FieldList[4].AsString;
end;

procedure TForm7.FormShow(Sender: TObject);
begin
posisiawal;
end;

end.
