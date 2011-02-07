{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     中国人自己的开放源码第三方开发包                         }
{                   (C)Copyright 2001-2011 CnPack 开发组                       }
{                   ------------------------------------                       }
{                                                                              }
{            本开发包是开源的自由软件，您可以遵照 CnPack 的发布协议来修        }
{        改和重新发布这一程序。                                                }
{                                                                              }
{            发布这一开发包的目的是希望它有用，但没有任何担保。甚至没有        }
{        适合特定目的而隐含的担保。更详细的情况请参阅 CnPack 发布协议。        }
{                                                                              }
{            您应该已经和开发包一起收到一份 CnPack 发布协议的副本。如果        }
{        还没有，可访问我们的网站：                                            }
{                                                                              }
{            网站地址：http://www.cnpack.org                                   }
{            电子邮件：master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnPrefixEditFrm;
{* |<PRE>
================================================================================
* 软件名称：CnPack IDE 专家包
* 单元名称：组件前缀专家组件改名窗体单元
* 单元作者：周劲羽 (zjy@cnpack.org)
* 备    注：组件前缀专家组件改名窗体单元
* 开发平台：PWin2000Pro + Delphi 5.01
* 兼容测试：PWin9X/2000/XP + Delphi 5/6/7 + C++Builder 5/6
* 本 地 化：该单元中的字符串均符合本地化处理方式
* 单元标识：$Id$
* 修改记录：2003.04.26 V1.0
*               创建单元
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

{$IFDEF CNWIZARDS_CNPREFIXWIZARD}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, CnWizConsts, CnCommon, CnWizUtils, CnWizMultiLang,
  Buttons;

type

{ TCnPrefixEditForm }

  TCnPrefixEditForm = class(TCnTranslateForm)
    gbEdit: TGroupBox;
    lblFormName: TLabel;
    bvl1: TBevel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edtName: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    cbNeverDisp: TCheckBox;
    cbIgnoreComp: TCheckBox;
    btnPrefix: TButton;
    img1: TImage;
    edtOldName: TEdit;
    lbl4: TLabel;
    lblClassName: TLabel;
    lbl5: TLabel;
    lblText: TLabel;
    btnClassName: TSpeedButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnPrefixClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNameKeyPress(Sender: TObject; var Key: Char);
    procedure btnClassNameClick(Sender: TObject);
  private
    { Private declarations }
    FPrefix: string;
    FUseUnderLine: Boolean;
    FComponentClass: string;
  protected
    function GetHelpTopic: string; override;
  public
    { Public declarations }
    procedure SetEditSel(Sender: TObject);
  end;

// 显示对话框，取得新的组件名称
function GetNewComponentName(const FormName, ComponentClass, ComponentText,
  OldName: string; var Prefix, NewName: string; HideMode: Boolean;
  var IgnoreComp, AutoPopSuggestDlg: Boolean; UseUnderLine: Boolean): Boolean;

{$ENDIF CNWIZARDS_CNPREFIXWIZARD}

implementation

{$IFDEF CNWIZARDS_CNPREFIXWIZARD}

uses
  CnPrefixNewFrm, CnWizNotifier;

{$R *.DFM}

{ TCnPrefixEditForm }

// 取得新的组件名称
function GetNewComponentName(const FormName, ComponentClass, ComponentText,
  OldName: string; var Prefix, NewName: string; HideMode: Boolean;
  var IgnoreComp, AutoPopSuggestDlg: Boolean; UseUnderLine: Boolean): Boolean;
begin
  with TCnPrefixEditForm.Create(nil) do
  try
    lblFormName.Caption := FormName;
    lblClassName.Caption := ComponentClass;
    lblText.Caption := ComponentText;
    FUseUnderLine := UseUnderLine;
    FPrefix := Prefix;
    FComponentClass := ComponentClass;
    edtOldName.Text := OldName;
    edtName.Text := NewName;
    cbNeverDisp.Checked := not AutoPopSuggestDlg;
    if HideMode then
    begin
      cbIgnoreComp.Visible := False;
      cbNeverDisp.Visible := False;
      // btnPrefix.Visible := False;
    end;

    Result := ShowModal = mrOk;

    Prefix := FPrefix;
    NewName := edtName.Text;
    IgnoreComp := cbIgnoreComp.Checked;
    AutoPopSuggestDlg := not cbNeverDisp.Checked;
  finally
    Free;
  end;
end;

procedure TCnPrefixEditForm.FormShow(Sender: TObject);
begin
  CnWizNotifierServices.ExecuteOnApplicationIdle(SetEditSel);
end;

procedure TCnPrefixEditForm.btnOKClick(Sender: TObject);
begin
  if IsValidIdent(edtName.Text) then
    ModalResult := mrOk
  else
    ErrorDlg(SCnPrefixNameError);
end;

procedure TCnPrefixEditForm.btnPrefixClick(Sender: TObject);
var
  B1, B2: Boolean;
  OldPrefix: string;
begin
  OldPrefix := FPrefix;
  if GetNewComponentPrefix(FComponentClass, FPrefix, True, B1, B2) then
    if Pos(OldPrefix, edtName.Text) = 1 then
      edtName.Text := StringReplace(edtName.Text, OldPrefix, FPrefix, []);

  SetEditSel(nil);
end;

procedure TCnPrefixEditForm.SetEditSel;
begin
  edtName.SetFocus;
  if Self.FUseUnderLine then
  begin
    edtName.SelStart := Length(FPrefix) + 1;
    edtName.SelLength := Length(edtName.Text) - Length(FPrefix) - 1;
  end
  else
  begin
    edtName.SelStart := Length(FPrefix);
    edtName.SelLength := Length(edtName.Text) - Length(FPrefix);
  end;
end;

procedure TCnPrefixEditForm.btnHelpClick(Sender: TObject);
begin
  ShowFormHelp;
end;

function TCnPrefixEditForm.GetHelpTopic: string;
begin
  Result := 'CnPrefixEditForm';
end;

procedure TCnPrefixEditForm.edtNameKeyPress(Sender: TObject;
  var Key: Char);
const
  Chars = ['A'..'Z', 'a'..'z', '_', '0'..'9', #03, #08, #22, #24, #26]; // Ctrl+C/V/X/Z
begin
  if not CharInSet(Key, Chars) and not IsValidIdent('A' + Key) then
    Key := #0;
end;

procedure TCnPrefixEditForm.btnClassNameClick(Sender: TObject);
begin
  edtName.Text := RemoveClassPrefix(lblClassName.Caption);
end;

{$ENDIF CNWIZARDS_CNPREFIXWIZARD}
end.
