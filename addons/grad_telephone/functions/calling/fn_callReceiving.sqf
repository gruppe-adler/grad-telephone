/* called on receivers client by caller remoteexec*/

params ["_caller", "_receiver"];

_vibrations = ["GRAD_telephone_phoneVibrate1", "GRAD_telephone_phoneVibrate2"];

_receiver setVariable ["GRAD_telephone_currentState","receiving",true];

[call TFAR_fnc_activeSwRadio, -1] call GRAD_telephone_fnc_showRadioInfo;

// checking for player, because in SP our own display would be overwritten
if (isPlayer _receiver) then {
	// [str _caller] call GRAD_telephone_fnc_setDisplayName;
	// ["incoming call..."] call GRAD_telephone_fnc_setDisplayNumber;
};


while {_caller getVariable ["GRAD_telephone_currentState","noPhone"] == "waiting" &&
   	_receiver getVariable ["GRAD_telephone_currentState","noPhone"] == "receiving"
  } do {

  	// todo: this is ugly shit
  	[_receiver, ["GRAD_telephone_phoneRingOriginal", 50]] remoteExec ["say3D",0,false];
	sleep 1;
	if (_caller getVariable ["GRAD_telephone_currentState","noPhone"] == "waiting" && _receiver getVariable ["GRAD_telephone_currentState","noPhone"] == "receiving") exitWith {};
	sleep 1;
	if (_caller getVariable ["GRAD_telephone_currentState","noPhone"] == "waiting" && _receiver getVariable ["GRAD_telephone_currentState","noPhone"] == "receiving") exitWith {};
	sleep 1;
	if (_caller getVariable ["GRAD_telephone_currentState","noPhone"] == "waiting" && _receiver getVariable ["GRAD_telephone_currentState","noPhone"] == "receiving") exitWith {};
	sleep 0.5;
};

if (_caller getVariable ["GRAD_telephone_currentState","noPhone"] == "rejected") then {
	[_receiver] call GRAD_telephone_fnc_callReject;
};