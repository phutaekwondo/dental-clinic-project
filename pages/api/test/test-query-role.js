
// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import request and response from nextjs
import { NextApiRequest, NextApiResponse } from 'next';
import {open} from 'sqlite';
import sqlite3 from 'sqlite3';

export default async function handler(req, res) {
	const db = await open({filename:'./database.sqlite',driver:sqlite3.Database});

	const query_result = await db.all('SELECT * FROM ROLE');
	// parse query result to json
	const json_result = JSON.stringify(query_result);

	// console.log(json_result);
	// send json result to client
	res.status(200).json(json_result);
}