import {open} from 'sqlite';
import sqlite3 from 'sqlite3';
import {unlinkSync, existsSync} from 'fs';

async function setup(){
	const db_file_name = './database.sqlite';

	//if database file exists
	if (await existsSync(db_file_name)) 
	{
		//remove the database file
		await unlinkSync(db_file_name);
	}

	//open and connect to the database
	const db = await open({filename:db_file_name,driver:sqlite3.Database});
	await db.migrate({force:true})

	console.log("Database ready");

	//for test
	const res = await db.all('SELECT * FROM ROLE');
	console.log(res);

}

setup();