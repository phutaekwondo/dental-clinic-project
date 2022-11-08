import Patient from "./patient.mjs";
import Doctor from "./doctor.mjs";
import Admin from "./admin.mjs";

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

	static async GetPersonByUsername(username){/*NEED IMPLEMENT*/};

    static async GetPersonById(id, role){/*NEED IMPLEMENT*/};

    static async GetPersonsByName(fname, lname, role){/*NEED IMPLEMENT*/};

    static async GetPersonByEmail(email){/*NEED IMPLEMENT*/};

    static async GetPersonByPhoneNumber(phonenumber){/*NEED IMPLEMENT*/};

}