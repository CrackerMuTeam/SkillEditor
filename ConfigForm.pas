unit ConfigForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,dec,inifiles, ExtCtrls, DB, ADODB, registry;

type
  TCfgForm = class(TForm)
    ListBox1: TListBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ComboBox2: TComboBox;
    Edit4: TEdit;
    Edit5: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Button3: TButton;
    Button2: TButton;
    GroupBox3: TGroupBox;
    Label17: TLabel;
    Button4: TButton;
    Button5: TButton;
    ADOQuery1: TADOQuery;
    ComboBox1: TComboBox;
    Image1: TImage;
    Edit6: TEdit;
    Label14: TLabel;
    Label18: TLabel;
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ComboBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);

    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure iniciar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CfgForm: TCfgForm;
 bmps:tbitmap;
implementation

uses FlashForm,skillunit;

{$R *.dfm}

function To2Char(s:string):string ;
begin
  if length(s)=1 then s:='0'+s;
  result:=s;
end;

procedure TCfgForm.Button1Click(Sender: TObject);
var
  i:integer;
  reg:tregistry;
  bDriversValue: boolean;
begin
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey(  '\Software\ODBC\ODBC.INI\ODBC Data Sources', false );
    bDriversValue := Reg.ValueExists( edit1.Text );
    Reg.CloseKey;
    Reg.Free;
    if ( bDriversValue=false)  then begin
      application.MessageBox(pchar(Error28),pchar(ErrorCaption),mb_ok+mb_iconerror);
      exit;
    end;
  except
    application.MessageBox(pchar(Error28),pchar(ErrorCaption),mb_ok+mb_iconerror);
    Exit;
  end;
  adoquery1.ConnectionString:='Provider=MSDASQL.1;Password='+edit2.text+';Persist Security Info=True;User ID='+edit3.text+';Data Source='+edit1.text+'';{;Initial Catalog='+catalog;  }
  combobox1.Items.clear;
  adoquery1.Close;
  adoquery1.SQL.add('SELECT CATALOG_NAME as ''Database'''+
                    'FROM INFORMATION_SCHEMA.SCHEMATA');
  adoquery1.Open;
  for i := 0 to adoquery1.recordcount-1 do begin
    combobox1.Items.addobject(adoquery1.Fields[0].AsString,bmps);
    adoquery1.Next;
  end;
  adoquery1.close;
  combobox1.Enabled:=true;
  if (listbox1.Items[listbox1.ItemIndex]='MuOnline') and (catalog<>'') then
    for I := 0 to combobox1.Items.Count-1 do
      if Uppercase(combobox1.Items[i])=Uppercase(catalog) then combobox1.Itemindex:=i;
  if (listbox1.Items[listbox1.ItemIndex]='Me_MuOnline') and (mecatalog<>'') then
    for I := 0 to combobox1.Items.Count-1 do
      if Uppercase(combobox1.Items[i])=Uppercase(mecatalog) then combobox1.Itemindex:=i;
  cfgform.Update;
end;

procedure TCfgForm.Button2Click(Sender: TObject);
var
  Reg: tRegistry;
  bDriversValue, bSQLKey: boolean;
  i:integer;
  dsnini:tinifile;
begin
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey(  '\Software\ODBC\ODBC.INI\ODBC Data Sources', false );
    bDriversValue := Reg.ValueExists(edit1.text );
    Reg.CloseKey;
    Reg.Free;
    if ( bDriversValue=false) then begin
      application.MessageBox(pchar(Error28),pchar(ErrorCaption),mb_ok+mb_iconerror);
      exit;
    end;
    adoquery1.ConnectionString:='Provider=MSDASQL.1;Password='+edit3.text+';Persist Security Info=True;User ID='+edit2.text+';Data Source='+edit1.text+'';
    adoquery1.Close;
    adoquery1.SQL.add('SELECT CATALOG_NAME as ''Database'''+
                      'FROM INFORMATION_SCHEMA.SCHEMATA');
    adoquery1.Open;
    bsqlkey:=false;
    for i := 0 to adoquery1.recordcount-1 do begin
      if Uppercase(combobox1.Items[combobox1.itemindex])=Uppercase(adoquery1.Fields[0].AsString) then bsqlkey:=true;
      adoquery1.Next;
    end;
    adoquery1.close;
    if bsqlkey=false then begin
      application.MessageBox(pchar(Error25),pchar(ErrorCaption),mb_ok+mb_iconerror);
      exit;
    end;
  except
    application.MessageBox(pchar(Error26),pchar(ErrorCaption),mb_ok+mb_iconerror);
    Exit;
  end;
  if listbox1.Items[listbox1.ItemIndex]='MuOnline' then
    begin
      dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTedit.ini');
      dsnini.writeString('MuOnline','DSN',edit1.text);
      dsnini.writeString('MuOnline','User',edit2.text);
      dsnini.writeString('MuOnline','Password',edit3.text) ;
      dsnini.writeString('MuOnline','DB',combobox1.Text);
      dsnini.Free;
    end;
  if listbox1.Items[listbox1.ItemIndex]='Me_MuOnline' then
    begin
      dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTedit.ini');
      dsnini.writeString('MeMuOnline','DSN',edit1.text);
      dsnini.writeString('MeMuOnline','User',edit2.text);
      dsnini.writeString('MeMuOnline','Password',edit3.text) ;
      dsnini.writeString('MeMuOnline','DB',combobox1.Text);
      dsnini.Free;
    end;  
end;

procedure TCfgForm.Button3Click(Sender: TObject);
var
  vss:string;
  dsnini:tinifile;
begin
  if edit4.Text='' then edit4.text:='00'
    else edit4.text:=to2char(edit4.text);
  if edit5.text='' then  edit5.text:='0';
  if combobox2.ItemIndex=0 then vss:='CMT';
  if combobox2.ItemIndex=1 then vss:='MG';
  if combobox2.ItemIndex=2 then vss:='MX';
  if combobox2.ItemIndex=3 then vss:='Others';
  dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTedit.ini');
  dsnini.writeString('Others','Versao',vss);
  dsnini.writeString('Others','MaxGuilds',edit5.text) ;
  dsnini.writeString('Others','Ancient5',edit4.text);
  dsnini.writeString('Others','Ancient10',edit6.text);
  dsnini.Free;
end;

procedure TCfgForm.Button4Click(Sender: TObject);
begin
  if application.MessageBox(Pchar(Question12),Pchar(Question3Caption),mb_yesno+mb_iconquestion)=id_no then exit;
  application.Terminate;
end;

procedure TCfgForm.Button5Click(Sender: TObject);
begin
  if configtype='begin' then begin
    cfgform.Hide;
    muflash.iniciar;
  end
    else begin
      cfgform.Close;
    end;
end;

procedure TCfgForm.ComboBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  Offset: Integer;
begin
  with (Control as TComboBox).Canvas do begin
    FillRect(Rect); Bitmap:= TBitmap(ComboBox1.Items.Objects[index]);
    if Bitmap<>nil then begin
      BrushCopy(Bounds(Rect.Left + 1, Rect.Top + 1, Bitmap.Width,
        Bitmap.Height), Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height), clRed);
      Offset:= Bitmap.width + 5;
    end else Offset:=22;
    TextOut(Rect.Left + Offset, Rect.Top+2, ComboBox1.Items[index]);
  end;
