{*******************************************************}
{                                                       }
{       Pascal Script Source File                       }
{       Run by RemObjects Pascal Script in CnWizards    }
{                                                       }
{       Generated by CnPack IDE Wizards                 }
{                                                       }
{*******************************************************}

program MessageView;

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, CnDebug;

var
  I, J: Integer;
  MsgView: TCustomForm;
  Tree: TTreeView;
//Node: TTreeNode;

begin
  Tree := nil;
  MsgView := nil;

  for I := 0 to Screen.CustomFormCount - 1 do
  begin
    if Screen.CustomForms[I].ClassNameIs('TMessageViewForm') then
    begin
      MsgView := Screen.CustomForms[I];
      for J := 0 to MsgView.ControlCount - 1 do
      begin
        if MsgView.Controls[J].ClassNameIs('TTreeMessageView') then
        begin
         Writeln('Found Message View Tree.');
         Tree := TTreeView(MsgView.Controls[J]);
        end;
      end;
    end;
  end;

  if MsgView <> nil then
    MsgView.Show;
    
  if Tree <> nil then
  begin
    Tree.HideSelection := False;
    Tree.Items.Clear;
    CnDebugger.LogObject(Tree);
    // Node := Tree.Items.Add(nil, 'Test Pascal Script by CnWizards.');
  end;
end.
 
 