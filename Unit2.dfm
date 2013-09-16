object Form2: TForm2
  Left = 146
  Top = 192
  BorderStyle = bsToolWindow
  Caption = 'CMT-VMAT SK Editor 1.0c'
  ClientHeight = 247
  ClientWidth = 728
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 472
    Top = 64
    Width = 23
    Height = 22
  end
  object Label5: TLabel
    Left = 568
    Top = 200
    Width = 72
    Height = 13
    Caption = 'Codigo do Skill:'
  end
  object GroupBox1: TGroupBox
    Left = 9
    Top = 112
    Width = 553
    Height = 105
    Caption = 'Skills'
    TabOrder = 0
    object Panel2: TPanel
      Left = 23
      Top = 24
      Width = 506
      Height = 65
      BorderStyle = bsSingle
      TabOrder = 0
    end
    object Button1: TButton
      Left = 528
      Top = 24
      Width = 17
      Height = 63
      Caption = '+'
      TabOrder = 1
      OnMouseDown = Button1MouseDown
      OnMouseUp = Button1MouseUp
    end
    object Button2: TButton
      Left = 7
      Top = 24
      Width = 17
      Height = 64
      Caption = '-'
      TabOrder = 2
      OnMouseDown = Button2MouseDown
      OnMouseUp = Button2MouseUp
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 209
    Height = 97
    Caption = 'Selecionar Account'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 43
      Height = 13
      Caption = 'Account:'
    end
    object Label2: TLabel
      Left = 8
      Top = 66
      Width = 52
      Height = 13
      Caption = 'Character:'
    end
    object ComboBox2: TComboBox
      Left = 66
      Top = 57
      Width = 137
      Height = 21
      Style = csDropDownList
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
      OnChange = ComboBox2Change
      OnClick = ComboBox2Click
    end
    object ComboBox1: TComboBox
      Left = 66
      Top = 30
      Width = 137
      Height = 21
      AutoComplete = False
      Style = csDropDownList
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
      OnChange = ComboBox1Change
    end
  end
  object GroupBox3: TGroupBox
    Left = 224
    Top = 8
    Width = 337
    Height = 97
    TabOrder = 2
    object Label3: TLabel
      Left = 4
      Top = 10
      Width = 21
      Height = 13
      Caption = 'Skill:'
    end
    object Label4: TLabel
      Left = 4
      Top = 66
      Width = 21
      Height = 13
      Caption = 'Pos:'
    end
    object Label6: TLabel
      Left = 96
      Top = 66
      Width = 30
      Height = 13
      Caption = 'Serial:'
    end
    object Label7: TLabel
      Left = 48
      Top = 10
      Width = 24
      Height = 13
      Caption = 'Tipo:'
      Visible = False
    end
    object ComboBox4: TComboBox
      Left = 32
      Top = 64
      Width = 49
      Height = 21
      Style = csDropDownList
      DropDownCount = 20
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = '1'
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19'
        '20')
    end
    object BitBtn1: TBitBtn
      Left = 192
      Top = 22
      Width = 137
      Height = 25
      Caption = 'Add Skill'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 192
      Top = 54
      Width = 137
      Height = 25
      Caption = 'Remover Skill'
      TabOrder = 2
      OnClick = BitBtn2Click
    end
    object ComboBox3: TComboBox
      Left = 8
      Top = 28
      Width = 153
      Height = 21
      AutoComplete = False
      Style = csDropDownList
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 3
      OnClick = ComboBox3Click
    end
    object ComboBox5: TComboBox
      Left = 33
      Top = 29
      Width = 153
      Height = 21
      AutoComplete = False
      Style = csDropDownList
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnChange = ComboBox5Change
    end
  end
  object GroupBox4: TGroupBox
    Left = 568
    Top = 8
    Width = 153
    Height = 145
    TabOrder = 3
    object BitBtn3: TBitBtn
      Left = 8
      Top = 16
      Width = 137
      Height = 25
      Caption = 'Editar MagicList'
      TabOrder = 0
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 8
      Top = 48
      Width = 137
      Height = 25
      Caption = 'Resetar MagicList'
      TabOrder = 1
      OnClick = BitBtn4Click
    end
    object BitBtn6: TBitBtn
      Left = 8
      Top = 80
      Width = 137
      Height = 25
      Caption = 'Fechar Skill Editor'
      TabOrder = 2
      OnClick = BitBtn6Click
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 107
      Width = 137
      Height = 17
      Caption = 'Mostrar Query'
      TabOrder = 3
      WordWrap = True
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 124
      Width = 137
      Height = 17
      Caption = 'Copiar Query'
      TabOrder = 4
      WordWrap = True
    end
  end
  object Edit1: TEdit
    Left = 648
    Top = 196
    Width = 73
    Height = 21
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    Text = 'FF0000'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 223
    Width = 728
    Height = 24
    Panels = <
      item
        Text = 'CMT-VMAT SK Editor by Unneon'
        Width = 645
      end
      item
        Width = 50
      end>
  end
  object BitBtn7: TBitBtn
    Left = 650
    Top = 228
    Width = 75
    Height = 17
    Caption = 'Creditos'
    TabOrder = 6
    OnClick = BitBtn7Click
  end
  object GroupBox5: TGroupBox
    Left = 568
    Top = 152
    Width = 153
    Height = 41
    Caption = 'Editar Skill.mdb'
    TabOrder = 7
    object BitBtn8: TBitBtn
      Left = 80
      Top = 7
      Width = 65
      Height = 20
      Caption = 'Class'
      TabOrder = 0
      Visible = False
      OnClick = BitBtn8Click
    end
    object BitBtn5: TBitBtn
      Left = 8
      Top = 15
      Width = 137
      Height = 20
      Caption = 'Skills'
      TabOrder = 1
      OnClick = BitBtn5Click
    end
  end
  object RichEdit1: TRichEdit
    Left = 232
    Top = 223
    Width = 30
    Height = 20
    Lines.Strings = (
      'Rich'
      'Edit'
      '1')
    TabOrder = 8
    Visible = False
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 448
    Top = 144
  end
  object muQuery: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 472
    Top = 144
  end
  object SkillUpdate: TADOCommand
    Parameters = <>
    Left = 497
    Top = 144
  end
  object accQuery: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 416
    Top = 144
  end
  object skillquery: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 384
    Top = 144
  end
end
