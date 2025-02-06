program Project1;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  Unit1 in 'Unit1.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
