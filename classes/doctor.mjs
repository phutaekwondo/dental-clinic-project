import Person from "./person.mjs";

//a clas that inherate from Person
export default class Doctor extends Person{
	hasAccount;

//constructor
	constructor(name,  email, phonenumber){
		super(name,  email, phonenumber);
		this.hasAccount = true;
	}

	RegisterAccount(username, password){
		super.RegisterAccount(username, password, 'doctor');
	}

	async InsertToDatabase(){
		// const supResult = super.InsertToDatabase();
		// if (supResult !== true ) return supResult;
		const supRes = await super.InsertToDatabase();
		if ( supRes !== true ) return supRes;

		// insert patient to database

		return this.InsertByRole('doctor');

	}
}