// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import {open} from 'sqlite';
import sqlite3 from 'sqlite3';
import { GetDatabase } from '../../../helpers/database/database-helper.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {
	//if get method, for testing
	if(req.method === 'GET'){
		//get database
		const db = await GetDatabase();
		//get all accounts
		const accounts = await db.all('SELECT * FROM ACCOUNT');

		return res.status(200).json(accounts);
	}

	//if post request
	if(req.method !== 'POST') {
		return res.status(405).json({message: 'Only POST Method is allowed'});
	}

	const fields = ['name', 'email', 'phonenumber','username', 'password'];

	const requestbody = JSON.parse(req.body);

	// check if all fields are present in request body
	for(const field of fields) {
		if(!requestbody[field]) {
			return res.status(400).json({message: `${field} is missing`});
		}

	}


	// check value of fileds

	// insert data into database
	// InsertNewAccountToDatabase(requestbody.name, requestbody.email, requestbody.phonenumber, requestbody.username, requestbody.password);

	// return response

	return res.status(200).json({requestbody}); // for testing
}

async function InsertNewAccountToDatabase(name, email, phonenumber, username, password) {
	// get the database
	const db = await GetDatabase();
	// insert data into database
}