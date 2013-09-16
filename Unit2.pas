unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls,strUtils, ValEdit, ExtCtrls, Buttons,dec,
  ComCtrls,unit3,inifiles,mmsystem, ToolWin, showdata, Menus;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    muQuery: TADOQuery;
    SkillUpdate: TADOCommand;
    SpeedButton1: TSpeedButton;
    GroupBox2: TGroupBox;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    ComboBox4: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox4: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    StatusBar1: TStatusBar;
    BitBtn7: TBitBtn;
    accQuery: TADOQuery;
    skillquery: TADOQuery;
    ComboBox3: TComboBox;
    ComboBox5: TComboBox;
    Label7: TLabel;
    GroupBox5: TGroupBox;
    BitBtn8: TBitBtn;
    BitBtn5: TBitBtn;
    CheckBox2: TCheckBox;
    RichEdit1: TRichEdit;
    procedure iniciar;

    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure ComboBox3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
   
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure accountmostrar;
    procedure charactermostrar;
    procedure skilladd;
    procedure skillrem;
    procedure editlock;
    procedure editunlock;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure cellClick(sender:tobject);
    procedure cellMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  end;

var
  Form2: TForm2;
  wscells:array[0..99] of tspeedbutton; //quadrados de Skill
  rodarskill:boolean;
  lugar:byte;
  numskill:integer;
  MagicList:array[0..99] of string; //hexa de cada skill
    dsnini:tinifile;
implementation


{$R *.dfm}

procedure initsk();
var i,lcell,hcell:integer;
    name1:string;
begin
  lcell:=50;
  hcell:=60;

  for i:=0 to numskill do
      begin
            name1:=inttostr(i+1);
            if length(name1)=1 then name1:='0'+name1;
            wscells[i]:=tspeedbutton.Create(form2);
            wscells[i].parent:=form2.Panel2 ;
            wscells[i].left:=i*lcell+1;
            wscells[i].top:=0;
            wscells[i].height:=hcell;
            wscells[i].width:=lcell;
            wscells[i].Name:='';
            wscells[i].ShowHint:=true;
            wscells[i].Hint:=name1+'  ';
            wscells[i].OnClick:=form2.cellClick;
            wscells[i].onmousemove:=form2.cellMove;
            //wscells[i,t].OnDblClick:=frmmain.cellDblClick;
          //  wscells[i,t].PopupMenu:=frmmain.popupmenu1;
      end;
end;

procedure freesk();
var i:integer;
begin
  for i:=0 to numskill do
      wscells[i].Free ;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  freesk;
  application.Terminate;
end;

procedure TForm2.accountmostrar;
var
i:integer;
begin
  ComboBox1.Items.clear;
  accquery.SQL.Clear;
  accquery.SQL.Add('select '+memb___id+' from '+MEMB_INFO+'');
  accquery.Open;
  for i:=0 to accquery.RecordCount-1 do begin
      ComboBox1.Items.Add(accquery.Fields[0].asstring);
      accquery.Next;
    end;
  accquery.Close;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var i:integer;
begin
  if (rodarskill=true) and (wscells[0].left<0) then
    for i:=0 to numskill do
      begin
        wscells[i].left:=wscells[i].left+10;
      end;
  if (rodarskill=false) and (wscells[numskill].left>451) then
    for i:=0 to numskill do
      begin
        wscells[i].left:=wscells[i].left-10;

      end;
end;

procedure TForm2.Button2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  rodarskill:=true;
  timer1.enabled:=true;
end;

procedure TForm2.Button2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  timer1.Enabled:=false;
end;

procedure TForm2.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  rodarskill:=false;
  timer1.enabled:=true;
end;

procedure TForm2.Button1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  timer1.enabled:=false;
end;

