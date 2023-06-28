unit TableSemester;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZAbstractConnection, ZConnection, ComCtrls, StdCtrls, Grids,
  DBGrids;

type
  TForm6 = class(TForm)
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    l8: TLabel;
    l9: TLabel;
    l7: TLabel;
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
    cbbc3: TComboBox;
    cbbc4: TComboBox;
    cbbc5: TComboBox;
    dtp1: TDateTimePicker;
    DSds1: TDataSource;
    con1: TZConnection;
    zqry1: TZQuery;
    frxdbdtst1: TfrxDBDataset;
    frxrprt1: TfrxReport;
    zqry2: TZQuery;
    zqry3: TZQuery;
    zqry4: TZQuery;
    zqry5: TZQuery;
    zqry6: TZQuery;
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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;
  id : string;

implementation

{$R *.dfm}

procedure TForm6.bersih;
begin
cbbc1.text:= '';
cbbc2.text:= '';
cbbc3.text:= '';
cbbc4.text:= '';
cbbc5.text:= '';
e1.Clear;
e2.Clear;
e3.Clear;
end;

procedure TForm6.enable;
begin
cbbc1.Enabled:= True;
cbbc2.Enabled:= True;
cbbc3.Enabled:= True;
cbbc4.Enabled:= True;
cbbc5.Enabled:= True;
dtp1.Enabled:=True;
e1.Enabled:= True;
e2.Enabled:= True;
e3.Enabled:= True;
end;

procedure TForm6.posisiawal;
begin
bersih;

cbbc1.Enabled:= false;
cbbc2.Enabled:= false;
cbbc3.Enabled:= false;
cbbc4.Enabled:= false;
cbbc5.Enabled:= false;
dtp1.Enabled:= False;
e1.Enabled:= false;
e2.Enabled:= false;
e3.Enabled:= false;

b1.Enabled:= True;
b2.Enabled:= False;
b3.Enabled:= False;
b4.Enabled:= False;
b5.Enabled:= False;
end;

procedure TForm6.b1Click(Sender: TObject);
begin
bersih;

b1.Enabled:= false;
b2.Enabled:= True;
b3.Enabled:= False;
b4.Enabled:= False;
b5.Enabled:= True;

enable;
end;

procedure TForm6.b2Click(Sender: TObject);
begin
if (cbbc1.Text= '')or (cbbc2.Text= '') or (cbbc3.Text= '')or (cbbc4.Text= '') or (cbbc5.Text= '') or (e1.Text= '')or (e2.Text ='') or (e3.Text ='') then
begin
ShowMessage('DATA TIDAK BOLEH KOSONG!');
end else
begin
//simpan
zqry1.SQL.Clear;
zqry1.SQL.Add('insert into table_semester values (null,"'+cbbc1.Text+'","'+cbbc2.Text+'","'+cbbc3.Text+'","'+cbbc4.Text+'","'+cbbc5.Text+'","'+FormatDateTime('yyyy-mm-dd',dtp1.Date)+'","'+e1.Text+'","'+e2.Text+'","'+e3.Text+'")');
zqry1.ExecSQL;

zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_semester');
zqry1.Open;
ShowMessage('DATA BERHASIL DISIMPAN!');
posisiawal;

end;
end;

procedure TForm6.b3Click(Sender: TObject);
begin
if (cbbc1.Text= '')or (cbbc2.Text= '') or (cbbc3.Text= '') or(cbbc4.Text= '') or(cbbc5.Text= '') or (e1.Text= '')or (e2.Text ='') or (e3.Text ='')then
begin
ShowMessage('INPUTAN WAJIB DIISI!');
end else
if (cbbc1.Text = zqry1.Fields[1].AsString) and (cbbc2.Text = zqry1.Fields[2].AsString)and (cbbc3.Text = zqry1.Fields[3].AsString)and (cbbc4.Text = zqry1.Fields[4].AsString)and (cbbc5.Text = zqry1.Fields[5].AsString) and (e1.Text = zqry1.Fields[6].AsString) and (e2.Text = zqry1.Fields[7].AsString) and (e3.Text = zqry1.Fields[8].AsString)and (e3.Text = zqry1.Fields[9].AsString) then
begin
ShowMessage('DATA TIDAK ADA PERUBAHAN');
posisiawal;
end else
begin
id:=dg1.DataSource.DataSet.FieldByName('id_semester').AsString;
ShowMessage('DATA BERHASIL DIUPDATE!'); //UPDATE
zqry1.SQL.Clear;
zqry1.SQL.Add('Update table_semester set id_siswa="'+cbbc1.Text+'",id_poin="'+cbbc2.Text+'",id_wali="'+cbbc3.Text+'",id_ortu="'+cbbc4.Text+'",id_kelas="'+cbbc5.Text+'",tanggal= "'+FormatDateTime('yyyy-mm-dd',dtp1.Date)+'",semester="'+e1.Text+'",status="'+e2.Text+'",tingkat_kelas="'+e3.Text+'" where id_semester="'+id+'"');
zqry1.ExecSQL;

zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_semester');
zqry1.Open;
posisiawal;
end;
end;

procedure TForm6.b4Click(Sender: TObject);
begin
if MessageDlg('APAKAH YAKIN MENGHAPUS DATA INI?',mtWarning,[mbYes,mbNo],0)= mryes then
begin
id:=dg1.DataSource.DataSet.FieldByName('id_semester').AsString;
zqry1.SQL.Clear;
zqry1.SQL.Add(' delete from table_semester where id_semester="'+id+'"');
zqry1. ExecSQL;
zqry1.SQL.Clear;
zqry1.SQL.Add('select * from table_semester');
zqry1.Open;
ShowMessage('DATA BERHASIL DIHAPUS');
posisiawal;
end else
begin
ShowMessage('DATA BATAL DIHAPUS');
posisiawal;
end;
end;

procedure TForm6.b5Click(Sender: TObject);
begin
posisiawal;
end;

procedure TForm6.FormShow(Sender: TObject);
begin
posisiawal;
end;

procedure TForm6.dg1CellClick(Column: TColumn);
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
cbbc3.Text:= zqry1.FieldList[3].AsString;
cbbc4.Text:= zqry1.FieldList[4].AsString;
cbbc5.Text:= zqry1.FieldList[5].AsString;
dtp1.Date:=Form6.zqry1.Fields[6].AsDateTime;
e1.Text:= zqry1.FieldList[7].AsString;
e2.Text:= zqry1.FieldList[8].AsString;
e3.Text:= zqry1.FieldList[9].AsString;
end;

procedure TForm6.b6Click(Sender: TObject);
begin
frxrprt1.ShowReport();
end;

procedure TForm6.FormCreate(Sender: TObject);
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
  cbbc2.items.add(zqry3.fieldbyname('id_poin').asstring);
  zqry3.Next;
end;
zqry4.First;
while not zqry4.Eof do
begin
  cbbc3.items.add(zqry4.fieldbyname('id_wali').asstring);
  zqry4.Next;
end;
zqry5.First;
while not zqry5.Eof do
begin
  cbbc4.items.add(zqry5.fieldbyname('id_ortu').asstring);
  zqry5.Next;
end;
zqry6.First;
while not zqry6.Eof do
begin
  cbbc5.items.add(zqry6.fieldbyname('id_kelas').asstring);
  zqry6.Next;
end;
end;

end.
