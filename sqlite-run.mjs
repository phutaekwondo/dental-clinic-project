import {open} from 'sqlite';
import sqlite3 from 'sqlite3';

async function setup(){
	const db = await open({filename:'./mydb.sqlite',driver:sqlite3.Database});
	await db.migrate({force:true})

	console.log("Database ready");
}

setup();