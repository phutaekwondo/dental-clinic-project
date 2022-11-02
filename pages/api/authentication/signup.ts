// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import { GetDatabase } from '../../../helpers/database/database-helper.mjs';
import { CheckFields } from '../../../helpers/request/request-helper';
import Patient from '../../../classes/patient.mjs';
import Doctor from '../../../classes/doctor.mjs';
import Admin from '../../../classes/admin.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {
	const fields = ['fname', 'lname', 'email', 'phonenumber','username', 'password', 'role'];
	// check if all fields are present in request body
	if (CheckFields(req, fields, res) !== true) {
		return;
	}

	const requestBody = req.body;

	//check if requestBody.role in ('patient', 'doctor', 'admin')
	if(requestBody.role !== 'patient' && requestBody.role !== 'doctor' && requestBody.role !== 'admin'){
		return res.status(400).json({message: 'Role must be patient, doctor or admin'});
	}

	//signup hanler
	var newPerson;
	switch(requestBody.role){
		    case "patient":
				newPerson = new Patient( requestBody.fname, requestBody.lname, requestBody.email, requestBody.phonenumber, true);
				break;
		    case "doctor":
				newPerson = new Doctor( requestBody.fname, requestBody.lname, requestBody.email, requestBody.phonenumber);
				break;
			case "admin":
				newPerson = new Admin( requestBody.fname, requestBody.lname, requestBody.email, requestBody.phonenumber);
				break;
	}

	newPerson.RegisterAccount(requestBody.username, requestBody.password, requestBody.role);
	const result = await newPerson.InsertToDatabase();

	if (result === true ) {
		return res.status(200).json({message: 'Account created successfully'});
	}
	else{
		return res.status(400).json({message: result});
	}
}