end;



procedure TCfgForm.ComboBox1MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  Height:=18;
end;

procedure TCfgForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if configtype='begin' then begin
    if application.MessageBox(Pchar(Question12),Pchar(Question3Caption),mb_yesno+mb_iconquestion)=id_no then exit;
    application.Terminate;
  end
    else begin
      dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTedit.ini');
      mudsn:=dsnini.ReadString('MuOnline','DSN','');
      muid:=dsnini.ReadString('MuOnline','User','');
      mupwd:=dsnini.ReadString('MuOnline','Password','');
      catalog:=dsnini.ReadString('MuOnline','DB','');
      memudsn:=dsnini.ReadString('MeMuOnline','DSN','');
      memuid:=dsnini.ReadString('MeMuOnline','User','');
      memupwd:=dsnini.ReadString('MeMuOnline','Password','');
      mecatalog:=dsnini.ReadString('MeMuOnline','DB','');
      vs:=dsnini.ReadString('Others','Versao','');
      maxguilds:=strtoint(dsnini.Readstring('Others','MaxGuilds','')) ;
      ancientnum5:=dsnini.ReadString('Others','Ancient5','');
      ancientnum10:=dsnini.ReadString('Others','Ancient10','');
      dsnini.Free;
      skillform.resetsk;
      skillform.iniciar;
    end;
end;

procedure TCfgForm.iniciar;
var
  i,j: Integer;
