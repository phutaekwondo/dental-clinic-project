import { NextApiRequest, NextApiResponse } from 'next';
import { GetDatabase } from '../../../helpers/database/database-helper.mjs';
import { CheckFields } from '../../../helpers/request/request-helper';

export default async function handler(req:NextApiRequest, res:NextApiResponse) {

    //check fields
    if ( CheckFields(req, ['acc_un','acc_mk'], res) !== true) { return; }

    const username = req.body.acc_un;
    const password = req.body.acc_mk;
    console.log(username, password);
    const db = await GetDatabase();
    if(req.method === 'POST') {
        const account = await db.get(`select * from account where acc_un="${username}"`);
        if(!account) {
            res.json({message: 'We do not have this account'})
        }else{
            if(account.acc_mk === password) {
                res.json({message: 'Logged in successfully.'})
            }else{
                res.json({message: 'Incorrect password or account!'})
            }
        }
    }else{
        res.json({message: "We only support POST method"})
    }
}