import { NextApiRequest, NextApiResponse } from 'next';
import { CheckFields } from '../../../helpers/request-helper';
import { respondWithJson } from '../../../helpers/response-helper';
import PersonFactory from '../../../classes/person-factory.mjs';
import Person from '../../../classes/person.mjs';
import { GetDatabase } from '../../../helpers/database/database-helper.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {

	//check fields
	const fields = ['username'];
	const checkFieldsResult = CheckFields(req, fields);
	if (checkFieldsResult !== true) {
		return respondWithJson(res, 0, checkFieldsResult);
	}

	const username = req.body.username;


	//check if the user exists
	const account = await Person.GetAccountByUsername(username);
	if(!account) {
		return respondWithJson(res, 0, 'We do not have this account');
	}

	var person;
	try{
		person = await PersonFactory.GetPersonByUsername(username);
	}
	catch(err){
		return respondWithJson(res, 0, err);
	}

	if(!person) {
		return respondWithJson(res, 0, 'We do not have this person');
	}else{
		const detailPerson = await GetRowByIdAndRole(person.id, person.acc_role);
		var result = person;
		result.detail = detailPerson;
		return respondWithJson(res, 1, result);
	}
}

async function GetRowByIdAndRole(id, role) {
	const db = await GetDatabase();
	const table = role;
	const prefix = role.substring(0, 1) + '_';

	const result = await db.get(`select * from ${table} where ${prefix}id="${id}"`);

	return result;
}