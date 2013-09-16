unit FlashForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,mmsystem,inifiles,unit2, BmsXPProgressBar, jpeg,  ComCtrls, dec,
  DB, ADODB;

type
  TMUFlash = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    BmsXPProgressBar1: TBmsXPProgressBar;
    Timer1: TTimer;
    Image2: TImage;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MUFlash: TMUFlash;
   tempo:integer;
   x:byte;
   dsnini:tinifile;
   b:boolean;
implementation

{$R *.dfm}

procedure TMUFlash.Timer1Timer(Sender: TObject);

begin
tempo:=tempo+1;
bmsxpprogressbar1.Position:=bmsxpprogressbar1.Position+1;

 if (bmsxpprogressbar1.Position=100) and (b=false) then
   begin
   b:=true;
   form2.iniciar;
     form2.visible:=true;
     //frmmain.iniciar;
     MUFlash.visible:=false;
     bmsxpprogressbar1.Position:=0;
   end;
//if tempo=30 then MUFlash.CLOSE ;

if tempo=1+x then label2.caption:=loadingtext+'.';
if tempo=5+x then label2.caption:=loadingtext+'..';
if tempo=9+x then label2.caption:=loadingtext+'...';
if tempo=13+x then
  begin
    label2.caption:=loadingtext;
    x:=x+16;
  end;



end;
procedure TMUFlash.FormCreate(Sender: TObject);
begin
 b:=false;
