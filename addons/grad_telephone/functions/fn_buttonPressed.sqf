#include "..\macros.h"

params ["_action"];

[] call GRAD_fnc_fillDummyContacts;

_currentState = player getVariable ["GRAD_telephone_currentState", "default"];

/* possible states
==================
default
dialing --> 	initial delay
waiting --> 	ringing or busy signal
receiving --> 	establishing connection (setting same frequency)
talking --> 	connection established
rejecting --> 	rejecting call and resetting everything
ending -->		frequencys are changed again, beep
scrolling		
hint
*/

switch (_currentState) do {
	case "default": {
		switch (_action) do {
			case "cancel": { ["default",3,"Cant select nothing :("] spawn GRAD_fnc_showHint;};
			case "select": { ["default",3,"Cant select nothing :("] spawn GRAD_fnc_showHint;};
			case "up": 	   { [true] spawn GRAD_fnc_showNextContact;};
			case "down":   { [false] spawn GRAD_fnc_showNextContact;};

			default {debugLog ("GRAD_telephone default: button with no action given");};
		};
	};
	case "scrolling": {
		switch (_action) do {
			case "cancel": { [] call GRAD_fnc_gotoHomescreen;};
			case "select": { 
				["scrolling",1,"Calling...",{ 
					player getVariable ["GRAD_telephone_currentState", "noPhone"] == "dialing" || 
					player getVariable ["GRAD_telephone_currentState", "noPhone"] == "waiting" ||
					player getVariable ["GRAD_telephone_currentState", "noPhone"] == "calling"
				}] spawn GRAD_fnc_showHintCondition;
				_target = call GRAD_fnc_getSelectedContactName;
				[_target] spawn GRAD_fnc_callDialing;
			};
			case "up": 	   { [true] spawn GRAD_fnc_showNextContact;};
			case "down":   { [false] spawn GRAD_fnc_showNextContact;};

			default {debugLog ("GRAD_telephone scrolling: button with no action given");};
		};
	};
	case "hint": {
		// do nothing to not add up shit
	};
	case "dialing": {
		switch (_action) do {
			case "cancel": { 
					["default",2,"Call aborted"] spawn GRAD_fnc_showHint;
					player setVariable ["GRAD_telephone_currentState", "default", true];
					[] call GRAD_fnc_gotoHomescreen;
				};
			case "select": {};
			case "up": 	   {};
			case "down": {};

			default {debugLog ("GRAD_telephone dialing: button with no action given");};
		};
	};
	case "waiting": {
		switch (_action) do {
			case "cancel": { 
					["default",2,"Call aborted"] spawn GRAD_fnc_showHint;
					player setVariable ["GRAD_telephone_currentState", "default", true];
					[] call GRAD_fnc_gotoHomescreen;
				};
			case "select": {};
			case "up": 	   {};
			case "down": {};

			default {debugLog ("GRAD_telephone waiting: button with no action given");};
		};
	};
	case "receiving": {
		switch (_action) do {
			case "cancel": {
				[] call GRAD_fnc_callReject;
			};
			case "select": { 
				[] call GRAD_fnc_callTalking;
			};
			case "up": 	   { [true] spawn GRAD_fnc_showNextContact;};
			case "down":   { [false] spawn GRAD_fnc_showNextContact;};

			default {debugLog ("GRAD_telephone receiving: button with no action given");};
		};
	};
	case "talking": {
		switch (_action) do {
			case "cancel": {
				[] call GRAD_fnc_callEnding;
			};
			case "select": { };
			case "up": 	   { };
			case "down":   { };

			default {debugLog ("GRAD_telephone receiving: button with no action given");};
		};
	};


	default {debugLog ("GRAD_telephone: currentState is default");};
};
