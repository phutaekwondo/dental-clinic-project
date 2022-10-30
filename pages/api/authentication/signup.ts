// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import {open} from 'sqlite';
import sqlite3 from 'sqlite3';
import { GetDatabase } from '../../../helpers/database/database-helper.mjs';
import { CheckFields } from '../../../helpers/request/request-helper';

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

	const fields = ['fname', 'lname', 'email', 'phonenumber','username', 'password', 'role'];
	// check if all fields are present in request body
	if (CheckFields(req, fields, res) !== true) {
		return;
	}


	// check value of fileds

	const requestbody = req.body;
	// insert data into database
	const insertResult = await InsertNewAccountToDatabase(
		requestbody.fname, 
		requestbody.lname, 
		requestbody.email, 
		requestbody.phonenumber, 
		requestbody.username, 
		requestbody.password, 
		requestbody.role
		);

	return res.status(200).json({message: insertResult});

	// return response

	// return res.status(200).json({requestbody}); // for testing
}

async function InsertNewAccountToDatabase(
	fname, 
	lname, 
	email, 
	phonenumber, 
	username, 
	password, 
	role) 
{
	// get the database
	const db = await GetDatabase();

	//check if username already exists
	const account = await db.get('SELECT * FROM ACCOUNT WHERE acc_un = ?', [username]);
	if(account) {
		return "username already exists";
	}

	//insert unsername, password and role to account table
	try {
		const result = await db.run('INSERT INTO ACCOUNT (acc_un, acc_mk, acc_role) VALUES (?, ?, ?)', 
								[username, password, role]);
	}
	catch{
		return "somthing wrong while inserting username, password, role, make sure role in (amin, doctor, patient)";
	}

	//insert fname, lname, email, phonenumber to user table
	try{
		const result2 = await db.run('INSERT INTO USER (u_fname, u_lname, u_email, u_phnu, acc_un) VALUES (?, ?, ?, ?, ?)',
								[fname, lname, email, phonenumber, username]);
	}
	catch{
		const result3 = await db.run('DELETE FROM ACCOUNT WHERE acc_un = ?', [username]);
		return "somthing wrong while inserting fname, lname, email, phonenumber";
	}

	return "Signup successfull";
}