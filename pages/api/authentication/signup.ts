// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import { GetDatabase } from '../../../helpers/database/database-helper.mjs';
import { CheckFields } from '../../../helpers/request/request-helper';
import Patient from '../../../classes/patient.mjs';
import Doctor from '../../../classes/doctor.mjs';
import Admin from '../../../classes/admin.mjs';
import PersonFactory from '../../../classes/person-factory.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {
	//if get method, for testing
	if(req.method === 'GET'){
		//get database
		const db = await GetDatabase();
		//get all accounts
		// const accounts = await db.all('SELECT * FROM ACCOUNT');

		const allaccountdata = await handleGetMethod();

		return res.status(200).json(allaccountdata);
	}

	//if post request
	if(req.method !== 'POST') {
		return res.status(405).json({message: 'Only POST Method is allowed'});
	}

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

	var newPerson = await PersonFactory.NewPersonInstanceWithRole(requestBody.fname, requestBody.lname, requestBody.email, requestBody.phonenumber, true, requestBody.role);
	newPerson.RegisterAccount(requestBody.username, requestBody.password, requestBody.role);
	const result = await newPerson.InsertToDatabase();

	if (result === true ) {
		return res.status(200).json({message: 'Account created successfully'});
	}
	else{
		return res.status(400).json({message: result});
	}
}

async function handleGetMethod(){
	// return all rows in account, patient, doctor, admin table
	const db = await GetDatabase();
	const accounts = await db.all('SELECT * FROM ACCOUNT');
	const patients = await db.all('SELECT * FROM PATIENT');
	const doctors = await db.all('SELECT * FROM DOCTOR');
	const admins = await db.all('SELECT * FROM ADMIN');

	return {accounts, patients, doctors, admins};
}
