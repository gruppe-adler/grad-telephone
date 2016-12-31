#include "\grad_telephone\define.h"

waitUntil {sleep 0.2;time > 0};
waitUntil {sleep 0.1;!(isNull player)};

IDC_NOKIA3310STR_CONTACT_NAME_ID = IDC_NOKIA3310STR_CONTACT_NAME;


player addEventHandler ["InventoryClosed", {


       	// disable all the phone custom stuff
        if (!([player] call GRAD_fnc_isCellphone)) then {
          	// end all connections
          	if (
          		(player getVariable ["GRAD_telephone_currentState", "noPhone"] == "talking") ||
          		(player getVariable ["GRAD_telephone_currentState", "noPhone"] == "waiting") ||
          		(player getVariable ["GRAD_telephone_currentState", "noPhone"] == "dialing")
          		) then {
          			["default",2,"Ended Call"] spawn GRAD_fnc_showHint;
          		};

			player setVariable ["GRAD_telephone_currentState", "default", true];
			player setVariable ["GRAD_telephone_currentPartner", "", true];

			["preventChannelSwitchEH", "OnSWchannelSet", objNull] call TFAR_fnc_removeEventHandler;
        } else {
        	["preventChannelSwitchEH", "OnSWchannelSet", {
		    	[(call TFAR_fnc_activeSwRadio), 1] call TFAR_fnc_setSwChannel;
			}, Player] call TFAR_fnc_addEventHandler;
			[(call TFAR_fnc_activeSwRadio), 2] call TFAR_fnc_setSwStereo;
			[player] call GRAD_fnc_setNativePhoneFrequency;
			[player, (call TFAR_fnc_activeSwRadio)] remoteExec ["GRAD_fnc_getUniquePhoneNumber", 2, false];
    	};
}];


['suppressRadioHint', 'OnRadioOpen', { 

	if ([player] call GRAD_fnc_isCellphone) then { 
		[] call GRAD_fnc_restoreDisplay;
	}; 

}, player] call TFAR_fnc_addEventHandler; 

// suppress radio hint when transmitting if phone used
['suppressRadioHint', 'OnTangent', { 

	if ([player] call GRAD_fnc_isCellphone) then { 
		call TFAR_fnc_HideHint; diag_log format ['hiding hint'];
		[([player] call GRAD_fnc_getRadio), -1] call GRAD_fnc_showRadioInfo;
	}; 

}, player] call TFAR_fnc_addEventHandler; 


// setup phone radio when received (mono ear, homescreen)
["addRadioSpecifications", "OnRadiosReceived", {

	if ([player] call GRAD_fnc_isCellphone) then {

		[(call TFAR_fnc_activeSwRadio), 2] call TFAR_fnc_setSwStereo;
		[player] call GRAD_fnc_setNativePhoneFrequency;
		// prevent channel switching (always 1)
		["preventChannelSwitchEH", "OnSWchannelSet", {
		    [(call TFAR_fnc_activeSwRadio), 1] call TFAR_fnc_setSwChannel;
		}, Player] call TFAR_fnc_addEventHandler;
		[player, (call TFAR_fnc_activeSwRadio)] remoteExec ["GRAD_fnc_getUniquePhoneNumber", 2, false];
	};

}, player] call TFAR_fnc_addEventHandler;


///// INTERACTION

//add interaction nodes
[{!isNull player}, {

    _action = [
    	"interactGiveNumber", 
    	"Give phone number", 
    	"grad_telephone\data\give.paa", 
    	{[] call GRAD_fnc_interactGiveNumber;}, 
    	{([player] call GRAD_fnc_isCellphone)}

    ] call ace_interact_menu_fnc_createAction;


    ["CAManBase",0,["ACE_MainActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;
}, []] call CBA_fnc_waitUntilAndExecute;