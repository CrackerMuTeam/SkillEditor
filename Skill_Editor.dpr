program Skill_Editor;

uses
  Forms,
  SkillUnit in 'SkillUnit.pas' {Form2},
  FlashForm in 'FlashForm.pas' {MUFlash},
  Dec in 'Dec.pas',
  Unit3 in 'Unit3.pas' {Form3},
  showdata in 'showdata.pas' {frmSD},
  ConfigForm in 'ConfigForm.pas' {CfgForm};

{$R *.res}

begin


  Application.Initialize;
  Application.Title := 'CMT-VMAT Skill Editor';
  Application.CreateForm(TMUFlash, MUFlash);
  Application.CreateForm(TCfgForm, CfgForm);

  muflash.iniciar;
    Application.CreateForm(TSkillForm, SkillForm);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TfrmSD, frmSD);

  Application.Run;





end.
