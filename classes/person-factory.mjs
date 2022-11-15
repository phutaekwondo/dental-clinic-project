import Patient from "./patient.mjs";
import Doctor from "./doctor.mjs";
import Admin from "./admin.mjs";
import Person from "./person.mjs";

// the purpose of this class is to create new instance of person, admin, doctor, patient
// to help on many circumstances

export default class PersonFactory {
    static async NewPersonInstanceWithRole(name, email, phonenumber, hasAccount, role) {

        var newPerson;
        switch (role) {
            case "patient":
                newPerson = new Patient(name, email, phonenumber, hasAccount);
                break;
            case "doctor":
                newPerson = new  Doctor(name, email, phonenumber);
                break;
            case "admin":
                newPerson = new   Admin(name, email, phonenumber);
                break;
        }

        return newPerson;
    }

	static async GetPersonByUsername(username){
        //get the account
        const account = await Person.GetAccountByUsername(username);
        if (!account) return "BACKEND: no account";
        //get the role
        const role = account.acc_role;
        if (!role) return "BACKEND: no role";
        //get the person by username and role
        var person;
        switch (role) {
            case "patient":
                person = new Patient();
                break;
            case "doctor":
                person = new  Doctor();
                break;
            case "admin":
                person = new   Admin();
                break;
        }

        const getPropResult = await person.GetPropertiesByUsernameAndRole(username, role);

        if ( getPropResult !== true ) return getPropResult;

        console.log(person);
        //return the person
        return person;
    };

    static async GetPersonById(id, role){/*NEED IMPLEMENT*/};

    static async GetPersonsByName(fname, lname, role){/*NEED IMPLEMENT*/};

    static async GetPersonByEmail(email){/*NEED IMPLEMENT*/};

    static async GetPersonByPhoneNumber(phonenumber){/*NEED IMPLEMENT*/};

}