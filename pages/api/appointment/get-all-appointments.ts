// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import Appointment from '../../../classes/appointment.mjs';
import { CheckFields } from '../../../helpers/request-helper';
import { respondWithJson } from '../../../helpers/response-helper';
import Patient from '../../../classes/patient.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {
	try{
		const fields = ['patient_id'] ;
		const result = CheckFields(req, fields);
		if (result === true) {
			var patient = await Patient.GetPatientById(req.body.patient_id);
			const result = await patient.GetAppointments();
			console.log(result);
			return respondWithJson(res, 1, result);
		}
		else{
			const result = await Appointment.GetAllAppointments();
			return respondWithJson(res, 1, {result, message:'add patient_id to request body to get only patient appointments'});
		}
	}
	catch (err){
		console.log(err);
		return respondWithJson(res, 0, 'Error getting appointments');
	}
}