unit TableHubungan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frxClass, frxDBSet, ZAbstractConnection, ZConnection,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids;

type
  TForm3 = class(TForm)
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    e1: TEdit;
    e2: TEdit;
    b1: TButton;
    b2: TButton;
    b3: TButton;
    b4: TButton;
    b5: TButton;
    dg1: TDBGrid;
    b6: TButton;
    cbbc1: TComboBox;
    cbbc2: TComboBox;
    e3: TEdit;
    DSds1: TDataSource;
    con1: TZConnection;
    zqry1: TZQuery;
    frxdbdtst1: TfrxDBDataset;
    frxrprt1: TfrxReport;
    zqry2: TZQuery;
    zqry3: TZQuery;
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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  id : string;

implementation

{$R *.dfm}

procedure TForm3.bersih;
begin
cbbc1.text:= '';
cbbc2.text:= '';
e1.Clear;
e2.Clear;
e3.Clear;
end;

procedure TForm3.enable;
begin
cbbc1.Enabled:= True;
cbbc2.Enabled:= True;
e1.Enabled:= True;
e2.Enabled:= True;
e3.Enabled:= True;
end;

procedure TForm3.posisiawal;
begin
bersih;

cbbc1.Enabled:= false;
cbbc2.Enabled:= false;
e1.Enabled:= false;
e2.Enabled:= false;
e3.Enabled:= false;


b1.Enabled:= True;
b2.Enabled:= False;
b3.Enabled:= False;
b4.Enabled:= False;
b5.Enabled:= False;
end;

procedure TForm3.b1Click(Sender: TObject);
begin
bersih;

b1.Enabled:= false;
b2.Enabled:= True;
b3.Enabled:= False;
b4.Enabled:= False;
b5.Enabled:= True;

enable;
end;

procedure TForm3.b2Click(Sender: TObject);
begin
if (cbbc1.Text= '')or (cbbc2.Text= '') or (e1.Text= '')or (e2.Text ='') or (e3.Text ='') then
begin
ShowMessage('DATA TIDAK BOLEH KOSONG!');
end else
begin
//simpan
zqry1.SQL.Clear;
zqry1.SQL.Add('insert into table_hubungan values (null,"'+cbbc1.Text+'","'+cbbc2.Text+'","'+e1.Text+'","'+e2.Text+'","'+e3.Text+'")');
zqry1.ExecSQL;

zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_hubungan');
zqry1.Open;
ShowMessage('DATA BERHASIL DISIMPAN!');
posisiawal;

end;
end;

procedure TForm3.b3Click(Sender: TObject);
begin
if (cbbc1.Text= '')or (cbbc2.Text= '') or (e1.Text= '')or (e2.Text ='') or (e3.Text ='')then
begin
ShowMessage('INPUTAN WAJIB DIISI!');
end else
if (cbbc1.Text = zqry1.Fields[1].AsString) and (cbbc2.Text = zqry1.Fields[2].AsString) and (e1.Text = zqry1.Fields[3].AsString) and (e2.Text = zqry1.Fields[4].AsString) and (e3.Text = zqry1.Fields[5].AsString) then
begin
ShowMessage('DATA TIDAK ADA PERUBAHAN');
posisiawal;
end else
begin
id:=dg1.DataSource.DataSet.FieldByName('id_hub').AsString;
ShowMessage('DATA BERHASIL DIUPDATE!'); //UPDATE
zqry1.SQL.Clear;
zqry1.SQL.Add('Update table_hubungan set id_siswa="'+cbbc1.Text+'",id_ortu="'+cbbc2.Text+'",status_hubungan= "'+e1.Text+'",keterangan="'+e2.Text+'" ,status_ortu="'+e3.Text+'" where id_hub="'+id+'"');
zqry1.ExecSQL;

zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_hubungan');
zqry1.Open;
posisiawal;
end;
end;

procedure TForm3.b4Click(Sender: TObject);
begin
if MessageDlg('APAKAH YAKIN MENGHAPUS DATA INI?',mtWarning,[mbYes,mbNo],0)= mryes then
begin
id:=dg1.DataSource.DataSet.FieldByName('id_hub').AsString;
zqry1.SQL.Clear;
zqry1.SQL.Add(' delete from table_hubungan where id_hub="'+id+'"');
zqry1. ExecSQL;
zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_hubungan');
zqry1.Open;
ShowMessage('DATA BERHASIL DIHAPUS');
posisiawal;
end else
begin
ShowMessage('DATA BATAL DIHAPUS');
posisiawal;
end;
end;

procedure TForm3.b5Click(Sender: TObject);
begin
posisiawal;
end;

procedure TForm3.b6Click(Sender: TObject);
begin
frxrprt1.ShowReport();
end;

procedure TForm3.dg1CellClick(Column: TColumn);
begin
enable;
b1.Enabled:= true;
b2.Enabled:= False;
b3.Enabled:= True;
b4.Enabled:= True;
b5.Enabled:= True;
id:=zqry1.Fields[0].AsString;
cbbc1.Text:= zqry1.FieldList[1].AsString;
cbbc2.Text:= zqry1.FieldList[2].AsString;
e1.Text:= zqry1.FieldList[3].AsString;
e2.Text:= zqry1.FieldList[4].AsString;
e3.Text:= zqry1.FieldList[5].AsString;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
posisiawal;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
zqry2.First;
while not zqry2.Eof do
begin
  cbbc1.items.add(zqry2.fieldbyname('id_siswa').asstring);
  zqry2.Next;
end;
zqry3.First;
while not zqry3.Eof do
begin
  cbbc2.items.add(zqry3.fieldbyname('id_ortu').asstring);
  zqry3.Next;
end;
end;

end.