procedure Tform2.charactermostrar;
var i,j:byte;
begin
  Combobox2.Items.Clear;
  AccountSave:=Combobox1.Text;
  muquery.SQL.Clear;
  muquery.SQL.Add('select '+GameID1+','+GameID2+','+GameID3+','+GameID4+','+GameID5+' from '+AccountCharacter+' where '+Id+'='''+AccountSave+'''');
  muquery.Open;
  for i:=0 to 4 do
    begin
     if muquery.Fields[i].asstring<>'' then Combobox2.Items.Add(muquery.Fields[i].asstring);
    end;
  muquery.Close;
 
end;


procedure TForm2.ComboBox2Change(Sender: TObject);
begin
charactersave:=combobox2.Text;
end;

function Getlblindex(const S:string):integer;
var i,lblindex:integer;
begin
  lblindex:=121;
  if s='all' then begin
    for i:=0 to form2.Panel2.ControlCount-1 do begin
      if lowercase(form2.Panel2.Controls[i].ClassName)='tpanel' then begin
         lblindex:=i;
         break;
      end;
    end;
    end
  else begin
    for i:=0 to form2.Panel2.ControlCount-1 do begin
      if uppercase(form2.Panel2.Controls[i].Name)=s then begin
         lblindex:=i;
         break;
      end;
    end;
  end;
  result:=lblindex;
end;

procedure ResetSK();
var i,t:integer;
begin
  for i:=0 to numskill do
    begin
          wscells[i].Flat:=false;
          wscells[i].Name:='';
          wscells[i].caption:=freeslot;
          wscells[i].enabled:=true;
          MagicList[i]:='FF0000';


      end;
  while getlblindex('all')<>121 do
        form2.Panel2.Controls[getlblindex('all')].Free;

end;

function bytetohex(src: byte): string;
begin
  setlength(result, 2);
  asm
  mov edi, [result]
  mov edi, [edi]
  mov al, src
  mov ah, al // ±£¥Ê÷¡ ah
  shr al, 4 //  ‰≥ˆ∏ﬂ4Œª
  add al, '0'
  cmp al, '9'
  jbe @@outcharlo
  add al, 'a'-'9'-1
@@outcharlo:
  and ah, $f
  add ah, '0'
  cmp ah, '9'
  jbe @@outchar
  add ah, 'a'-'9'-1
@@outchar:
  stosw
  end;
end;

function skillnome(ID:string):string;
begin
  with form2.skillQuery do begin
       sql.Clear;
       sql.Add('select name from skill where id='''+id[1]+id[2]+id[3]+id[4]+'''');
       open;
       if eof and bof then
          skillnome:='miss'
       else begin
         skillnome :=fields[0].AsString;
       end;
       close;
  end;
end;

procedure FillHexSK(item:TField); //Ler Hexa dos Skills
type Tcharset=set of char;
var A:tcharset;
    skillblock:array of byte;
    sSK,sSkill,sUni,skillnomes:string;
    skline,i,j,panelcount:integer;
    b:boolean;

begin
  b:=true;
  with item do
    begin
      setlength(skillblock,datasize);
      try
        getdata(skillblock);
        while i<=high(skillblock) do
          begin
            sSK:=sSK+uppercase(bytetohex(skillblock[i]));
            inc(i);
          end;
        panelcount:=0;
        for skline:=0 to numskill do
          begin
            sSkill:=midstr(sSK,6*(skline)+1,6);
            if (sSkill<>'FF0000') then inc(panelcount);

          end;
        if panelcount=0 then exit;
        for skline:=0 to numskill do
          begin
            sSkill:=midstr(sSK,6*(skline)+1,6);
            MagicList[skline]:=sSkill;
            if (sSkill='FF0000') then sSkill:='';
            if sSkill<>'' then
              begin
                skillnomes:=skillnome(sSkill);
                if skillnomes='miss' then
                  begin
                    //showmessage('N„o foi possivel carregar a skill');
                    skillnomes:=errorcaption;
                    //continue;
                  end;
                WsCells[skline].caption:=skillnomes;

              end;
          end;
         form2.combobox4.items.clear;
         for i:=0 to numskill do
           begin
             if (wscells[i].caption='') or (wscells[i].caption=freeslot) then
               begin
                 j:=i+1;
                 if b=true then
                   begin
                     form2.combobox4.Items.add(inttostr(j));
                     b:=false;
                   end;
                 wscells[i].caption:=freeslot;
                 if j<numskill+1 then
                   begin
                     wscells[j].enabled:=false;
                   end;
               end
                 else
                   begin
                     with form2 do
                       begin

                         form2.combobox4.Items.add(inttostr(i+1));
                       end;
                   end;
           end;
         form2.ComboBox4.ItemIndex:=0;
      except
      on E:exception do application.MessageBox(pchar(e.Message),Pchar(errorcaption),mb_ok+mb_iconerror);

    end;
  end;
end;


procedure TForm2.ComboBox2Click(Sender: TObject);
var magicloads,magicload:string;
i:byte;
j:integer;
b:boolean;
begin
 b:=true;
 screen.Cursor:=-11;
 application.ProcessMessages;
 try
    muquery.SQL.Clear;
    muquery.SQL.Add('select '+MagicLists+' from '+Character+' where '+nome+'='''+combobox2.text+'''');
    muquery.Open ;
    if (muquery.Eof) and (muquery.Bof) then begin
       application.MessageBox(pchar(error17),pchar(errorcaption),mb_ok+mb_iconerror);
       screen.Cursor:=0;
       muquery.Close;
       exit;
    end;
    resetSK;
    fillhexsk(muquery.Fields[0]);

    muquery.Close;
  form2.combobox4.items.clear;
         for i:=0 to numskill do
           begin
             if (wscells[i].caption='') or (wscells[i].caption=freeslot) then
               begin
                 j:=i+1;
                 if b=true then
                   begin
                     form2.combobox4.Items.add(inttostr(j));
                     b:=false;
                   end;
                 wscells[i].caption:=freeslot;
                 if j<numskill+1 then
                   begin
                     wscells[j].enabled:=false;
                   end;
               end
                 else
                   begin
                     with form2 do
                       begin

                         form2.combobox4.Items.add(inttostr(i+1));
                       end;
                   end;
           end;
         form2.ComboBox4.ItemIndex:=0;
 finally
 screen.Cursor:=0;
 editunlock;
 end;
end;



procedure tform2.cellClick(sender:tobject);
var sHint:string;
i: byte  ;
begin

  if combobox3.Enabled then
    begin
      shint:=(sender as tspeedbutton).Hint ;
      combobox4.ItemIndex:=strtoint(leftstr(shint,2))-1;
      if (combobox4.ItemIndex=lugar) then
        begin
          skilladd;
        end;
      lugar:=combobox4.itemindex;

      if wscells[combobox4.ItemIndex].caption=errorcaption then
        begin
          bitbtn1.Enabled:=false;
          bitbtn2.Enabled:=false;
        end
          else
             begin
               bitbtn1.Enabled:=true;
               if wscells[combobox4.ItemIndex].caption=freeslot then bitbtn2.Enabled:=false
                 else bitbtn2.enabled:=true;
             end;

    end;

end;

procedure tform2.skilladd;
var
i,j:byte;
b:boolean;
skillid:string;
begin
  if wscells[combobox4.ItemIndex].caption<>errorcaption then
    begin
      b:=true;
      if trim(combobox3.Text)='' then
        begin
          application.MessageBox(pchar(error16),Pchar(errorcaption),mb_ok+mb_iconwarning);
          exit;
        end;
      for i:=0 to numskill do
        begin
          if wscells[i].caption=combobox3.Text then
            begin
              application.MessageBox(Pchar(Error15Part1+#13+Error15Part2+#13+Error15Part3),pchar(errorcaption),mb_ok+mb_iconwarning);
              exit;
            end;
        end;
      if wscells[combobox4.itemindex].caption<>freeslot then
        begin
          if application.MessageBox(Pchar(question7),'CMT-VMAT SK Editor',mb_yesno+mb_iconwarning)=idno then exit;
        end
          else if combobox4.itemindex+1<numskill then wscells[combobox4.itemindex+1].Enabled:=true;
      wscells[combobox4.itemindex].caption:=combobox3.Text;
      with skillQuery do
        begin
          sql.Clear;
          sql.Add('select id from skill where name='''+combobox3.text+'''');
          open;
          skillid :=fields[0].AsString+'00';
          close;
        end;
      MagicList[combobox4.itemindex]:=skillid;
      lugar:=21;
      combobox4.Items.clear;
      for i:=0 to numskill do
        begin
          if wscells[i].caption=FreeSlot then
            begin
              j:=i+1;
              if b=true then
                begin
                  combobox4.Items.add(inttostr(j));
                  b:=false;
                end;
              wscells[i].caption:=FreeSlot;
              if j<numskill then
                begin
                  wscells[j].enabled:=false;
                end;
            end
              else
                begin
                  combobox4.Items.add(inttostr(i+1));
                end;
        end;
      combobox4.ItemIndex:=0;
     end;
end;

procedure tform2.skillrem;
var
i,j:byte;
begin
  if wscells[combobox4.ItemIndex].caption<>errorcaption then
    begin
      if application.MessageBox(Pchar(question6),'CMT-VMAT SK Editor',mb_yesno+mb_iconwarning)=idno then exit;
      for i:=combobox4.ItemIndex+1 to numskill do
        begin
          wscells[i-1].Caption:=wscells[i].caption;
          MagicList[i-1]:=magiclist[i];
        end;
      wscells[numskill].caption:=freeslot;
      magiclist[numskill]:='FF0000';
      lugar:=21;
      combobox4.Items.Delete(combobox4.Itemindex+1);
      combobox4.ItemIndex:=0;
      for i:=0 to numskill do
        begin
          if wscells[i].caption=freeslot then
            begin
              j:=i+1;
              if j<numskill+1 then
                begin
                  wscells[j].enabled:=false;
                end;
            end;
        end;
    end;

end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
skillrem;
end;


function skillCommit():boolean;
var sSql,sSqlSub:string;
    i,t:integer;
begin
  screen.Cursor:=-11;
  application.ProcessMessages;
  ssql:='update '+character+' set '+MagicLists+'=0x';
  for i:=0 to numskill do
    begin
      ssqlsub:=ssqlsub+magiclist[i];;
    end;
  ssql:=ssql+ssqlsub+' where '+nome+'='''+form2.combobox2.text+'''' ;
  if form2.checkbox1.Checked then begin
    if application.MessageBox(pchar(ssql),'Query',mb_yesno+mb_iconinformation)=mrno then begin
       screen.Cursor:=0;
       result:=false;
       exit;
    end;
  end;
  if form2.CheckBox2.Checked then begin
     form2.richedit1.Lines.Clear;
     form2.richedit1.Lines.Add(ssql);
     form2.richedit1.SelectAll;
     form2.richedit1.CopyToClipboard;
  end;
  screen.Cursor:=0;
  with form2.skillupdate do begin
  commandtext:=ssql;
  try
  execute;
  result:=true;
  except
  on e:exception do begin
  application.MessageBox(pchar(e.Message),Pchar(errorcaption),mb_ok+mb_iconerror);
  result:=false;
  end;
  end;
  end;
end;




procedure TForm2.BitBtn3Click(Sender: TObject);
var i:byte;
sqladd:string;
sqladdint:integer;
begin
 if application.MessageBox(Pchar(question4),'CMT-VMAT SK Editor',mb_yesno+mb_iconquestion)=id_no then exit;
if skillcommit then application.MessageBox(Pchar(Confirm2),'CMT-VMAT SK Editor',mb_ok+mb_iconinformation) else
 application.MessageBox(Pchar(Error12),Pchar(errorCaption),mb_ok+mb_iconwarning);

 { if application.MessageBox('VocÍ deseja salvar as alteraÁıes no MagicList?','CMT-VMAT SK Editor',mb_yesno+mb_iconquestion)=id_no then exit;
  sqladd:='0x';
  for i:=0 to numskill do
    sqladd:=sqladd+magiclist[i];
  sqladdint:=strtoint(sqladd);
  skillupdate.CommandText:=('Update Character set Magiclist='''+inttostr(sqladdint)+''' where name='''+combobox2.text+'''');
  skillupdate.Execute;

  }

end;


procedure TForm2.BitBtn4Click(Sender: TObject);
var i,x:byte;
magiclists: array[0..99] of string;
begin
  x:=0;
  for i:=0 to numskill do
    begin
      wscells[i].enabled:=false;
      if wscells[i].Caption<>errorcaption then
        begin
          magiclist[i]:='FF0000';
          wscells[i].Caption:=FreeSlot;
        end
          else
            begin
              x:=x+1;
              magiclists[x]:=magiclist[i];
            end;
    end;
  if x<>0 then
    for i:=0 to x-1 do
      begin
        wscells[i].Enabled:=true;
        magiclist[i]:=magiclists[i+1];
        wscells[i].caption:=errorcaption;
      end;
  for i:=x to numskill do wscells[i].caption:=FreeSlot;

  wscells[x].Enabled:=true;
  combobox4.Items.clear;
  for i:=1 to x+1 do
    combobox4.items.add(inttostr(i));
  combobox4.itemindex:=0;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
skilladd;
end;

procedure TForm2.BitBtn6Click(Sender: TObject);
begin
  freesk;
  application.Terminate;
end;

procedure tform2.cellmove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
var sHint:string;
i: byte  ;
begin
  shint:=(sender as tspeedbutton).Hint ;
  edit1.text:=Magiclist[strtoint(leftstr(shint,2))-1];
end;



procedure TForm2.ComboBox3Click(Sender: TObject);
begin
 with skillQuery do
   begin
     sql.Clear;
     sql.Add('select ID from skill where Name='''+combobox3.text+'''');
     open;
     label6.caption :=SkillSerial+' '+fields[0].AsString+'00';
     close;
   end;
end;

procedure tform2.editlock;
begin
  with form2 do
    begin
      //groupbox3.enabled:=false;
    //  combobox3.Enabled:=false;
      combobox4.Enabled:=false;
      bitbtn1.Enabled:=false;
      bitbtn2.Enabled:=false;
      //groupbox1
      groupbox1.enabled:=false;
      button1.Enabled:=false;
      button2.enabled:=false;
      //Groupbox4
      checkbox1.Enabled:=false;
      checkbox2.Enabled:=false;
      bitbtn3.enabled:=false;
      bitbtn4.Enabled:=false;
    end;
end;

procedure tform2.editunlock;
begin
  with form2 do
    begin
      //groupbox3.enabled:=true;
     // combobox3.Enabled:=true;
      combobox4.Enabled:=true;
      bitbtn1.Enabled:=true;
      bitbtn2.Enabled:=true;
      //groupbox1
      groupbox1.enabled:=true;
      button1.Enabled:=true;
      button2.enabled:=true;
      //groupbox4
      checkbox1.Enabled:=true;
      checkbox2.Enabled:=true;
      bitbtn3.enabled:=true;
      bitbtn4.Enabled:=true;
    end;
end;

procedure TForm2.BitBtn5Click(Sender: TObject);
begin


 frmsd.ShowModal;

end;

procedure TForm2.BitBtn8Click(Sender: TObject);
begin
 frmsd.ShowModal;
end;

procedure TForm2.BitBtn7Click(Sender: TObject);
begin
form3.Caption:=creditstext;
  form3.Label2.Caption:=OtherFiles;
  form3.Label4.Caption:=translate;
  form3.showmodal;
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
charactermostrar;
end;

procedure TForm2.ComboBox5Change(Sender: TObject);
var s:array[0..255] of string;
i:byte;
g:byte;
begin
form2.combobox3.items.clear;
  skillquery.SQL.clear;
  skillquery.SQL.Add('select distinct NumClass from skillclass where class='''+combobox5.text+'''');
  skillquery.Open;
  for i:= 0 to skillquery.RecordCount-1 do
    begin
      s[i]:=(skillquery.Fields[0].asstring);
      skillquery.Next;
      g:=i;
    end;
  skillquery.Close;
  for i:=0 to g do
    begin
      skillquery.SQL.clear;
      skillquery.SQL.Add('select name from skill where class='''+s[g]+'''');
      skillquery.Open;
      while not skillquery.Eof do
        begin
          combobox3.items.add(skillquery.Fields[0].asstring);
          skillquery.Next
        end;
      skillquery.Close;
    end;
  form2.combobox3.ItemIndex:=1;

  with skillQuery do
    begin
      sql.Clear;
      sql.Add('select ID from Skill where Name='''+form2.combobox3.text+'''');
      open;
      form2.label6.caption :='Serial: '+fields[0].AsString+'00';
      close;
    end;
end;

procedure Tform2.iniciar;
var
  i:byte;
  filename : string;
  f : textfile;
  ch : char;
  esc: boolean;
  numero:integer;
  s:array[1..12] of string;
  g:string;
begin
  tabela:='skill';
  muquery.ConnectionString:='Provider=MSDASQL.1;Password='+mupwd+';Persist Security Info=True;User ID='+muid+';Data Source='+mudsn+';Initial Catalog='+catalog;
  skillquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ExtractFilePath(Application.ExeName)+'skill.mdb'+';Mode=ReadWrite;Persist Security Info=False';
  skillupdate.connectionstring:=muquery.connectionstring;
  accquery.connectionstring:='Provider=MSDASQL.1;Password='+memupwd+';Persist Security Info=True;User ID='+memuid+';Data Source='+memudsn+';Initial Catalog='+mecatalog;

  filename:=ExtractFilePath(Application.ExeName)+'SQLNames.txt';
  assignfile(F,filename);
  reset(F);
  i:=0;
  while not eof(F) do
    begin
      read(F,ch);
      Case ch of
        '"'  :  begin
                  if esc=false then esc:=true
                    else
                      begin
                        esc:=false;
                        inc(i);
                        s[i]:=g;
                        g:='';
                      end;
                end;
         else begin
                if esc=true then
                  begin
                    g:=g+ch;
                  end;
               end;
      end;
    end;
  closefile(F);
  //Memb___id
  memb_info:=s[1];
  memb___id:=s[2];
  //Accountcharacter
  GameID1:=s[3];
  GameID2:=s[4];
  GameID3:=s[5];
  GameID4:=s[6];
  GameID5:=s[7];
  ID:=s[8];
  AccountCharacter:=s[9];
  //Character
  Character:=s[10];
  MagicLists:=s[11];
  nome:=s[12];
  muquery.sql.clear;
  muquery.SQL.Add('select '+magiclists+' from '+character+'');
  muquery.open;
  numero:=(muquery.Fields[0].Size);
  muquery.Close;
  numskill:=numero*2 div 6-1;
 // label1.caption:=inttostr(numskill);
 // label1.caption:=inttostr(numskill);
  editlock;
  initsk;
  accountmostrar;
  skillquery.SQL.clear;
  skillquery.Close;
  skillquery.SQL.Add('select name from Skill where Class<>''XXXX''');
  skillquery.Open;
  form2.combobox3.items.clear;
  while not skillquery.eof do
    begin
      form2.combobox3.Items.Add(skillquery.Fields[0].asstring);
      skillquery.Next;
    end;

 { skillquery.SQL.Add('select distinct class from SkillClass where class<>''XX''');
  skillquery.Open;
  form2.combobox5.items.clear;
  while not skillquery.eof do
    begin
      form2.combobox5.Items.Add(skillquery.Fields[0].asstring);
      skillquery.Next;
    end;           }
  skillquery.Close;
  //lang
  groupbox2.caption:=selectacc;
  label1.Caption:=accounttext;
  label2.Caption:=charactertext;
  label3.caption:=skilltext;
  label4.Caption:=SkillPos;
  label6.Caption:=SkillSerial;
  groupbox1.Caption:=skillstext;
  bitbtn1.Caption:=addskill;
  bitbtn2.caption:=remskill;
  label5.caption:=skillcode;
  groupbox5.Caption:=mdbskilledit;
  bitbtn5.caption:=skillstext;
  checkbox1.Caption:=seequerytext;
  checkbox2.Caption:=copyquerytext;
  bitbtn3.caption:=skilledit;
  bitbtn4.caption:=skillclear;
  bitbtn6.caption:=closetext;
  bitbtn7.caption:=creditstext;
  //lang end
  form2.update;
end;



end.
