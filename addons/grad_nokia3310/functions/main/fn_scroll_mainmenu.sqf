#include "..\macros_idc.hpp"
params ["_index"];

private _display = call GRAD_Nokia3310_fnc_displayGet;

private _pages = [  ["Phone book","phonebook"],
                    ["Call register","callregister"],
                    ["Tones","tones"],
                    ["Settings","settings"],
                    ["Games","games"],
                    ["Alarm clock","alarm"],
                    ["Profiles","profiles"]
];

if (_index isEqualTo count _pages) then {_index = 0;};
if (_index isEqualTo -1) then {_index = count _pages -1;};

private _page = _pages select _index;

[format ["%1",_index + 1]] call GRAD_Nokia3310_fnc_historySet;

(_display displayCtrl IDC_MAINMENU_TEXT) ctrlSetText (_page select 0);
(_display displayCtrl IDC_MAINMENU_PICTURE) ctrlSetText format ["GRAD_Nokia3310\data\dialog\mainmenu\%1_ca.paa",_page select 1];

GRAD_Nokia3310_curSel = _page select 1;
