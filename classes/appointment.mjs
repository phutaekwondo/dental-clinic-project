import {GetDatabase} from '../helpers/database/database-helper.mjs';

export default class Appointment{
	id;
	status; 
	p_id;
	d_id;
	s_id;
	day;
	time;
	place;
	room;
	desc;

	constructor(id, status, p_id, d_id, s_id, day, time, place, room, desc){
		this.id = id;
		this.status = status;
		this.p_id = p_id;
		this.d_id = d_id;
		this.s_id = s_id;
		this.day = day;
		this.time = time;
		this.place = place;
		this.room = room;
		this.desc = desc;
	}

	static async GetAppointmentById(id){/*NEED IMPLEMENT*/};
	static async GetAllAppointments(){
		const db = await GetDatabase();

		const result = await db.all('SELECT * FROM appointment');
		return result;
	};
};