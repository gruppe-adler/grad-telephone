_phone = player getVariable ["GRAD_telephone_radioID", objNull];

_selector = _phone getVariable ["GRAD_telephone_phonebook_current",0];
_list = _phone getVariable ["GRAD_telephone_phonebook",[]];

_return = _list select _selector select 1;

_return