begin
groupbox1.visible:=false;
    groupbox2.visible:=false;
    groupbox3.visible:=true;
  bmps:=tbitmap.create;
  bmps.Width:=16;
  bmps.Height:=16;
  for i := 0 to 15 do
    for j:= 0 to 15 do
      bmps.Canvas.Pixels[i,j]:=image1.Canvas.Pixels[i,j];
  {lang}
  cfgform.caption:=ConfigForm2;
  label17.caption:=ConfigMSG;
  //Config DNS
  label3.caption:=user;
  label4.caption:=password;
  button1.Caption:=ReadDatabases;
  label2.Caption:=database;
  button2.Caption:=config;
  //configOthers
  groupbox2.Caption:=ConfigOthers;
  label5.Caption:=version;
  label8.Caption:=version;
  label6.Caption:=ancient52;
  label14.Caption:=ancient102;
  label13.caption:=ancient3;
  label7.Caption:=maxguilds2;
  label15.Caption:=maxguilds2;
  label10.Caption:=versiontip1;
  label9.caption:=versiontip2;
  label11.Caption:=versiontip3;
  label12.Caption:=versiontip4;
  label18.caption:=ancienttip;
  label16.Caption:=maxguildstip;
  button3.Caption:=config;
  
  //buttons
  button5.Caption:=ok;
  button4.Caption:=cancel;
  {lang end}
  combobox2.Items.Delete(3);
  listbox1.Items.Delete(2);
  listbox1.Items.add(others);
  combobox2.Items.add(others);
end;


procedure TCfgForm.ListBox1Click(Sender: TObject);
var dsnini:tinifile;
inicreate: TStream;
begin
  if listbox1.Items[listbox1.ItemIndex]='MuOnline' then begin
    groupbox3.visible:=false;
    groupbox2.visible:=false;
    groupbox1.visible:=true;
    label1.Caption:=DNSMuonline;
    groupbox1.Caption:=ConfigMuOnline;
    dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTedit.ini');
    mudsn:=dsnini.ReadString('MuOnline','DSN','');
    muid:=dsnini.ReadString('MuOnline','User','');
    mupwd:=dsnini.ReadString('MuOnline','Password','');
    catalog:=dsnini.ReadString('MuOnline','DB','');
    dsnini.Free;
    edit1.Text:=mudsn;
    edit2.Text:=muid;
    edit3.Text:=mupwd;
    combobox1.Items.clear;
    combobox1.Items.addobject(catalog,bmps);
    combobox1.itemindex:=0;
    combobox1.Enabled:=false;
  end;
  if listbox1.Items[listbox1.ItemIndex]='Me_MuOnline' then begin
    groupbox3.visible:=false;
    groupbox2.visible:=false;
    groupbox1.visible:=true;
    label1.Caption:=DNSmeMuonline;
    groupbox1.Caption:=ConfigmeMuOnline;
    dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTedit.ini');
    memudsn:=dsnini.ReadString('MeMuOnline','DSN','');
    memuid:=dsnini.ReadString('MeMuOnline','User','');
    memupwd:=dsnini.ReadString('MeMuOnline','Password','');
    mecatalog:=dsnini.ReadString('MeMuOnline','DB','');
    dsnini.Free;
    edit1.Text:=memudsn;
    edit2.Text:=memuid;
    edit3.Text:=memupwd;
    combobox1.Items.clear;
    combobox1.Items.addobject(mecatalog,bmps);
    combobox1.itemindex:=0;
    combobox1.Enabled:=false;
  end;
  if listbox1.Items[listbox1.ItemIndex]=others then begin
    groupbox3.visible:=false;
    groupbox1.visible:=false;
    groupbox2.visible:=true;
    dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'CMTedit.ini');
    vs:=dsnini.ReadString('Others','Versao','');
    if dsnini.Readstring('Others','MaxGuilds','')<>'' then  maxguilds:=strtoint(dsnini.Readstring('Others','MaxGuilds',''))
      else maxguilds:=10000;
    if dsnini.Readstring('Others','Ancient5','')<>'' then ancientnum5:=dsnini.ReadString('Others','Ancient5','')
      else ancientnum5:='00';
    if dsnini.Readstring('Others','Ancient10','')<>'' then ancientnum10:=dsnini.ReadString('Others','Ancient10','')
      else ancientnum10:='00';
    dsnini.Free;
    combobox2.ItemIndex:=3;
    if vs='CMT' then combobox2.ItemIndex:=0;
    if vs='WZ' then combobox2.ItemIndex:=0;
    if vs='DT' then combobox2.ItemIndex:=0;
    if vs='MG' then combobox2.ItemIndex:=1;
    if vs='MX' then combobox2.ItemIndex:=2;
    edit4.text:=ancientnum5;
    edit6.text:=ancientnum10;
    edit5.text:=inttostr(maxguilds);
  end;
end;


end.
