{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     �й����Լ��Ŀ���Դ�������������                         }
{                   (C)Copyright 2001-2009 CnPack ������                       }
{                   ------------------------------------                       }
{                                                                              }
{            ���������ǿ�Դ���������������������� CnPack �ķ���Э������        }
{        �ĺ����·�����һ����                                                }
{                                                                              }
{            ������һ��������Ŀ����ϣ�������ã���û���κε���������û��        }
{        �ʺ��ض�Ŀ�Ķ������ĵ���������ϸ���������� CnPack ����Э�顣        }
{                                                                              }
{            ��Ӧ���Ѿ��Ϳ�����һ���յ�һ�� CnPack ����Э��ĸ��������        }
{        ��û�У��ɷ������ǵ���վ��                                            }
{                                                                              }
{            ��վ��ַ��http://www.cnpack.org                                   }
{            �����ʼ���master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnBookmarkConfigFrm;
{ |<PRE>
================================================================================
* �������ƣ�CnPack IDE ר�Ұ�
* ��Ԫ���ƣ���ǩ�����������ô��嵥Ԫ
* ��Ԫ���ߣ��ܾ��� (zjy@cnpack.org)
* ��    ע��
* ����ƽ̨��PWin2000Pro + Delphi 5.01
* ���ݲ��ԣ�PWin9X/2000/XP + Delphi 5/6/7 + C++Builder 5/6
* �� �� �����ô����е��ַ��������ϱ��ػ�������ʽ
* ��Ԫ��ʶ��$Id: CnBookmarkConfigFrm.pas,v 1.10 2009/01/02 08:36:29 liuxiao Exp $
* �޸ļ�¼��2002.11.24 V1.0
*               ������Ԫ
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, CnSpin, CnWizOptions, CnWizMultiLang;

type
  TCnBookmarkConfigForm = class(TCnTranslateForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbBrowse: TGroupBox;
    btnSourceFont: TButton;
    btnHighlightFont: TButton;
    Label1: TLabel;
    Label2: TLabel;
    gwBookmark: TGroupBox;
    cbSaveBookmark: TCheckBox;
    SourceFontDialog: TFontDialog;
    HighlightFontDialog: TFontDialog;
    chkAutoRefresh: TCheckBox;
    seDispLines: TCnSpinEdit;
    lbl1: TLabel;
    seInterval: TCnSpinEdit;
    lbl2: TLabel;
    procedure btnSourceFontClick(Sender: TObject);
    procedure btnHighlightFontClick(Sender: TObject);
    procedure seDispLinesKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ShowBookmarkConfigForm(var DispLines: Integer; var SaveBookmark,
  AutoRefresh: Boolean; var Interval: Integer; SourceFont, HighlightFont:
  TFont): Boolean;

implementation

{$R *.DFM}

function ShowBookmarkConfigForm(var DispLines: Integer; var SaveBookmark,
  AutoRefresh: Boolean; var Interval: Integer; SourceFont, HighlightFont:
  TFont): Boolean;
begin
  with TCnBookmarkConfigForm.Create(nil) do
  try
    ShowHint := WizOptions.ShowHint;
    seDispLines.Value := DispLines;
    cbSaveBookmark.Checked := SaveBookmark;
    chkAutoRefresh.Checked := AutoRefresh;
    seInterval.Value := Interval;
    SourceFontDialog.Font.Assign(SourceFont);
    HighlightFontDialog.Font.Assign(HighlightFont);
    Result := ShowModal = mrOk;
    if Result then
    begin
      DispLines := seDispLines.Value;
      SaveBookmark := cbSaveBookmark.Checked;
      AutoRefresh := chkAutoRefresh.Checked;
      Interval := seInterval.Value;
      SourceFont.Assign(SourceFontDialog.Font);
      HighlightFont.Assign(HighlightFontDialog.Font);
    end;
  finally
    Free;
  end;
end;

procedure TCnBookmarkConfigForm.btnSourceFontClick(Sender: TObject);
begin
  SourceFontDialog.Execute;
end;

procedure TCnBookmarkConfigForm.btnHighlightFontClick(Sender: TObject);
begin
  HighlightFontDialog.Execute;
end;

procedure TCnBookmarkConfigForm.seDispLinesKeyPress(Sender: TObject;
  var Key: Char);
begin   
  if Key = #27 then
  begin
    ModalResult := mrCancel;
    Key := #0;
  end
  else
  if Key = #13 then
  begin
    ModalResult := mrOk;
    Key := #0;
  end
end;

end.