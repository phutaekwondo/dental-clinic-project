import {GetDatabase} from '../helpers/database/database-helper.mjs';

export default class Appointment{
	id;
	status; 
	p_id;
	d_id;
	s_id;
	day;
	otime;
	etime;
	place;
	room;
	desc;

	constructor(id, status, p_id, d_id, s_id, day, otime, etime, place, room, desc){
		this.id = id;
		this.status = status;
		this.p_id = p_id;
		this.d_id = d_id;
		this.s_id = s_id;
		this.day = day;
		this.otime = otime;
		this.etime = etime;
		this.place = place;
		this.room = room;
		this.desc = desc;
	}

	static QueryResultToAppointments(result ){
		var appointments = [];
		result.forEach(element => {
			var appointment = new Appointment(
				element.appoint_id,
				element.appoint_status,
				element.p_id,
				element.d_id,
				element.s_id,
				element.meet_day,
				element.meet_otime,
				element.meet_etime,
				element.meet_place,
				element.meet_room,
				element.meet_desc
			);
			appointments.push(appointment);
		});

		return appointments;
	}

	static async GetAppointmentById(id){/*NEED IMPLEMENT*/};

	static async GetAllAppointments(){
		const db = await GetDatabase();

		const result = await db.all('SELECT * FROM appointment');

		// convert result to an array of Appointment instances
		return Appointment.QueryResultToAppointments(result); 
	};
	static async GetAllAppointmentsByPatientId(p_id){
		const db = await GetDatabase();

		const result = await db.all('SELECT * FROM appointment where p_id = ?', p_id);

		// convert result to an array of Appointment instances
		return Appointment.QueryResultToAppointments(result); 
	};
};