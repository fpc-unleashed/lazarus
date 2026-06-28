{
 ***************************************************************************
 *                                                                         *
 *   This source is free software; you can redistribute it and/or modify   *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This code is distributed in the hope that it will be useful, but      *
 *   WITHOUT ANY WARRANTY; without even the implied warranty of            *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU     *
 *   General Public License for more details.                              *
 *                                                                         *
 *   A copy of the GNU General Public License is available on the World    *
 *   Wide Web at <http://www.gnu.org/copyleft/gpl.html>. You can also      *
 *   obtain it by writing to the Free Software Foundation,                 *
 *   Inc., 51 Franklin Street - Fifth Floor, Boston, MA 02110-1335, USA.   *
 *                                                                         *
 ***************************************************************************

  Abstract:
    Frame for environment options for things happening during startup.
    - Single Lazarus IDE instance / multiple instances.
    - The project that gets opened or created.
}
unit IdeStartup_Options;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  // LCL
  StdCtrls, Controls, Dialogs,
  // LazControls
  DividerBevel,
  // LazUtils
  LazFileUtils, LazLoggerBase,
  // CodeTools
  CodeToolManager, DefineTemplates,
  // BuildIntf
  ProjectIntf, IDEOptionsIntf,
  // IdeIntf
  IDEOptEditorIntf,
  // IDE
  EnvironmentOpts, LazarusIDEStrConsts;

