// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import { CheckFields, IsDateAndTimeFormatted} from '../../../helpers/request-helper';
import { respondWithJson } from '../../../helpers/response-helper';
import Appointment from '../../../classes/appointment.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {

	//check fields
	const fields = [ 
		"appointment_id",
		"status", 
		"p_id",
		"d_id",
		"s_id",
		"day",
		"otime",
		"etime",
		"place",
		"room",
		"desc"
	];

	//check date time format
	if (IsDateAndTimeFormatted(req, ['day'], ['otime', 'etime']) !== true) {
		return respondWithJson(res, 0, "Date and time format is not correct");
	}

	//get fields in request body
	const fieldsInRequestBody = GetFieldsInRequestBody(req);

	// 	NEED TO CHECK IF P_ID EXISTS IN DB


	// get appointment instance
	var appointment;
	try{
		appointment = await Appointment.GetAppointmentById(req.body.appointment_id)
	}
	catch(err){
		return respondWithJson(res, 0, err);
	}

	if (!appointment) {
		return respondWithJson(res, 0, "Appointment not found");
	}

	// set properties of appointment instance to request body
	for (let i = 0; i < fieldsInRequestBody.length; i++) {
		appointment[fieldsInRequestBody[i]] = req.body[fieldsInRequestBody[i]];
	}

	// update appointment in db
	try{
		await appointment.UpdateInDatabase();
	}
	catch(error){
		console.log(error);
		return respondWithJson(res, 0, error);
	}

	// a string that contain all fields that are updated
	let updatedFields = '';
	for (let i = 0; i < fieldsInRequestBody.length; i++) {
		if (fieldsInRequestBody[i] !== 'appointment_id') {
			updatedFields += fieldsInRequestBody[i] + ', ';
		}
	}
	// return result
	return respondWithJson(res, 1,  "Update successfully in " + updatedFields );
}

function GetFieldsInRequestBody(req:NextApiRequest){
	const fields = Object.keys(req.body);
	let notNullFields = [];
	for (let i = 0; i < fields.length; i++) {
		if (req.body[fields[i]] !== null) {
			notNullFields.push(fields[i]);
		}
	}

	return notNullFields;
}
