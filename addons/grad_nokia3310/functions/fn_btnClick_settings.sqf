#include "..\macros_idc.hpp"
#include "..\tones.hpp"

params ["_button","_display"];

private _curIndex = (([_display] call GRAD_Nokia3310_fnc_history) select 1) - 1;

switch (tolower _button) do {
     case "cancel": {
          [_display,"mainmenu"] call GRAD_Nokia3310_fnc_initPage;
     };
     case "select": {
          //update history and entertext
          (_display displayCtrl IDC_HISTORY) ctrlSetText format ["1-%1-1", (lbCurSel _lb) + 1];
          (_display displayCtrl IDC_ENTERTEXT) ctrlSetText "OK";

          (_display displayCtrl IDC_SETTINGS_SETTING) ctrlShow false;
          (_display displayCtrl IDC_SETTINGS_VALUE) ctrlShow false;
     };
     case "up";
     case "down": {
          private _nextIndex = if (tolower _button isEqualTo "down") then {_curIndex + 1} else {_curIndex - 1};
          [_display, _nextIndex] call GRAD_Nokia3310_fnc_scroll_settings;
     };
};
