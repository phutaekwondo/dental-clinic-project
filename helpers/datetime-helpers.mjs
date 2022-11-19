export function IsDateFormattedCorrect(date){

	const dateRegex = /^\d{4}-\d{2}-\d{2}$/;

	if ( !dateRegex.test(date) ) return false;

	const time = new Date(date);

	//check if date is valid
	if ( !time.getTime() ) return false;

	return true;
}

export function IsTimeFormattedCorrect(time){
	const timeRegex = /^\d{2}:\d{2}$/;

	if ( !timeRegex.test(time) ) return false;

	//check if time is valid
	const timeParts = time.split(':');
	if ( timeParts[0] > 23 || timeParts[1] > 59 ) return false;

	return true;
}