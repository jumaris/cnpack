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

{******************************************************************************}
{ Unit Note:                                                                   }
{    This file is derived from GExperts 1.2                                    }
{                                                                              }
{ Original author:                                                             }
{    GExperts, Inc  http://www.gexperts.org/                                   }
{    Erik Berry <eberry@gexperts.org> or <eb@techie.com>                       }
{******************************************************************************}

unit CnWizIdeDock;
{* |<PRE>
================================================================================
* �������ƣ�CnPack IDE ר�Ұ�
* ��Ԫ���ƣ�IDE Dock �����嵥Ԫ
* ��Ԫ���ߣ��ܾ��� (zjy@cnpack.org)
* ��    ע���ô���Ϊ֧�� IDE �ڲ�ͣ���Ļ����壬��ֲ�� GExperts
*           ��ԭʼ������ GExperts License �ı���
* ����ƽ̨��PWin2000Pro + Delphi 5.01
* ���ݲ��ԣ�PWin9X/2000/XP + Delphi 5/6/7 + C++Builder 5/6
* �� �� �����ô����е��ַ��������ϱ��ػ�������ʽ
* ��Ԫ��ʶ��$Id$
* �޸ļ�¼��2009.01.07
*               ����λ�ñ��湦�ܣ�������һЩ�� CnTranslateForm �в�ͬ�Ļ���
*           2004.11.19 V1.1
*               ����������л������Scaled=Falseʱ���廹�ǻ�Scaled��BUG (shenloqi)
*           2003.02.16 V1.0
*               �� GExperts 1.12Src �޸Ķ���
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

{$IFDEF COMPILER12}
// RAD Studio 2009 �� CreateParams �п��ܵ�����ѭ��
{$DEFINE CREATE_PARAMS_BUG}
{$ENDIF}

uses
  Windows, SysUtils, Classes, IniFiles, Forms, Controls, Menus, Messages,
  MenuBar, ActnList, CnWizUtils, CnClasses, CnLangMgr, CnFormScaler,
  // �õ�Ԫ������ DsnIdeXX/DesignIde ���У�ר�ұ�������������
  DockForm;

type

{ TDummyPopupMenu }

  TDummyPopupMenu = class(TPopupMenu)
  private
    OwnerMenu: TMenu;
  public
    function IsShortCut(var Message: TWMKey): Boolean; override;
  end;

{ TCnIdeDockForm }

{$IFDEF COMPILER8_UP}
  TDesktopIniFile = TCustomIniFile;
{$ELSE}
  TDesktopIniFile = TMemIniFile;
{$ENDIF}

  TCnIdeDockForm = class(TDockableForm)
  protected
    FMenuBar: TMenuBar;
    FNeedRestore: Boolean;
    FRestoreRect: TRect;
    // ���¸����� TCnTranslateForm ��ʵ�ֶ���
    FScaler: TCnFormScaler;
    procedure OnLanguageChanged(Sender: TObject);
    procedure OnHelp(Sender: TObject);
    function DoHandleShortCut(var Message: TWMKey): Boolean;
    procedure RestorePosition;
  protected
    procedure Loaded; override;
    procedure DoShow; override;

    // ���¸����� TCnTranslateForm ��ʵ�ֶ���
    procedure DoCreate; override;
    procedure DoDestroy; override;

{$IFDEF CREATE_PARAMS_BUG}
    procedure CreateParams(var Params: TCreateParams); override;
{$ENDIF}

    function HandleShortCut(AShortCut: TShortCut): Boolean; virtual;
    {* ������ݼ�}
    procedure DoLoadWindowState(Desktop: TCustomIniFile); virtual;
    {* װ�����ò���}
    procedure DoSaveWindowState(Desktop: TCustomIniFile; IsProject: Boolean); virtual;
    {* �������ò���}
    procedure DoLanguageChanged(Sender: TObject); virtual;
    {* ��ǰ���Ա��֪ͨ}
    function GetHelpTopic: string; virtual;
    {* ���ര�����ش˷������� F1 ��Ӧ�İ�����������}
    function GetNeedPersistentPosition: Boolean; virtual;
    {* ���ര�����ش˷��������Ƿ���Ҫ���洰���С��λ�ù��´�������ָ���
       ���� Dock ���壬Ĭ����Ҫ }
    procedure ShowFormHelp;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultHandler(var Message); override;
    procedure LoadWindowState(Desktop: TDesktopIniFile); override;
    procedure SaveWindowState(Desktop: TDesktopIniFile; IsProject: Boolean); override;

    // ���¸����� TCnTranslateForm ��ʵ�ֶ���
    procedure Translate; virtual;
  end;

type
  TIdeDockFormClass = class of TCnIdeDockForm;

type
  EIdeDockError = class(Exception);

  IIdeDockManager = interface(IUnknown)
    ['{408FC1B1-BD7A-4401-93C2-B41E1D19580B}']
    // Note: IdeDockFormName must be IDE-unique
    procedure RegisterDockableForm(IdeDockFormClass: TIdeDockFormClass;
      var IdeDockFormVar; const IdeDockFormName: string);
    procedure UnRegisterDockableForm(
      var IdeDockFormVar; const IdeDockFormName: string);

    procedure ShowForm(Form: TForm);
  end;

function IdeDockManager: IIdeDockManager;

implementation

uses
{$IFDEF DEBUG}
  CnDebug,
{$ENDIF}
  CnCommon, CnWizConsts, CnWizOptions, CnWizNotifier,
  // ���µ�Ԫ������ DsnIdeXX/DesignIde ���У�ר�ұ�������������
  DeskForm, DeskUtil;

{$R *.dfm}

type
  TIdeDockManager = class(TSingletonInterfacedObject, IIdeDockManager)
  public
    // Note: IdeDockFormName must be IDE-unique
    procedure RegisterDockableForm(IdeDockFormClass: TIdeDockFormClass;
      var IdeDockFormVar; const IdeDockFormName: string);
    procedure UnRegisterDockableForm(
      var IdeDockFormVar; const IdeDockFormName: string);
    procedure ShowForm(Form: TForm);
  end;

{ TIdeDockManager }

procedure TIdeDockManager.ShowForm(Form: TForm);
begin
  with Form as TDockableForm do
  begin
    if not Floating then
    begin
      ForceShow;
      FocusWindow(Form);
    end
    else
      Show;
  end;
end;

procedure TIdeDockManager.RegisterDockableForm(IdeDockFormClass: TIdeDockFormClass;
  var IdeDockFormVar; const IdeDockFormName: string);
begin
  if @RegisterFieldAddress <> nil then
    RegisterFieldAddress(IdeDockFormName, @IdeDockFormVar);

  RegisterDesktopFormClass(IdeDockFormClass, IdeDockFormName, IdeDockFormName);
end;

procedure TIdeDockManager.UnRegisterDockableForm(var IdeDockFormVar; const
  IdeDockFormName: string);
begin
  if @UnregisterFieldAddress <> nil then
    UnregisterFieldAddress(@IdeDockFormVar);
end;

var
  PrivateIdeDockManager: TIdeDockManager = nil;

function IdeDockManager: IIdeDockManager;
begin
  Result := PrivateIdeDockManager as IIdeDockManager;
end;

{ TCnIdeDockForm }

constructor TCnIdeDockForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if PopupMenu = nil then
  begin
    PopupMenu := TDummyPopupMenu.Create(Self);
    PopupMenu.AutoPopup := False;
    TDummyPopupMenu(PopupMenu).OwnerMenu := Menu;
  end;

  if Menu <> nil then
  begin
    FMenuBar := TMenuBar.Create(Self);
    FMenuBar.Parent := Self;
    FMenuBar.Menu := Menu;
    FMenuBar.Height := GetSystemMetrics(SM_CYMENU) + 2;
    Menu := nil;
  end;
  DeskSection := Name;
  AutoSave := True;
  SaveStateNecessary := True;
end;

destructor TCnIdeDockForm.Destroy;
begin
  SaveStateNecessary := True;
  inherited Destroy;
end;

procedure TCnIdeDockForm.Loaded;
var
  Ini: TCustomIniFile;
  I: Integer;
begin
  inherited Loaded;
  FScaler := TCnFormScaler.Create(Self);
  FScaler.DoEffects;

  // ��ȡ���ָ�λ�ã����� IDE ������ͣ�� Form ������£��ƺ���Ч
  if GetNeedPersistentPosition then
  begin
    Ini := WizOptions.CreateRegIniFile;
    try
      FNeedRestore := True;
      I := Ini.ReadInteger(SCnFormPosition, ClassName + SCnFormPositionTop, -1);
      if I <> -1 then FRestoreRect.Top := I else FNeedRestore := False;
      I := Ini.ReadInteger(SCnFormPosition, ClassName + SCnFormPositionLeft, -1);
      if I <> -1 then FRestoreRect.Left := I else FNeedRestore := False;
      I := Ini.ReadInteger(SCnFormPosition, ClassName + SCnFormPositionWidth, -1);
      if I <> -1 then FRestoreRect.Right := I + FRestoreRect.Left else FNeedRestore := False;
      I := Ini.ReadInteger(SCnFormPosition, ClassName + SCnFormPositionHeight, -1);
      if I <> -1 then FRestoreRect.Bottom := I + FRestoreRect.Top else FNeedRestore := False;;

      Position := poDesigned;
    finally
      Ini.Free;
    end;
  end;
end;

procedure TCnIdeDockForm.DoCreate;
begin
  DisableAlign;
  try
    Translate;
    if not Scaled then
      Font.Height := MulDiv(Font.Height, FScaler.DesignPPI, PixelsPerInch);
  finally
    EnableAlign;
  end;
  DoLanguageChanged(CnLanguageManager);

  inherited;
end;

procedure TCnIdeDockForm.DoDestroy;
var
  Ini: TCustomIniFile;
begin
  // ����λ�ã���ͣ��������
  if (Parent = nil) and GetNeedPersistentPosition and (Position in [poDesigned,
    poDefault, poDefaultPosOnly, poDefaultSizeOnly]) then
  begin
    Ini := WizOptions.CreateRegIniFile;
    try
      Ini.WriteInteger(SCnFormPosition, ClassName + SCnFormPositionTop, Top);
      Ini.WriteInteger(SCnFormPosition, ClassName + SCnFormPositionLeft, Left);
      Ini.WriteInteger(SCnFormPosition, ClassName + SCnFormPositionWidth, Width);
      Ini.WriteInteger(SCnFormPosition, ClassName + SCnFormPositionHeight, Height);
    finally
      Ini.Free;
    end;
  end;

  FScaler.Free;
  if CnLanguageManager <> nil then
    CnLanguageManager.RemoveChangeNotifier(OnLanguageChanged);
  inherited;
end;

{$IFDEF CREATE_PARAMS_BUG}

procedure TCnIdeDockForm.CreateParams(var Params: TCreateParams);
var
  OldLong: Longint;
  AHandle: THandle;
  NeedChange: Boolean;
begin
  NeedChange := False;
  OldLong := 0;
  AHandle := Application.ActiveFormHandle;
  if AHandle <> 0 then
  begin
    OldLong := GetWindowLong(AHandle, GWL_EXSTYLE);
    NeedChange := OldLong and WS_EX_TOOLWINDOW = WS_EX_TOOLWINDOW;
    if NeedChange then
    begin
{$IFDEF DEBUG}
      CnDebugger.LogMsg('TCnIdeDockForm: D2009 Bug fix: HWnd for WS_EX_TOOLWINDOW style.');
{$ENDIF}
      SetWindowLong(AHandle, GWL_EXSTYLE, OldLong and not WS_EX_TOOLWINDOW);
    end;
  end;

  inherited; // �ȴ����굱ǰ���ڵķ������ԭ���̣�֮��ָ�

  if NeedChange and (OldLong <> 0) then
    SetWindowLong(AHandle, GWL_EXSTYLE, OldLong);
end;

{$ENDIF}

procedure TCnIdeDockForm.LoadWindowState(Desktop: TDesktopIniFile);
begin
  inherited LoadWindowState(Desktop);
  DoLoadWindowState(Desktop);
end;

procedure TCnIdeDockForm.SaveWindowState(Desktop: TDesktopIniFile; IsProject: Boolean);
begin
  inherited SaveWindowState(Desktop, IsProject);
  DoSaveWindowState(Desktop, IsProject);
end;

procedure TCnIdeDockForm.DoLoadWindowState(Desktop: TCustomIniFile);
begin

end;

procedure TCnIdeDockForm.DoSaveWindowState(Desktop: TCustomIniFile; IsProject: Boolean);
begin

end;

procedure TCnIdeDockForm.DefaultHandler(var Message);
begin
  // ͣ��ʱ�����ø��ؼ��Ĳ˵�
  if TMessage(Message).Msg <> WM_CONTEXTMENU then
    inherited;
end;

procedure TCnIdeDockForm.Translate;
begin
  if (CnLanguageManager <> nil) and (CnLanguageManager.LanguageStorage <> nil)
    and (CnLanguageManager.LanguageStorage.LanguageCount > 0) then
  begin
    CnLanguageManager.AddChangeNotifier(OnLanguageChanged);
    Screen.Cursor := crHourGlass;
    try
      CnLanguageManager.TranslateForm(Self);
    finally
      Screen.Cursor := crDefault;
    end;
  end
  else
  begin
{$IFDEF DEBUG}
    CnDebugger.LogMsgError('MultiLang Initialization Error. Use Chinese Font as default.');
{$ENDIF}
    // ���ʼ��ʧ�ܶ���������Ŀ����ԭʼ���������ģ�������Ϊ��������
    Font.Charset := GB2312_CHARSET;
  end;
end;

procedure TCnIdeDockForm.OnLanguageChanged(Sender: TObject);
begin
  DisableAlign;
  try
    CnLanguageManager.TranslateForm(Self);
    if not Scaled then
      Font.Height := MulDiv(Font.Height, FScaler.DesignPPI, PixelsPerInch);
  finally
    EnableAlign;
  end;
  DoLanguageChanged(Sender);
end;

procedure TCnIdeDockForm.ShowFormHelp;
begin
  OnHelp(nil)
end;

procedure TCnIdeDockForm.OnHelp(Sender: TObject);
var
  Topic: string;
begin
  Topic := GetHelpTopic;
  if Topic <> '' then
    ShowHelp(Topic);
end;

function TCnIdeDockForm.DoHandleShortCut(var Message: TWMKey): Boolean;
var
  AShortCut: TShortCut;
  ShiftState: TShiftState;
begin
  ShiftState := KeyDataToShiftState(Message.KeyData);
  AShortCut := ShortCut(Message.CharCode, ShiftState);
  Result := HandleShortCut(AShortCut);
end;

function TCnIdeDockForm.HandleShortCut(AShortCut: TShortCut): Boolean;
begin
  if AShortCut = ShortCut(VK_F1, []) then
  begin
    ShowFormHelp;
    Result := True;
  end
  else
    Result := HandleEditShortCut(Screen.ActiveControl, AShortCut);
end;

function TCnIdeDockForm.GetHelpTopic: string;
begin
  Result := '';
end;

procedure TCnIdeDockForm.DoLanguageChanged(Sender: TObject);
begin
  // ����Ҳɶ������
end;

function TCnIdeDockForm.GetNeedPersistentPosition: Boolean;
begin
  Result := True; // ���� IDEDockForm����Ϊ True;
end;

procedure TCnIdeDockForm.DoShow;
begin
  if FNeedRestore and (Parent = nil) then
  begin
    RestorePosition;
    FNeedRestore := False;
  end;
  inherited;
end;

procedure TCnIdeDockForm.RestorePosition;
begin
  SetBounds(FRestoreRect.Left, FRestoreRect.Top,
    FRestoreRect.Right - FRestoreRect.Left, FRestoreRect.Bottom - FRestoreRect.Top);
end;

{ TDummyPopupMenu }

function TDummyPopupMenu.IsShortCut(var Message: TWMKey): Boolean;
begin
  // Call the form's IsShortCut so docked forms can use main menu shortcuts
  Result := (OwnerMenu <> nil) and OwnerMenu.IsShortCut(Message) or
    TCustomForm(Owner).IsShortCut(Message) or
    TCnIdeDockForm(Owner).DoHandleShortCut(Message);
end;

initialization
  PrivateIdeDockManager := TIdeDockManager.Create;

finalization
  FreeAndNil(PrivateIdeDockManager);

end.
