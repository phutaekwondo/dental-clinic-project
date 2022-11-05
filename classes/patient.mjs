import Person from "./person.mjs";
import { GetDatabase } from "../helpers/database/database-helper.mjs";
import Appointment from "./appointment.mjs";

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
			const result = await Appointment.GetAllAppointmentsByPatientId(this.id);
			return result;
		}
		return "No id of patient instance"; 
	}

	static async GetPatientById(id){
		var patient = new Patient();
		const result = await patient.GetPrpertiesByIdAndRole(id, 'patient');
		if ( result !== true ) console.log(result);
		return patient;
	}
}