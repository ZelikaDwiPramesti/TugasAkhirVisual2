program TA_Visual2;

uses
  Forms,
  TableKelas in 'TableKelas.pas' {Form1},
  TablePoin in 'TablePoin.pas' {Form2},
  TableHubungan in 'TableHubungan.pas' {Form3},
  TableOrtu in 'TableOrtu.pas' {Form4},
  TableSiswa in 'TableSiswa.pas' {Form5},
  TableSemester in 'TableSemester.pas' {Form6},
  TableUser in 'TableUser.pas' {Form7},
  TableWaliKelas in 'TableWaliKelas.pas' {Form8},
  MainMenu in 'MainMenu.pas' {Form9};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
