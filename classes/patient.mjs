import Person from "./person.mjs";

//a clas that inherate from Person
export default class Patient extends Person{
	hasAccount;

//constructor
	constructor(name,  email, phonenumber, hasAccount){
		super(name,  email, phonenumber);
		this.hasAccount = hasAccount;
	}

	RegisterAccount(username, password){
		super.RegisterAccount(username, password, 'patient');
	}

	async InsertToDatabase(){
		// const supResult = super.InsertToDatabase();
		// if (supResult !== true ) return supResult;
		const supRes = await super.InsertToDatabase();
		if ( supRes !== true ) return supRes;

		// insert patient to database

		return this.InsertByRole('patient');
	}

	async GetAppointments(){
		if ( this.id){
			const db = await GetDatabase();
			const appointments = await db.all('SELECT * FROM APPOINTMENT WHERE p_id = ?', [this.id]);
			return appointments;
		}
		return "No id of patient instance"; 
	}

	static async GetPatientById(id){
		var patient = new Patient();
		patient.GetPrpertiesByIdAndRole(id, 'patient');
		return patient;
	}
}