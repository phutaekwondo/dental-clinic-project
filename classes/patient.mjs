import Person from "./person.mjs";

//a clas that inherate from Person
export default class Patient extends Person{
	hasAccount;

//constructor
	constructor(fname, lname, email, phonenumber, hasAccount){
		super(fname, lname, email, phonenumber);
		this.hasAccount = hasAccount;
	}

	async InsertToDatabase(){
		// const supResult = super.InsertToDatabase();
		// if (supResult !== true ) return supResult;
		const supRes = await super.InsertToDatabase();
		if ( supRes !== true ) return supRes;

		// insert patient to database

		return this.InsertByRole('patient');

	}
}