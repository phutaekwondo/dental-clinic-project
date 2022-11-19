import { NextApiRequest, NextApiResponse } from 'next';
import { CheckFields } from '../../../helpers/request-helper';
import { respondWithJson } from '../../../helpers/response-helper';
import PersonFactory from '../../../classes/person-factory.mjs';
import Person from '../../../classes/person.mjs';

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

	const person = await PersonFactory.GetPersonByUsername(username);

	if(!person) {
		return respondWithJson(res, 0, 'We do not have this person');
	}else{
		return respondWithJson(res, 1, person);
	}
}