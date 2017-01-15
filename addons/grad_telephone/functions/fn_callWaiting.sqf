#include "..\macros.h"

private ["_wasAlreadyRinging", "_number", "_ringBeeps", "_busyBeeps"];

params ["_receiverObject", "_number"];

player setVariable ["GRAD_telephone_currentState","waiting",true];

_ringBeeps = ["GRAD_telephone_phoneRingBeep1", "GRAD_telephone_phoneRingBeep2", "GRAD_telephone_phoneRingBeep2", "GRAD_telephone_phoneRingBeep2", "GRAD_telephone_phoneRingBeep2", "GRAD_telephone_phoneRingBeep2"];
_busyBeeps = ["GRAD_telephone_phoneRingBusy1", "GRAD_telephone_phoneRingBusy2", "GRAD_telephone_phoneRingBusy3"];

// diag_log format ["start waiting for %1", _name];

_wasAlreadyRinging = false;

[player, _receiverObject] call GRAD_fnc_pleaseReceive;

if (_receiverObject getVariable ["GRAD_telephone_currentState", "noPhone"] == "receiving") then {
		// ringing signal
		_condition = true;
		while {player getVariable ["GRAD_telephone_currentState","noPhone"] == "waiting" &&
			   _receiverObject getVariable ["GRAD_telephone_currentState", "noPhone"] == "receiving"
			} do {
			_wasAlreadyRinging = true;
			[_ringBeeps, _condition] spawn {
		  		while {_this select 1} do {
					playSound (selectRandom (_this select 0));
					sleep 5;
					diag_log format ["callWaiting: long beep"];
				};
			};
		};
	_condition = false;
};



// if player decides to end call OR target changes status, check again if transmission should be established
if (player getVariable ["GRAD_telephone_currentState","noPhone"] == "waiting" &&
	_receiverObject getVariable ["GRAD_telephone_currentState", "noPhone"] == "talking"
	) then {

	if (DEBUG_MODE) then { diag_log format ["callWaiting: target changed status to talking"];};

	[_receiverObject, 
		[_receiverObject] call GRAD_fnc_getNativePhoneFrequency, 
		[_receiverObject] call GRAD_fnc_getNativePhoneCode
	] remoteExec ["setCallersPhoneFrequency", _receiverObject, false];
	[] call GRAD_fnc_callTalking;
} else {
	// handle AI for testing purposes
	if (!isPlayer _receiverObject) then {
		[_receiverObject] spawn {
			_obj = _this select 0;
			if (random 2 > 1) then {
				_obj setVariable ["GRAD_telephone_currentState","talking", true];
			} else {
				_obj setVariable ["GRAD_telephone_currentState","rejected", true];
				sleep 1;
				_obj setVariable ["GRAD_telephone_currentState","default", true];
			};
		};
	};

	// busy signal or rejected signal
	while {player getVariable ["GRAD_telephone_currentState","noPhone"] == "waiting"} do {
		playSound (selectRandom _busyBeeps);
		diag_log format ["callWaiting: short beep"];
		if (!_wasAlreadyRinging) then { sleep 0.55;	} else { sleep 0.35; };
	};
};

// if (DEBUG_MODE) then { diag_log format ["callWaiting: target changed status to %1", _receiverObject getVariable ["GRAD_telephone_currentState", "noPhone"]];};