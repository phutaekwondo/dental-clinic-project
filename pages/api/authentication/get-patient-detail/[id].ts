import { NextApiRequest, NextApiResponse } from 'next';
import { GetDatabase } from '../../../../helpers/database/database-helper.mjs';
import { respondWithJson } from '../../../../helpers/response-helper';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {
	const p_id = req.query.id;

	try{
		const patient = await GetPatientRowById(p_id);
		if (patient) {
			return respondWithJson(res, 1, patient);
		}
	}
	catch(err){
		return respondWithJson(res, 0, err);
	}
	return respondWithJson(res, 0, {message:"We do not have this patient or some error"});
}

async function GetPatientRowById(id ) {
	const role = "patient";
	const db = await GetDatabase();
	const table = role;
	const prefix = role.substring(0, 1) + '_';

	const result = await db.get(`select * from ${table} where ${prefix}id="${id}"`);

	return result;
}