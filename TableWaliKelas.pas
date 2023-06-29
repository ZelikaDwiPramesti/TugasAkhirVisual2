unit TableWaliKelas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZAbstractConnection, ZConnection, StdCtrls, Grids, DBGrids;

type
  TForm8 = class(TForm)
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    l7: TLabel;
    l8: TLabel;
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
    e7: TEdit;
    cbbc1: TComboBox;
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
    procedure FormShow(Sender: TObject);
    procedure dg1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;
  id : string;

implementation

{$R *.dfm}

procedure TForm8.bersih;
begin
e1.Clear;
e2.Clear;
cbbc1.text:= '';
e3.Clear;
e4.Clear;
e5.Clear;
e6.Clear;
e7.Clear;
end;

procedure TForm8.enable;
begin
e1.Enabled:= True;
e2.Enabled:= True;
cbbc1.Enabled:= True;
e3.Enabled:= True;
e4.Enabled:= True;
e5.Enabled:= True;
e6.Enabled:= True;
e7.Enabled:= True;
end;

procedure TForm8.posisiawal;
begin
bersih;

e1.Enabled:= false;
e2.Enabled:= false;
cbbc1.Enabled:= false;
e3.Enabled:= false;
e4.Enabled:= false;
e5.Enabled:= false;
e6.Enabled:= false;
e7.Enabled:= false;

b1.Enabled:= True;
b2.Enabled:= False;
b3.Enabled:= False;
b4.Enabled:= False;
b5.Enabled:= False;
end;

procedure TForm8.b1Click(Sender: TObject);
begin
bersih;

b1.Enabled:= false;
b2.Enabled:= True;
b3.Enabled:= False;
b4.Enabled:= False;
b5.Enabled:= True;

enable;
end;

procedure TForm8.b2Click(Sender: TObject);
begin
if (e1.Text= '')or (e2.Text ='')or(cbbc1.Text= '')or (e3.Text= '')or (e4.Text ='') or (e5.Text= '')or (e6.Text ='') or (e7.Text= '')then
begin
ShowMessage('DATA TIDAK BOLEH KOSONG!');
end else
if (zqry1.Locate('nik',e1.Text,[])) and (zqry1.Locate('nama',e2.Text,[])) then
begin
ShowMessage('DATA WALI KELAS SUDAH DIGUNAKAN');
posisiawal;
end else
begin
//simpan
zqry1.SQL.Clear;
zqry1.SQL.Add('insert into table_wali_kelas values (null,"'+e1.Text+'","'+e2.Text+'","'+cbbc1.Text+'","'+e3.Text+'","'+e4.Text+'","'+e5.Text+'","'+e6.Text+'","'+e7.Text+'")');
zqry1.ExecSQL;

zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_wali_kelas');
zqry1.Open;
ShowMessage('DATA BERHASIL DISIMPAN!');
posisiawal;

end;
end;

procedure TForm8.b3Click(Sender: TObject);
begin
if (e1.Text= '')or (e2.Text ='')or(cbbc1.Text= '')or (e3.Text= '')or (e4.Text ='') or (e5.Text= '')or (e6.Text ='') or (e7.Text= '')then
begin
ShowMessage('INPUTAN WAJIB DIISI!');
end else
if (e1.Text = zqry1.Fields[1].AsString) and (e2.Text = zqry1.Fields[2].AsString) and (cbbc1.Text = zqry1.Fields[3].AsString) and (e3.Text = zqry1.Fields[4].AsString) and (e4.Text = zqry1.Fields[5].AsString) and (e5.Text = zqry1.Fields[6].AsString) and (e6.Text = zqry1.Fields[7].AsString)and (e7.Text = zqry1.Fields[8].AsString) then
begin
ShowMessage('DATA TIDAK ADA PERUBAHAN');
posisiawal;
end else
begin
id:=dg1.DataSource.DataSet.FieldByName('id_wali').AsString;
ShowMessage('DATA BERHASIL DIUPDATE!'); //UPDATE
zqry1.SQL.Clear;
zqry1.SQL.Add('Update table_wali_kelas set nik= "'+e1.Text+'",nama="'+e2.Text+'",jenis_kelamin="'+cbbc1.Text+'",pendidikan="'+e3.Text+'",telp="'+e4.Text+'",matpel="'+e5.Text+'",alamat="'+e6.Text+'",status="'+e7.Text+'" where id_wali="'+id+'"');
zqry1. ExecSQL;

zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_wali_kelas');
zqry1.Open;
posisiawal;
end;
end;

procedure TForm8.b4Click(Sender: TObject);
begin
if MessageDlg('APAKAH YAKIN MENGHAPUS DATA INI?',mtWarning,[mbYes,mbNo],0)= mryes then
begin
id:=dg1.DataSource.DataSet.FieldByName('id_wali').AsString;
zqry1.SQL.Clear;
zqry1.SQL.Add(' delete from table_wali_kelas where id_wali="'+id+'"');
zqry1. ExecSQL;
zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_wali_kelas');
zqry1.Open;
ShowMessage('DATA BERHASIL DIHAPUS');
posisiawal;
end else
begin
ShowMessage('DATA BATAL DIHAPUS');
posisiawal;
end;
end;

procedure TForm8.b5Click(Sender: TObject);
begin
posisiawal;
end;

procedure TForm8.b6Click(Sender: TObject);
begin
frxrprt1.ShowReport();
end;

procedure TForm8.FormShow(Sender: TObject);
begin
posisiawal;
end;

procedure TForm8.dg1CellClick(Column: TColumn);
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
cbbc1.Text:= zqry1.FieldList[3].AsString;
e3.Text:= zqry1.FieldList[4].AsString;
e4.Text:= zqry1.FieldList[5].AsString;
e5.Text:= zqry1.FieldList[6].AsString;
e6.Text:= zqry1.FieldList[7].AsString;
e7.Text:= zqry1.FieldList[8].AsString;
end;

end.
