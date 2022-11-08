import { NextApiRequest, NextApiResponse } from "next";
import { IsDateFormattedCorrect, IsTimeFormattedCorrect } from "./datetime-helpers.mjs";

export function CheckFields (req: NextApiRequest, fields: string[] ) {
    for (const field of fields) {
	if (!req.body[field]) {
	    return `${field} is missing in request body, suppose to has [${fields}]`;
	}
    }
    return true;
}

export function IsDatesFomarted( req: NextApiRequest, fields: string[] ) {
	//check all fields in request body are date formatted
	for (const field of fields) {
		if (!IsDateFormattedCorrect(req.body[field]) && req.body[field]) {
			return false;
		}
	}
	return true;
}

export function IsTimesFomarted( req: NextApiRequest, fields: string[] ) {
	//check all fields in request body are time formatted
	for (const field of fields) {
		if (!IsTimeFormattedCorrect(req.body[field]) && req.body[field]) {
			return false;
		}
	}
	return true;
}

export function IsDateAndTimeFormated( req: NextApiRequest, dateFields: string[], timeFields: string[] ) {
	//check all fields in request body are date and time formatted
	if (IsDatesFomarted(req, dateFields) && IsTimesFomarted(req, timeFields)) {
		return true;
	}
	return false;
}

