
// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import { NextApiRequest, NextApiResponse } from 'next';
//import database helper
import {GetDatabase, GetDatabaseFileName} from '../../../helpers/database/database-helper.mjs';


export default async function handler(req:NextApiRequest, res:NextApiResponse) {

	// get the database
	const db = await GetDatabase();


	// use the GET method to get all the rows from the TRASH table
	if (req.method === 'GET') {
		// query all data from TRASH table
		const query_result = await db.all('SELECT * FROM TRASH');

		// respose the result
		return res.status(200).json(query_result);
	}
	//use the POST method to insert a new row into the TRASH table
	else if (req.method === 'POST') {
		// get the name from request body
		const requestBody = JSON.parse(req.body);
		const name = requestBody.name;

		// insert the data into TRASH table
		await db.run('INSERT INTO TRASH (t_name) VALUES (?)', [name]);
		// INSERT INTO TRASH (t_name) VALUES('name2')

		// response the result
		return res.status(200).json({message: 'Insert successfully', name});
	}
}