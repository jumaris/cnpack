object CnPas2HtmlConfigForm: TCnPas2HtmlConfigForm
  Left = 262
  Top = 138
  BorderStyle = bsDialog
  Caption = 'HTML ��ʽ�������ר������'
  ClientHeight = 293
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 86
    Top = 264
    Width = 75
    Height = 21
    Caption = 'ȷ��(&O)'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 166
    Top = 264
    Width = 75
    Height = 21
    Cancel = True
    Caption = 'ȡ��(&C)'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 246
    Top = 264
    Width = 75
    Height = 21
    Caption = '����(&H)'
    TabOrder = 3
    OnClick = btnHelpClick
  end
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 313
    Height = 249
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = '��������(&N)'
      object gbShortCut: TGroupBox
        Left = 8
        Top = 8
        Width = 289
        Height = 177
        Caption = '��ݼ�����(&K)'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 19
          Width = 76
          Height = 13
          Caption = '���Ƶ�������:'
        end
        object Label2: TLabel
          Left = 8
          Top = 43
          Width = 76
          Height = 13
          Caption = '�����ǰ�ļ�:'
        end
        object Label3: TLabel
          Left = 8
          Top = 115
          Width = 88
          Height = 13
          Caption = '�����ǰ������:'
        end
        object Label4: TLabel
          Left = 8
          Top = 139
          Width = 52
          Height = 13
          Caption = '���ô���:'
        end
        object Label6: TLabel
          Left = 8
          Top = 91
          Width = 76
          Height = 13
          Caption = '�����ǰ����:'
        end
        object Label8: TLabel
          Left = 8
          Top = 67
          Width = 76
          Height = 13
          Caption = '������ļ�:'
        end
        object hkCopySelected: THotKey
          Left = 104
          Top = 16
          Width = 177
          Height = 19
          HotKey = 0
          InvalidKeys = [hcNone, hcShift]
          Modifiers = []
          TabOrder = 0
        end
        object hkExportUnit: THotKey
          Left = 104
          Top = 40
          Width = 177
          Height = 19
          HotKey = 0
          InvalidKeys = [hcNone, hcShift]
          Modifiers = []
          TabOrder = 1
        end
        object hkExportBPG: THotKey
          Left = 104
          Top = 112
          Width = 177
          Height = 19
          HotKey = 0
          InvalidKeys = [hcNone, hcShift]
          Modifiers = []
          TabOrder = 4
        end
        object hkConfig: THotKey
          Left = 104
          Top = 136
          Width = 177
          Height = 19
          HotKey = 0
          InvalidKeys = [hcNone, hcShift]
          Modifiers = []
          TabOrder = 5
        end
        object hkExportDPR: THotKey
          Left = 104
          Top = 88
          Width = 177
          Height = 19
          HotKey = 0
          InvalidKeys = [hcNone, hcShift]
          Modifiers = []
          TabOrder = 3
        end
        object hkExportOpened: THotKey
          Left = 104
          Top = 64
          Width = 177
          Height = 19
          HotKey = 0
          InvalidKeys = [hcNone, hcShift]
          Modifiers = []
          TabOrder = 2
        end
      end
      object CheckBoxDispGauge: TCheckBox
        Left = 8
        Top = 192
        Width = 249
        Height = 17
        Caption = '����ת���ļ�ʱ��ʾ���ȴ���'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = '�������(&F)'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 289
        Height = 201
        Caption = '��������(&D)'
        TabOrder = 0
        object Label5: TLabel
          Left = 16
          Top = 28
          Width = 60
          Height = 13
          Caption = '����Ԫ�أ�'
        end
        object LabelFontDisp: TLabel
          Left = 56
          Top = 102
          Width = 217
          Height = 12
          AutoSize = False
          Caption = 'Courier New, 10'
          WordWrap = True
        end
        object Label7: TLabel
          Left = 16
          Top = 102
          Width = 36
          Height = 13
          Caption = '���壺'
        end
        object ComboBoxFont: TComboBox
          Left = 80
          Top = 24
          Width = 193
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = ComboBoxFontChange
          Items.Strings = (
            '��������'
            'Assembler (������)'
            'Comment (ע��)'
            'Directive (����ָ��)'
            'Identifier (��ʶ��)'
            'Reserved word (������)'
            'Number (����)'
            'Whitespace (�ո�)'
            'String (�ַ���)'
            'Symbol (������)')
        end
        object BtnModifyFont: TButton
          Left = 16
          Top = 60
          Width = 81
          Height = 21
          Action = ChangeFontAction
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object BtnResetFont: TButton
          Left = 104
          Top = 60
          Width = 81
          Height = 21
          Action = ResetFontAction
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object PanelDisp: TPanel
          Left = 16
          Top = 136
          Width = 257
          Height = 49
          BevelOuter = bvLowered
          Caption = 'CnPack'
          Color = clWhite
          Locked = True
          TabOrder = 4
          OnDblClick = PanelDispDblClick
        end
        object btnLoad: TButton
          Left = 192
          Top = 60
          Width = 81
          Height = 21
          Action = actLoad
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
      end
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 192
    Top = 184
  end
  object ActionList1: TActionList
    Left = 160
    Top = 184
    object ChangeFontAction: TAction
      Caption = '�޸�(&M)'
      Hint = '�޸ĵ�ǰ����'
      OnExecute = ChangeFontActionExecute
    end
    object ResetFontAction: TAction
      Caption = '����(&R)'
      Hint = '������������'
      OnExecute = ResetFontActionExecute
    end
    object actLoad: TAction
      Caption = '����(&L)'
      Hint = '�� IDE ����������'
      OnExecute = actLoadExecute
    end
  end
end