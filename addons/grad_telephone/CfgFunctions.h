class CfgFunctions
{
	class grad_telephone {

		class calling
		{
			file = "\grad_telephone\functions\calling";

			class callAccept;
			class callDialing;
			class callEnding;
			class callReceiving;
			class callReject;
			class callTalking;
			class callWaiting;
			class callWaitingDroppedPhone;
			class isCalling;

			class pleaseReceive;
			class setCallersPhoneFrequency;
		};

		class celltower
		{
			file = "\grad_telephone\functions\celltower";

			class cellTowerCalculateTFARMultiplicator;
			class cellTowerGetAttendeesDistance;
			class cellTowerMarkerCreate;
			class cellTowerRefreshSignalStrength;
			class cellTowerSignalStrengthCheck;
			class cellTowerSpawn;
			class isCellTowerReachable;
		};

		class core
		{
			file = "\grad_telephone\functions\core";

			class generatePhoneNumber;
			class getNativePhoneCode;
			class getNativePhoneFrequency;
			class getRadio;
			class getUniquePhoneNumber;

			class initAll { postInit = 1; };
			class initClient;
			class initServer;

			class isCellphone;
			class setNativePhoneFrequency;

			class tfarEndCall;
			class tfarStartCall;

		};

		class ied {
			file = "\grad_telephone\functions\ied";

			class callIED;
			class destroyIED;
			class programIED;
		};

		class interaction {
			file = "\grad_telephone\functions\interaction";

			class interactGiveNumber;
			class interactHasNumber;
			class interactReceiveNumber;
			class playGiveAnimation;
		}

		class settings {
			file = "\grad_telephone\functions\settings";

			class getAlarmToneForPhoneID;
			class getRingToneForPhoneID;
			class setAlarmToneForPhoneID;
			class setRingToneForPhoneID;
		};

		class ui {
			file = "\grad_telephone\functions\ui";

			class addDummyData;
			class addToPhonebookForRadioID;
			class deleteFromPhonebookForRadioID;
			class getPhonebookForRadioID;
			class isNotInContacts;
			class setPhonePhonebook;
			class showHintCall;
			class showHintUnlimited;
			class showRadioInfo;

		};


	};
};
