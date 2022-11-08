// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import { CheckFields } from '../../../helpers/request-helper';
import { respondWithJson } from '../../../helpers/response-helper';
import PersonFactory from '../../../classes/person-factory.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {
	const fields = ['name', 'email', 'phonenumber','username', 'password', 'role'];
	// check if all fields are present in request body
	const checkFieldsResult = CheckFields(req, fields);
	if (checkFieldsResult !== true) {
		return respondWithJson(res, 0, checkFieldsResult);
	}

	const requestBody = req.body;

	//check if requestBody.role in ('patient', 'doctor', 'admin')
	if(requestBody.role !== 'patient' && requestBody.role !== 'doctor' && requestBody.role !== 'admin'){
		return respondWithJson(res, 0, 'Role must be patient, doctor or admin');
	}

	var newPerson = await PersonFactory.NewPersonInstanceWithRole(requestBody.name, requestBody.email, requestBody.phonenumber, true, requestBody.role);
	newPerson.RegisterAccount(requestBody.username, requestBody.password);
	const result = await newPerson.InsertToDatabase();

	if (result === true ) {
		return respondWithJson(res, 1, 'Account created successfully');
	}
	else{
		return respondWithJson(res, 0, result );
	}
}