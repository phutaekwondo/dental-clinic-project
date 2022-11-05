// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import Appointment from '../../../classes/appointment.mjs';
import { CheckFields } from '../../../helpers/request/request-helper';
import Patient from '../../../classes/patient.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {

	const fields = ['patient_id'] ;
	const result = CheckFields(req, fields, res);

	if (result === true) {
		var patient = await Patient.GetPatientById(req.body.patient_id);
		const result = await patient.GetAppointments();

		return res.status(200).json({result});
	}
	else{
		try{
			const result = await Appointment.GetAllAppointments();
			return res.status(200).json(result);
		}	
		catch{
			return res.status(400).json({message: 'Error getting appointments'});
		}
	}
}