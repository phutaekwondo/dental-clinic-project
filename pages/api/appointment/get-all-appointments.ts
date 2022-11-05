// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import api resquest response from next
import {NextApiRequest, NextApiResponse} from 'next';
import Appointment from '../../../classes/appointment.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {
	try{
		const result = await Appointment.GetAllAppointments();
		return res.status(200).json(result);
	}	
	catch{
		return res.status(400).json({message: 'Error getting appointments'});
	}
}