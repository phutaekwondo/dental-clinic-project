import { NextApiRequest, NextApiResponse } from 'next';
import { GetDatabase } from '../../../helpers/database/database-helper.mjs';
import { CheckFields } from '../../../helpers/request/request-helper';
import Person from '../../../classes/person.mjs';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {

    //check fields
	const checkFieldsResult = CheckFields(req,['acc_un','acc_mk'] , res);
	if (checkFieldsResult !== true) {
		return res.status(200).json({message: checkFieldsResult});
	}

    const username = req.body.acc_un;
    const password = req.body.acc_mk;

    const account = await Person.GetAccountByUsername(username);
    if(!account) {
        res.status(200).json({message: 'We do not have this account'})
    }else{
        if(account.acc_mk === password) {
            res.status(200).json({message: 'Logged in successfully.', "role": account.acc_role});
        }else{
            res.status(200).json({message: 'Incorrect password'})
        }
    }
}