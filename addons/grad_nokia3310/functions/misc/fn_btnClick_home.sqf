#include "..\macros_idc.hpp"
params ["_button"];

private _display = call GRAD_Nokia3310_fnc_displayGet;

switch (tolower _button) do {
     case "select": {
          ["mainmenu"] call GRAD_Nokia3310_fnc_initPage;
     };
     case "1";
     case "2";
     case "3";
     case "4";
     case "5";
     case "6";
     case "7";
     case "5";
     case "8";
     case "9";
     case "0": {

     };
};
