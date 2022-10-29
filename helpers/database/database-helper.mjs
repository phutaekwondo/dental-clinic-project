
import {open} from 'sqlite';
import sqlite3 from 'sqlite3';

const db_file_name = './database.sqlite';

export async function GetDatabase() {
    return await open({filename:db_file_name,driver:sqlite3.Database});
}

export function GetDatabaseFileName() {
    return db_file_name;
}
