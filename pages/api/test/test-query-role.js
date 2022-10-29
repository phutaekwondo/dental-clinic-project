// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import {open} from 'sqlite';
import sqlite3 from 'sqlite3';
import {GetDatabase, GetDatabaseFileName} from '../../../helpers/database/database-helper.mjs';


export default async function handler(req, res) {
	// const db = await open({filename:'./database.sqlite',driver:sqlite3.Database});

	const db = await GetDatabase();

	const query_result = await db.all('SELECT * FROM ROLE');
	// res.status(200).json(pretty_json_result);

	res.status(200).json(query_result);
}