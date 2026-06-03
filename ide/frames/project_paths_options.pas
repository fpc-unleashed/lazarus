unit project_paths_options;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  // LCL
  Forms, StdCtrls,
  // LazUtils
  AvgLvlTree,
  // BuildIntf
  IDEOptionsIntf,
  // IdeIntf
  IDEOptEditorIntf,
  // IDE
  Project;

const
  // key stored in the project .lpi under ProjectOptions/CustomData/
  ProjectFPCSrcDirKey = 'FPCSrcDir';

type

  { TProjectPathsOptionsFrame }

  TProjectPathsOptionsFrame = class(TAbstractIDEOptionsEditor)
    FPCSrcDirLabel: TLabel;
    FPCSrcDirEdit: TEdit;
    RescanInfoLabel: TLabel;
  public
    function GetTitle: string; override;
    procedure Setup({%H-}ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings(AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings(AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  end;

implementation

{$R *.lfm}

{ TProjectPathsOptionsFrame }

function TProjectPathsOptionsFrame.GetTitle: string;
begin
  Result := 'Paths';
end;

procedure TProjectPathsOptionsFrame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  FPCSrcDirLabel.Caption := 'Override FPC source directory:';
  RescanInfoLabel.Caption :=
    'Overrides the global FPC source directory used for code completion in this project.'
    + LineEnding +
    'A rescan may be required after changing it: main menu -> Tools -> Rescan FPC Source Directory.'
    + LineEnding +
    'The command line option --fpcsrcdir= takes precedence over this setting.';
end;

procedure TProjectPathsOptionsFrame.ReadSettings(AOptions: TAbstractIDEOptions);
begin
  FPCSrcDirEdit.Text :=
    (AOptions as TProjectIDEOptions).Project.CustomData.Values[ProjectFPCSrcDirKey];
end;

procedure TProjectPathsOptionsFrame.WriteSettings(AOptions: TAbstractIDEOptions);
var
  Prj: TProject;
  Data: TStringToStringTree;
  NewVal: string;
begin
  Prj := (AOptions as TProjectIDEOptions).Project;
  Data := Prj.CustomData;
  NewVal := Trim(FPCSrcDirEdit.Text);
  if NewVal = Data.Values[ProjectFPCSrcDirKey] then exit;
  if NewVal = '' then
  begin
    if Data.Contains(ProjectFPCSrcDirKey) then
      Data.Remove(ProjectFPCSrcDirKey);
  end
  else
    Data.Values[ProjectFPCSrcDirKey] := NewVal;
  Prj.Modified := True;
end;

class function TProjectPathsOptionsFrame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := TProjectIDEOptions;
end;

initialization
  RegisterIDEOptionsEditor(GroupProject, TProjectPathsOptionsFrame, ProjectOptionsMisc + 50);

end.
