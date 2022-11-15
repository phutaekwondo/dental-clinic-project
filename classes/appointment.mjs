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

		//check date format
		if ( day && !Appointment.IsDateFormattedCorrect(day) ) throw 'Date is not formatted correctly';
		//checl time format
		if ( otime && !Appointment.IsTimeFormattedCorrect(otime) ) throw 'Start time is not formatted correctly';
		if ( etime && !Appointment.IsTimeFormattedCorrect(etime) ) throw 'End time is not formatted correctly';

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

	async InsertToDatabase(){
		const db = await GetDatabase();

		try {
			const result = await db.run(
				'INSERT INTO appointment (appoint_status, p_id, d_id, s_id, meet_day, meet_otime, meet_etime, meet_place, meet_room, meet_desc) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
				this.status, this.p_id, this.d_id, this.s_id, this.day, this.otime, this.etime, this.place, this.room, this.desc);

			this.id = result.lastID;
		}
		catch{
			throw "Inserting appointment to database failed";
		}
		return true;
	}

	async UpdateInDatabase(){
		const db = await GetDatabase();

		//write a query that update appointment properties which are not null
		var query = `UPDATE appointment SET `;
		var setlist = [];
		if ( this.status ) setlist.push( `appoint_status = \'${this.status}\'`);
		if ( this.p_id ) setlist.push( `p_id = ${this.p_id}`);
		if ( this.d_id ) setlist.push( `d_id = ${this.d_id}`);
		if ( this.s_id ) setlist.push( `s_id = ${this.s_id}`);
		if ( this.day ) setlist.push( `meet_day = \'${this.day}\'`);
		if ( this.otime ) setlist.push( `meet_otime = \'${this.otime}\'`);
		if ( this.etime ) setlist.push( `meet_etime = \'${this.etime}\'`);
		if ( this.place ) setlist.push( `meet_place = \'${this.place}\'`);
		if ( this.room ) setlist.push( `meet_room = \'${this.room}\'`);
		if ( this.desc ) setlist.push( `meet_desc = \'${this.desc}\'`);
		query += setlist.join(', ');
		query += ` WHERE appoint_id = ${this.id}`;

		await db.run(query);
		return true;
	}

	async SyncToDatabase(){
		const db = await GetDatabase();

		if ( !this.id ) {
				this.InsertToDatabase();
		}
		else {
			this.UpdateInDatabase();
		}
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

	static async GetAppointmentById(id){
		const appointment = new Appointment();
		const db = await GetDatabase();

		const queryResult = await db.get('SELECT * FROM appointment WHERE appoint_id = ?', id);

		if ( !queryResult ) throw 'Appointment not found';

		appointment.id = queryResult.appoint_id;
		appointment.status = queryResult.appoint_status;
		appointment.p_id = queryResult.p_id;
		appointment.d_id = queryResult.d_id;
		appointment.s_id = queryResult.s_id;
		appointment.day = queryResult.meet_day;
		appointment.otime = queryResult.meet_otime;
		appointment.etime = queryResult.meet_etime;
		appointment.place = queryResult.meet_place;
		appointment.room = queryResult.meet_room;
		appointment.desc = queryResult.meet_desc;

		return appointment;
	};

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

	static IsDateFormattedCorrect(date){

		const dateRegex = /^\d{4}-\d{2}-\d{2}$/;

		if ( !dateRegex.test(date) ) return false;

		const time = new Date(date);

		//check if date is valid
		if ( !time.getTime() ) return false;

		return true;
	}

	static IsTimeFormattedCorrect(time){
		const timeRegex = /^\d{2}:\d{2}$/;

		if ( !timeRegex.test(time) ) return false;

		//check if time is valid
		const timeParts = time.split(':');
		if ( timeParts[0] > 23 || timeParts[1] > 59 ) return false;

		return true;
	}
};