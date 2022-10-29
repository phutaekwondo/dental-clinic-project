// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import {open} from 'sqlite';
import sqlite3 from 'sqlite3';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {


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

	return res.status(200).json({requestbody});

	// check value of fileds

	// post data to database


	// return response
}