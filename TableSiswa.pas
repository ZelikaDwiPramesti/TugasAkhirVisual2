unit TableSiswa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZAbstractConnection, ZConnection, ComCtrls, StdCtrls, Grids,
  DBGrids;

type
  TForm5 = class(TForm)
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    l7: TLabel;
    l8: TLabel;
    l9: TLabel;
    l10: TLabel;
    l11: TLabel;
    l12: TLabel;
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
    e5: TEdit;
    e6: TEdit;
    cbbc1: TComboBox;
    e7: TEdit;
    e8: TEdit;
    e9: TEdit;
    dtp1: TDateTimePicker;
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
    procedure FormShow(Sender: TObject);
    procedure dg1CellClick(Column: TColumn);
    procedure b6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  id : string;

implementation

{$R *.dfm}

procedure TForm5.bersih;
begin
e1.Clear;
e2.Clear;
e3.Clear;
e4.Clear;
e5.Clear;
e6.Clear;
cbbc1.text:= '';
e7.Clear;
e8.Clear;
e9.Clear;
end;

procedure TForm5.enable;
begin
e1.Enabled:= True;
e2.Enabled:= True;
e3.Enabled:= True;
e4.Enabled:= True;
e5.Enabled:= True;
dtp1.Enabled:=True;
e6.Enabled:= True;
cbbc1.Enabled:= True;
e7.Enabled:= True;
e8.Enabled:= True;
e9.Enabled:= True;
end;

procedure TForm5.posisiawal;
begin
bersih;

e1.Enabled:= false;
e2.Enabled:= false;
e3.Enabled:= false;
e4.Enabled:= false;
e5.Enabled:= false;
dtp1.Enabled:=false;
e6.Enabled:= false;
cbbc1.Enabled:= false;
e7.Enabled:= false;
e8.Enabled:= false;
e9.Enabled:= false;

b1.Enabled:= True;
b2.Enabled:= False;
b3.Enabled:= False;
b4.Enabled:= False;
b5.Enabled:= False;
end;

procedure TForm5.b1Click(Sender: TObject);
begin
bersih;

b1.Enabled:= false;
b2.Enabled:= True;
b3.Enabled:= False;
b4.Enabled:= False;
b5.Enabled:= True;

enable;
end;

procedure TForm5.b2Click(Sender: TObject);
begin
if (e1.Text= '')or (e2.Text ='')or (e3.Text= '')or (e4.Text ='') or (e5.Text= '')or (e6.Text ='') or (cbbc1.Text= '')or (e7.Text= '') or (e8.Text= '') or (e9.Text= '')then
begin
ShowMessage('DATA TIDAK BOLEH KOSONG!');
end else
if (zqry1.Locate('nis',e1.Text,[])) and (zqry1.Locate('nisn',e2.Text,[])) then
begin
ShowMessage('DATA SISWA SUDAH DIGUNAKAN');
posisiawal;
end else
begin
//simpan
zqry1.SQL.Clear;
zqry1.SQL.Add('insert into table_siswa values (null,"'+e1.Text+'","'+e2.Text+'","'+e3.Text+'","'+e4.Text+'","'+e5.Text+'","'+FormatDateTime('yyyy-mm-dd',dtp1.Date)+'","'+e6.Text+'","'+cbbc1.Text+'","'+e7.Text+'","'+e8.Text+'","'+e9.Text+'")');
zqry1.ExecSQL;

zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_siswa');
zqry1.Open;
ShowMessage('DATA BERHASIL DISIMPAN!');
posisiawal;

end;
end;
procedure TForm5.b3Click(Sender: TObject);
begin
if (e1.Text= '')or (e2.Text ='')or (e3.Text= '')or (e4.Text ='') or (e5.Text= '')or (e6.Text ='') or (cbbc1.Text= '')or (e7.Text= '') or (e8.Text= '')or (e9.Text= '')then
begin
ShowMessage('INPUTAN WAJIB DIISI!');
end else
if (e1.Text = zqry1.Fields[1].AsString) and (e2.Text = zqry1.Fields[2].AsString) and  (e3.Text = zqry1.Fields[3].AsString) and (e4.Text = zqry1.Fields[4].AsString) and (e5.Text = zqry1.Fields[5].AsString) and (e6.Text = zqry1.Fields[6].AsString)and (cbbc1.Text = zqry1.Fields[7].AsString) and (e7.Text = zqry1.Fields[8].AsString) and (e8.Text = zqry1.Fields[9].AsString) and (e9.Text = zqry1.Fields[10].AsString) then
begin
ShowMessage('DATA TIDAK ADA PERUBAHAN');
posisiawal;
end else
begin
id:=dg1.DataSource.DataSet.FieldByName('id_siswa').AsString;
ShowMessage('DATA BERHASIL DIUPDATE!'); //UPDATE
zqry1.SQL.Clear;
zqry1.SQL.Add('Update table_siswa set nis= "'+e1.Text+'",nisn="'+e2.Text+'",nama="'+e3.Text+'",nik="'+e4.Text+'",tempat_lahir="'+e5.Text+'",tgl_lahir="'+FormatDateTime('yyyy-mm-dd',dtp1.Date)+'",jenis_kelamin="'+cbbc1.Text+'",alamat="'+e6.Text+'",telp="'+e7.Text+'",hp="'+e8.Text+'",status="'+e9.Text+'" where id_siswa="'+id+'"');
zqry1. ExecSQL;

zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_siswa');
zqry1.Open;
posisiawal;
end;
end;

procedure TForm5.b4Click(Sender: TObject);
begin
if MessageDlg('APAKAH YAKIN MENGHAPUS DATA INI?',mtWarning,[mbYes,mbNo],0)= mryes then
begin
id:=dg1.DataSource.DataSet.FieldByName('id_siswa').AsString;
zqry1.SQL.Clear;
zqry1.SQL.Add(' delete from table_siswa where id_siswa="'+id+'"');
zqry1. ExecSQL;
zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_siswa');
zqry1.Open;
ShowMessage('DATA BERHASIL DIHAPUS');
posisiawal;
end else
begin
ShowMessage('DATA BATAL DIHAPUS');
posisiawal;
end;
end;

procedure TForm5.b5Click(Sender: TObject);
begin
posisiawal;
end;

procedure TForm5.FormShow(Sender: TObject);
begin
posisiawal;
end;

procedure TForm5.dg1CellClick(Column: TColumn);
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
e5.Text:= zqry1.FieldList[5].AsString;
dtp1.Date:=Form5.zqry1.Fields[6].AsDateTime;
e6.Text:= zqry1.FieldList[8].AsString;
cbbc1.Text:= zqry1.FieldList[7].AsString;
e7.Text:= zqry1.FieldList[9].AsString;
e8.Text:= zqry1.FieldList[10].AsString;
e9.Text:= zqry1.FieldList[11].AsString;
end;

procedure TForm5.b6Click(Sender: TObject);
begin
frxrprt1.ShowReport();
end;

end.