tempo:=0;
x:=0;
if fileexists('lang.ini') then
  begin
    dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'lang.ini');
    Loadingtext:=dsnini.ReadString('into','Loading','');
    errortext:=dsnini.ReadString('into','Error','');

    accounttext:=dsnini.ReadString('main','account','');
    zentext:=dsnini.ReadString('main','zen','');
    typetext:=dsnini.ReadString('main','type','');
    itemtext:=dsnini.ReadString('main','item','');
    Leveltext:=dsnini.ReadString('main','level','');
    optiontext:=dsnini.ReadString('main','option','');
    durationtext:=dsnini.ReadString('main','duration','');
    serialtext:=dsnini.ReadString('main','serial','');
    skilltext:=dsnini.ReadString('main','skill','');
    lucktext:=dsnini.ReadString('main','luck','');
    ancienttext:=dsnini.ReadString('main','ancient','');
    info:=dsnini.ReadString('main','info','');
    selectacc:=dsnini.ReadString('main','selectacc','');
    selectitem:=dsnini.ReadString('main','selectitem','');
    characteritems:=dsnini.ReadString('main','characteritems','');
    AutoSerialtext:=dsnini.ReadString('main','AutoSerial','');
    ExcOpts:=dsnini.ReadString('main','ExcOpts','');
    WithoutSkill:=dsnini.ReadString('main','WithoutSkill','');
    Withoutluck:=dsnini.ReadString('main','Withoutluck','');
    withoutancient:=dsnini.ReadString('main','withoutancient','');
    withoutExcOpts:=dsnini.ReadString('main','withoutExcOpts','');
    Charactertext:=dsnini.ReadString('main','Character','');
    Skillstext:=dsnini.ReadString('main','Skills','');
    FreeSlot:=dsnini.ReadString('main','freeslot','');

    itemsizetext:=dsnini.ReadString('mainbtn','Itemsize','');
    vaultpostext:=dsnini.ReadString('mainbtn','VaultPos','');
    itemaddtext:=dsnini.ReadString('mainbtn','ItemAdd','');
    vaultedittext:=dsnini.ReadString('mainbtn','VaultEdit','');
    vaultcleartext:=dsnini.ReadString('mainbtn','VaultClear','');
    mdbedittext:=dsnini.ReadString('mainbtn','mdbedit','');
    closetext:=dsnini.ReadString('mainbtn','Close','');
    creditstext:=dsnini.ReadString('mainbtn','Credits','');
    seequerytext:=dsnini.ReadString('mainbtn','SeeQuery','');
    copyquerytext:=dsnini.ReadString('mainbtn','CopyQuery','');
    inventorypos:=dsnini.ReadString('Mainbtn','inventorypos','');
    inventoryedit:=dsnini.ReadString('Mainbtn','inventoryedit','');
    inventoryclear:=dsnini.ReadString('Mainbtn','inventoryclear','');
    SkillPos:=dsnini.ReadString('mainbtn','SkillPos','');
    SkillSerial:=dsnini.ReadString('mainbtn','SkillSerial','');
    AddSkill:=dsnini.ReadString('mainbtn','AddSkill','');
    RemSkill:=dsnini.ReadString('mainbtn','RemSkill','');
    SkillCode:=dsnini.ReadString('mainbtn','SkillCode','');
    mdbskilledit:=dsnini.ReadString('Mainbtn','mdbskilledit','');
    skilledit:=dsnini.ReadString('Mainbtn','skilledit','');
    skillclear:=dsnini.ReadString('Mainbtn','skillclear','');



    Question1:=dsnini.ReadString('MainMSG','Question1','');
    Question2:=dsnini.ReadString('MainMSG','Question2','');
    Question3:=dsnini.ReadString('MainMSG','Question3','');
    Question4:=dsnini.ReadString('MainMSG','Question4','');
    Question5:=dsnini.ReadString('MainMSG','Question5','');
    Question6:=dsnini.ReadString('MainMSG','Question6','');
    Question7:=dsnini.ReadString('MainMSG','Question7','');

    Question3Caption:=dsnini.ReadString('MainMSG','Question3Caption','');
    Confirm1:=dsnini.ReadString('MainMSG','Confirm1','');
    Confirm2:=dsnini.ReadString('MainMSG','Confirm2','');
    errorcaption:=dsnini.ReadString('MainMSG','errorcaption','');
    Error1part1:=dsnini.ReadString('MainMSG','Error1Part1','');
    Error1part2:=dsnini.ReadString('MainMSG','Error1Part2','');
    Error1part3:=dsnini.ReadString('MainMSG','Error1Part3','');
    Error1part4:=dsnini.ReadString('MainMSG','Error1Part4','');
    Error2:=dsnini.ReadString('MainMSG','Error2','');
    Error3part1:=dsnini.ReadString('MainMSG','Error3part1','');
    Error3part2:=dsnini.ReadString('MainMSG','Error3part2','');
    Error4part1:=dsnini.ReadString('MainMSG','Error4part1','');
    Error4part2:=dsnini.ReadString('MainMSG','Error4part2','');
    Error5:=dsnini.ReadString('MainMSG','Error5','');
    Error6:=dsnini.ReadString('MainMSG','Error6','');
    Error7:=dsnini.ReadString('MainMSG','Error7','');
    Error8:=dsnini.ReadString('MainMSG','Error8','');
    Error9:=dsnini.ReadString('MainMSG','Error9','');
    Error10:=dsnini.ReadString('MainMSG','Error10','');
    Error11Part1:=dsnini.ReadString('MainMSG','Error11Part1','');
    Error11Part2:=dsnini.ReadString('MainMSG','Error11Part2','');
    Error12:=dsnini.ReadString('MainMSG','Error12','');
    Error13:=dsnini.ReadString('MainMSG','Error13','');
    Error14:=dsnini.ReadString('MainMSG','Error14','');
    Error15Part1:=dsnini.ReadString('MainMSG','Error15Part1','');
    Error15Part2:=dsnini.ReadString('MainMSG','Error15Part2','');
    Error15Part3:=dsnini.ReadString('MainMSG','Error15Part3','');
    Error16:=dsnini.ReadString('MainMSG','Error16','');
    Error17:=dsnini.ReadString('MainMSG','Error17','');

    wemode1:=dsnini.ReadString('Excwe','wemode1','');
    wemode2:=dsnini.ReadString('Excwe','wemode2','');
    wemode3:=dsnini.ReadString('Excwe','wemode3','');
    wemode4:=dsnini.ReadString('Excwe','wemode4','');
    wemode5:=dsnini.ReadString('Excwe','wemode5','');
    wemode6:=dsnini.ReadString('Excwe','wemode6','');

    armode1:=dsnini.ReadString('Excar','armode1','');
    armode2:=dsnini.ReadString('Excar','armode2','');
    armode3:=dsnini.ReadString('Excar','armode3','');
    armode4:=dsnini.ReadString('Excar','armode4','');
    armode5:=dsnini.ReadString('Excar','armode5','');
    armode6:=dsnini.ReadString('Excar','armode6','');

    fenmode1:=dsnini.ReadString('Excfen','fenmode1','');
    fenmode2:=dsnini.ReadString('Excfen','fenmode2','');
    fenmode3:=dsnini.ReadString('Excfen','fenmode3','');
    fenmode4:=dsnini.ReadString('Excfen','fenmode4','');
    fenmode5:=dsnini.ReadString('Excfen','fenmode5','');
    fenmode6:=dsnini.ReadString('Excfen','fenmode6','');

    ormode1:=dsnini.ReadString('Excother','othermode1','');
    ormode2:=dsnini.ReadString('Excother','othermode2','');
    ormode3:=dsnini.ReadString('Excother','othermode3','');
    ormode4:=dsnini.ReadString('Excother','othermode4','');
    ormode5:=dsnini.ReadString('Excother','othermode5','');
    ormode6:=dsnini.ReadString('Excother','othermode6','');

    wimode1:=dsnini.ReadString('Excwi','wimode1','');
    wimode2:=dsnini.ReadString('Excwi','wimode2','');
    wimode3:=dsnini.ReadString('Excwi','wimode3','');
    wimode4:=dsnini.ReadString('Excwi','wimode4','');
    wimode5:=dsnini.ReadString('Excwi','wimode5','');

    anymode:=dsnini.ReadString('Excother','anymode','');

    Translate:=dsnini.ReadString('Credits','Translate','');
    OtherFiles:=dsnini.ReadString('Credits','OtherFiles','');

    WeaponLeft:=dsnini.ReadString('InvPos','WeaponLeft','');
    WeaponRight:=dsnini.ReadString('InvPos','WeaponRight','');
    Helm:=dsnini.ReadString('InvPos','Helm','');
    Armor:=dsnini.ReadString('InvPos','Armor','');
    Pants:=dsnini.ReadString('InvPos','Pants','');
    Gloves:=dsnini.ReadString('InvPos','Gloves','');
    Boots:=dsnini.ReadString('InvPos','Boots','');
    Wings:=dsnini.ReadString('InvPos','Wings','');
    Pet:=dsnini.ReadString('InvPos','Pet','');
    Pendant:=dsnini.ReadString('InvPos','Pendant','');
    RingLeft:=dsnini.ReadString('InvPos','RingLeft','');
    RingRight:=dsnini.ReadString('InvPos','RingRight','');

    Equips:=dsnini.ReadString('InvSepar','Equips','');
    NoEquips:=dsnini.ReadString('InvSepar','NoEquips','');
    PS:=dsnini.ReadString('InvSepar','PS','');

    dsnini.Free;
    label2.caption:=loadingtext;
  end
    else
      begin
        muflash.visible:=false;
        tempo:=1000;
        application.MessageBox(pchar('(lang.ini)'),'Error!',mb_ok+mb_iconerror);
        muflash.close;
        application.Terminate;
      end;
if fileexists('dsn.ini') then
      begin
        dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'DSN.ini');
        mudsn:=dsnini.ReadString('MuOnline','DSN','');
        muid:=dsnini.ReadString('MuOnline','User','');
        mupwd:=dsnini.ReadString('MuOnline','Password','');
        catalog:=dsnini.ReadString('MuOnline','InitCatalog','');
        memudsn:=dsnini.ReadString('MeMuOnline','DSN','');
        memuid:=dsnini.ReadString('MeMuOnline','User','');
        memupwd:=dsnini.ReadString('MeMuOnline','Password','');
        mecatalog:=dsnini.ReadString('MeMuOnline','InitCatalog','');
        dsnini.Free;
      end
        else
          begin
            tempo:=1000;
            application.MessageBox(pchar('Arquivo não encontrado'+#13+'           (dsn.ini)'),'Erro!',mb_ok+mb_iconerror);
            muflash.Close;
          end;

end;

end.
