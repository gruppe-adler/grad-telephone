_name = player getVariable ["GRAD_telephone_currentStateDisplayName", ""];
_number = player getVariable ["GRAD_telephone_currentStateDisplayNumber", ""];

[_name] call GRAD_fnc_setDisplayName;
[_number] call GRAD_fnc_setDisplayNumber;