import { NextApiRequest, NextApiResponse } from 'next';
import { CheckFields } from '../../../helpers/request-helper';
import { respondWithJson } from '../../../helpers/response-helper';
import Record from '../../../classes/record.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {

	//check fields
	var fields = ['p_id'];
	var checkFieldsResult = CheckFields(req, fields);
	if (checkFieldsResult !== true) {
		return respondWithJson(res, 0, checkFieldsResult);
	}

	var p_id = req.body.p_id;

	var data = await Record.GetDataFor_RecordsOfPatientAPI(p_id);

	if(data == "rec_id not found") {
		return respondWithJson(res, 2, "rec_id not found");
	}
    else if(data == "p_id not found") {
		return respondWithJson(res, 0, "p_id not found");
    }
    else if(data == "d_id not found") {
		return respondWithJson(res, 3, "d_id not found");
    }
    else{
		return respondWithJson(res, 1, data);
	}
}