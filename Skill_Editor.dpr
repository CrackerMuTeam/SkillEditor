program Skill_Editor;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form2},
  FlashForm in 'FlashForm.pas' {MUFlash},
  Dec in 'Dec.pas',
  Unit3 in 'Unit3.pas' {Form3},
  showdata in 'showdata.pas' {frmSD};

{$R *.res}

begin


  Application.Initialize;
  Application.Title := 'CMT-VMAT Skill Editor';
  Application.CreateForm(TMUFlash, MUFlash);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TfrmSD, frmSD);
  Application.Run;





end.
