// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import { CheckFields, IsDateAndTimeFormatted} from '../../../helpers/request-helper';
import { respondWithJson } from '../../../helpers/response-helper';
import Patient from '../../../classes/patient.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {
	// purpose: patient make appointment and store that appointment in db

	// check fields
	const fields = [ 'patient_id', 'day','time','description' ] ;

	// check date and time format
	if ( IsDateAndTimeFormatted(req, ['day'], ['time']) !== true ) {
		return respondWithJson(res, 0, "Date and time format is not correct");
	}
	
	
	// check if all fields are present in request body
	const result = CheckFields(req, fields);
	if (result !== true) {
		return respondWithJson(res, 0, result);
	}

	try{
		// get the patient by id
		const patient = await Patient.GetPatientById(req.body.patient_id);
		// the patient make apoointment
		const makeAppointmentResult = await patient.MakeAppointment(req.body.day,req.body.time,req.body.description);

		if (makeAppointmentResult === true) {
			respondWithJson(res, 1, 'Appointment made successfully');
		}
		else
		{
			respondWithJson(res, 0, {result: 'fail', 'hint': 'please check patient_id'});
		}
	}
	catch(error){
		respondWithJson(res, 0, error);
	}
}