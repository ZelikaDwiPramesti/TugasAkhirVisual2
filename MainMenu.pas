unit MainMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, jpeg, ExtCtrls;

type
  TForm9 = class(TForm)
    Menu1: TMainMenu;
    Foms1: TMenuItem;
    ABLESISWA1: TMenuItem;
    ABLEORTU1: TMenuItem;
    ABLEWALIKELAS1: TMenuItem;
    ABLEHUBUNGAN1: TMenuItem;
    ABLEKELAS1: TMenuItem;
    ABLESEMESTER1: TMenuItem;
    ABLEPOIN1: TMenuItem;
    ABLEUSER1: TMenuItem;
    img1: TImage;
    procedure ABLESISWA1Click(Sender: TObject);
    procedure ABLEORTU1Click(Sender: TObject);
    procedure ABLEWALIKELAS1Click(Sender: TObject);
    procedure ABLEHUBUNGAN1Click(Sender: TObject);
    procedure ABLEKELAS1Click(Sender: TObject);
    procedure ABLESEMESTER1Click(Sender: TObject);
    procedure ABLEPOIN1Click(Sender: TObject);
    procedure ABLEUSER1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses TableSiswa, TableOrtu, TableWaliKelas, TableHubungan, TableKelas,
  TableSemester, TablePoin, TableUser;

{$R *.dfm}

procedure TForm9.ABLESISWA1Click(Sender: TObject);
begin
form5.showmodal;
end;

procedure TForm9.ABLEORTU1Click(Sender: TObject);
begin
form4.showmodal;
end;

procedure TForm9.ABLEWALIKELAS1Click(Sender: TObject);
begin
form8.showmodal;
end;

procedure TForm9.ABLEHUBUNGAN1Click(Sender: TObject);
begin
form3.showmodal;
end;

procedure TForm9.ABLEKELAS1Click(Sender: TObject);
begin
form1.showmodal;
end;

procedure TForm9.ABLESEMESTER1Click(Sender: TObject);
begin
form6.showmodal;
end;

procedure TForm9.ABLEPOIN1Click(Sender: TObject);
begin
form2.showmodal;
end;

procedure TForm9.ABLEUSER1Click(Sender: TObject);
begin
form7.showmodal;
end;

end.
