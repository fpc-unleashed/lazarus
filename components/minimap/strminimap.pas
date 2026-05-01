unit StrMiniMap;

{$mode objfpc}{$H+}

interface

const
  SConfigFile = 'minimap.xml';

  KeyEnabled = 'Enabled';
  KeyAlignLeft = 'AlignLeft';
  KeyWidth = 'Width';
  KeyViewWindowColor = 'ViewWindowColor';
  KeyViewWindowTextColor = 'ViewWindowTextColor';
  KeyKeepFontColor = 'KeepFontColor';
  KeyInitialFontSize = 'InitialFontSize';

resourcestring
  SMinimapConfigTitle = 'Minimap';
  SShowMinimap = 'Show minimap';
  SPutMapLeftOfEditorRe = 'Put minimap left of editor (requires IDE restart for '
    +'existing tabs)';
  SMapWidth = 'Minimap width';
  SInitialFontSize = 'Initial font size';
  SViewWindowColor = 'View window color';
  SViewWindowTextColor = 'View window text color';
  SKeepFontColor = 'Keep font color unchanged';


implementation

end.

