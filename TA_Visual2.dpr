program TA_Visual2;

uses
  Forms,
  TableKelas in 'TableKelas.pas' {Form1},
  TablePoin in 'TablePoin.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
