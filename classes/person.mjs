import { GetDatabase } from "../helpers/database/database-helper.mjs";

// a class person has all properties in patient table 
export default class Person{
	id           ;
	name         ;
	email        ;
	phonenumber  ;
	hasAccount   ;
	acc_un       ;
	acc_mk       ;
	acc_role     ;

//method
	constructor(fname, email, phonenumber, hasAccount = false){
		this.name = fname;
		this.email = email;
		this.phonenumber = phonenumber;
		this.hasAccount = false;
	};

	RegisterAccount(username, password, role){
		this.acc_un = username;
		this.acc_mk = password;
		this.acc_role = role;
	}

	async InsertAccountToDatabase(){
		const db = await GetDatabase();
		//check if username already exists
		const account = await db.get('SELECT * FROM ACCOUNT WHERE acc_un = ?', [this.acc_un]);
		if(account) {
			return "acc_un already exists";
		}

		//insert unsername, password and role to account table
		try {
			const result = await db.run('INSERT INTO ACCOUNT (acc_un, acc_mk, acc_role) VALUES (?, ?, ?)', 
									[this.acc_un, this.acc_mk, this.acc_role]);
		}
		catch{
			return "somthing wrong while inserting username, password, role, make sure role in (amin, doctor, patient)";
		}

		return true;
	}

	async InsertToDatabase(){
		if(this.hasAccount){
			if (this.acc_un && this.acc_mk && this.acc_role){
				const insertAccountResult = this.InsertAccountToDatabase();
				if (insertAccountResult !== true ) return insertAccountResult;
			}
			else{
				return "username, password, role are required. RegisterAccount(username, password, role)";
			}
		}
		return true;
		// insert person to database
	}

	async InsertByRole(role){
		const db = await GetDatabase();

		var table = role;
		var prefix = role.substring(0, 1) + '_';

		//insert fname, lname, email, phonenumber to user table
		try{
			const query = `INSERT INTO ${table} (${prefix}name, ${prefix}email, ${prefix}phnu, acc_un) 
					VALUES (\'${this.name}\', \'${this.email}\', \'${this.phonenumber}\', \'${this.acc_un}\')`;

			const result2 = await db.run( query );

			//set id for this person
			this.id = result2.lastID;
		}
		catch{
			const result3 = await db.run('DELETE FROM ACCOUNT WHERE acc_un = ?', [this.acc_un]);
			return "somthing wrong while inserting name, email, phonenumber";
		}

		return true;
	};

	async GetPropertiesByIdAndRole(id, role){
		const db = await GetDatabase();
		const table = role;
		const prefix = role.substring(0, 1) + '_';

		const person = await db.get(`select * from ${table} where ${prefix}id="${id}"`);
		if ( person ){
			this.id = person[`${prefix}id`];
			this.name = person[`${prefix}name`];
			this.email = person[`${prefix}email`];
			this.phonenumber = person[`${prefix}phnu`];
			this.acc_un = person[`acc_un`];
			return true;
		}
		else{
			return "person not found";
		}
	}
	async GetPropertiesByUsernameAndRole(username, role){
		const db = await GetDatabase();
		const table = role;
		const prefix = role.substring(0, 1) + '_';

		const person = await db.get(`select * from ${table} where acc_un="${username}"`);
		if ( person ){
			this.id = person[`${prefix}id`];
			this.name = person[`${prefix}name`];
			this.email = person[`${prefix}email`];
			this.phonenumber = person[`${prefix}phnu`];
			this.acc_un = person[`acc_un`];
		}
		else{
			return "person not found";
		}

		const account = await db.get(`select * from account where acc_un="${username}"`);
		if ( account ){
			this.acc_mk = account[`acc_mk`];
			this.acc_role = account[`acc_role`];
			return true;
		}
		else{
			return "account not found while get properties by username and role";
		}
	}

	//a static method
	static async GetAllAccounts(){
		// return all rows in account, patient, doctor, admin table
		const db = await GetDatabase();
		const accounts = await db.all('SELECT * FROM ACCOUNT');

		return accounts;
	};

	static async GetAccountByUsername(username){
		const db = await GetDatabase();
        	const account = await db.get(`select * from account where acc_un="${username}"`);

		return account;
	}

}

