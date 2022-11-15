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

<<<<<<< HEAD
=======
	async GetAppointments(){
		if ( this.id){
			const result = await Appointment.GetAllAppointmentsByPatientId(this.id);
			return result;
		}
		return "No id of patient instance"; 
	}

	async MakeAppointment(day, time, description){
		const appointment = new Appointment( 
			null,
			'waiting',
			this.id,
			null,
			null,
			day,
			time,
			null,
			null,
			null,
			description
		);
		const result = await appointment.InsertToDatabase();
		return result;
	}

	static async GetPatientById(id){
		var patient = new Patient();
		const result = await patient.GetPropertiesByIdAndRole(id, 'patient');

		if ( result !== true ) console.log(result); // if patient not found

		// check if patient has account
		if ( patient.acc_un){
			patient.hasAccount = true;

			//get the account of patient
			const acc = await Person.GetAccountByUsername(patient.acc_un);
			patient.acc_mk = acc.acc_mk;
			patient.acc_role = acc.acc_role;
		}

		return patient;
	}

	static async GetPatientByUsername(username){
		var patient = new Patient();
		const result = await patient.GetPropertiesByUsernameAndRole(username, 'patient');

		if ( result !== true ) console.log(result); // if patient not found

		// check if patient has account
		if ( patient.acc_un){
			patient.hasAccount = true;

			//get the account of patient
			const acc = await Person.GetAccountByUsername(patient.acc_un);
			patient.acc_mk = acc.acc_mk;
			patient.acc_role = acc.acc_role;
		}

		return patient;
>>>>>>> 3560a6aeca0e51faa4e7aa82fbe6b2965cbb8304
	}
}