type

  { TIdeStartupFrame }

  TIdeStartupFrame = class(TAbstractIDEOptionsEditor)
    CheckFPPkgCheckBox: TCheckBox;
    divInitialChecks: TDividerBevel;
    ProjectTypeLabel: TLabel;
    ProjectTypeCB: TComboBox;
    divFileAssociation: TDividerBevel;
    divProjectToOpen: TDividerBevel;
    divSimpleProgram: TDividerBevel;
    SimpleAppNameLabel: TLabel;
    SimpleAppNameEdit: TEdit;
    SimpleMainProcLabel: TLabel;
    SimpleMainProcEdit: TEdit;
    SimpleModeUnleashedCheckBox: TCheckBox;
    LazarusInstancesCB: TComboBox;
    LazarusInstancesLabel: TLabel;
    OpenLastProjectAtStartCheckBox: TCheckBox;
  private
    FOldOpenLastProjectAtStart: boolean;
    FOldProjectTemplateAtStart: string;
  public
    function Check: Boolean; override;
    function GetTitle: String; override;
    procedure Setup({%H-}ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings(AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings(AOptions: TAbstractIDEOptions); override;
    procedure RestoreSettings(AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  end;

implementation

{$R *.lfm}

{ TIdeStartupFrame }

// matches (?i)^[a-z_][a-z0-9_]{0,126}$ - a valid Pascal identifier, max 127 chars
function IsValidSimpleName(const s: string): boolean;
var
  i: integer;
begin
  Result := False;
  if (Length(s) < 1) or (Length(s) > 127) then exit;
  if not (s[1] in ['A'..'Z','a'..'z','_']) then exit;
  for i := 2 to Length(s) do
    if not (s[i] in ['A'..'Z','a'..'z','0'..'9','_']) then exit;
  Result := True;
end;

function TIdeStartupFrame.Check: Boolean;
var
  s: string;
begin
  Result := False;
  s := Trim(SimpleAppNameEdit.Text);
  if s = '' then
  begin
    ShowMessage('Simple program: app name cannot be empty.');
    exit;
  end;
  if not IsValidSimpleName(s) then
  begin
    ShowMessage('Simple program: app name must be a valid identifier.');
    exit;
  end;
  s := Trim(SimpleMainProcEdit.Text);
  if s = '' then
  begin
    ShowMessage('Simple program: main proc name cannot be empty.');
    exit;
  end;
  if not IsValidSimpleName(s) then
  begin
    ShowMessage('Simple program: main proc name must be a valid identifier.');
    exit;
  end;
  Result := True;
end;

function TIdeStartupFrame.GetTitle: String;
begin
  Result := dlgEnvIdeStartup;
end;

procedure TIdeStartupFrame.Setup(ADialog: TAbstractOptionsEditorDialog);
var
  i: Integer;
  pd: TProjectDescriptor;
begin
  // Using File Association in OS
  divFileAssociation.Caption := dlgFileAssociationInOS;
  LazarusInstancesLabel.Caption := dlgLazarusInstances;
  with LazarusInstancesCB.Items do
  begin
    BeginUpdate;
    Add(dlgMultipleInstances_AlwaysStartNew);
    Add(dlgMultipleInstances_OpenFilesInRunning);
    Add(dlgMultipleInstances_ForceSingleInstance);
    EndUpdate;
  end;
  Assert(LazarusInstancesCB.Items.Count = Ord(High(TIDEMultipleInstancesOption))+1);
  // Project to Open or Create
  divProjectToOpen.Caption := dlgProjectToOpenOrCreate;
  OpenLastProjectAtStartCheckBox.Caption := dlgQOpenLastPrj;
  ProjectTypeLabel.Caption := dlgNewProjectType;
  for i:=0 to ProjectDescriptors.Count-1 do
  begin
    pd := ProjectDescriptors[i];
    if pd.VisibleInNewDialog then
      ProjectTypeCB.Items.AddObject(pd.GetLocalizedName, pd);
  end;

  // Simple program
  divSimpleProgram.Caption := 'Simple program';
  SimpleAppNameLabel.Caption := 'Default app name';
  SimpleMainProcLabel.Caption := 'Main proc name';
  SimpleModeUnleashedCheckBox.Caption := 'Include {$mode unleashed}';

  divInitialChecks.Caption := lisInitialChecks;
  CheckFPPkgCheckBox.Caption:=lisQuickCheckFppkgConfigurationAtStart;
end;

procedure TIdeStartupFrame.ReadSettings(AOptions: TAbstractIDEOptions);
var
  i: Integer;
  pd: TProjectDescriptor;
begin
  with AOptions as TEnvironmentOptions do
  begin
    LazarusInstancesCB.ItemIndex := Ord(MultipleInstances);

    FOldOpenLastProjectAtStart := OpenLastProjectAtStart;
    OpenLastProjectAtStartCheckBox.Checked:=OpenLastProjectAtStart;

    FOldProjectTemplateAtStart := NewProjectTemplateAtStart;
    i:=ProjectTypeCB.Items.Count-1;
    while i>=0 do
    begin
      pd := TProjectDescriptor(ProjectTypeCB.Items.Objects[i]);
      if pd.Name = FOldProjectTemplateAtStart then
        break;
      dec(i);
    end;
    if i<0 then i:=0;
    ProjectTypeCB.ItemIndex := i;

    CheckFPPkgCheckBox.Checked:=FppkgCheck;

    SimpleAppNameEdit.Text:=SimpleProgramAppName;
    SimpleMainProcEdit.Text:=SimpleProgramMainProc;
    SimpleModeUnleashedCheckBox.Checked:=SimpleProgramModeUnleashed;
  end;
end;

procedure TIdeStartupFrame.WriteSettings(AOptions: TAbstractIDEOptions);
var
  pd: TProjectDescriptor;
begin
  with AOptions as TEnvironmentOptions do
  begin
    MultipleInstances := TIDEMultipleInstancesOption(LazarusInstancesCB.ItemIndex);

    OpenLastProjectAtStart := OpenLastProjectAtStartCheckBox.Checked;
    // Don't use the localized name from ProjectTypeCB.Text.
    pd := TProjectDescriptor(ProjectTypeCB.Items.Objects[ProjectTypeCB.ItemIndex]);
    NewProjectTemplateAtStart := pd.Name;

    FppkgCheck:=CheckFPPkgCheckBox.Checked;

    SimpleProgramAppName:=Trim(SimpleAppNameEdit.Text);
    SimpleProgramMainProc:=Trim(SimpleMainProcEdit.Text);
    SimpleProgramModeUnleashed:=SimpleModeUnleashedCheckBox.Checked;
  end;
end;

procedure TIdeStartupFrame.RestoreSettings(AOptions: TAbstractIDEOptions);
begin
  inherited RestoreSettings(AOptions);
  with AOptions as TEnvironmentOptions do
  begin
    OpenLastProjectAtStart := FOldOpenLastProjectAtStart;
    NewProjectTemplateAtStart := FOldProjectTemplateAtStart;
  end;
end;

class function TIdeStartupFrame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := TEnvironmentOptions;
end;

initialization
  RegisterIDEOptionsEditor(GroupEnvironment, TIdeStartupFrame, EnvOptionsIdeStartup);

end.

